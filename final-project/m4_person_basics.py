import psycopg2
import sys, os, configparser, csv
from pyspark import SparkConf, SparkContext

log_path = "/home/hadoop/logs/" # don't change this
aws_region = "us-east-1"  # don't change this
s3_bucket = "cs327e-fall2017-final-project" # don't change this
the_numbers_files = "s3a://" + s3_bucket + "/cinemalytics/*" # dataset for milestone 3

persons_file = "s3a://" + s3_bucket + "/movielens/persons.csv"
singer_songs_file = "s3a://" + s3_bucket + "/movielens/singer_songs.csv"

# global variable sc = Spark Context
sc = SparkContext()

# global variables for RDS connection
rds_config = configparser.ConfigParser()
rds_config.read(os.path.expanduser("~/config"))
rds_database = rds_config.get("default", "database") 
rds_user = rds_config.get("default", "user")
rds_password = rds_config.get("default", "password")
rds_host = rds_config.get("default", "host")
rds_port = rds_config.get("default", "port")

def init():
    # set AWS access key and secret account key
    cred_config = configparser.ConfigParser()
    cred_config.read(os.path.expanduser("~/.aws/credentials"))
    access_id = cred_config.get("default", "aws_access_key_id") 
    access_key = cred_config.get("default", "aws_secret_access_key") 
    
    # spark and hadoop configuration
    sc.setSystemProperty("com.amazonaws.services.s3.enableV4", "true")
    hadoop_conf=sc._jsc.hadoopConfiguration()
    hadoop_conf.set("fs.s3a.impl", "org.apache.hadoop.fs.s3a.S3AFileSystem")
    hadoop_conf.set("com.amazonaws.services.s3.enableV4", "true")
    hadoop_conf.set("fs.s3a.access.key", access_id)
    hadoop_conf.set("fs.s3a.secret.key", access_key)
    os.environ['PYSPARK_SUBMIT_ARGS'] = "--packages=org.apache.hadoop:hadoop-aws:2.7.3 pyspark-shell"

################## general utility function ##################################

def print_rdd(rdd, logfile):
  f = open(log_path + logfile, "w") 
  results = rdd.collect() 
  counter = 0
  for result in results:
    counter = counter + 1
    f.write(str(result) + "\n")
    if counter > 30:
      break
  f.close()
  
################## process the-numbers dataset #################################

def parse_year(full_date):
    date = full_date.strip().split("/")
    year = int(date[0])

    return (year)


def persons_parse_line(line):
    # add logic for parsing and cleaning the fields as specified in step 4 of assignment sheet

    fields = line.split(",")
    person_id = fields[0].strip()
    primary_name = fields[1].strip()
    gender = fields[2].strip()
    year = parse_year(fields[3])
    
    return (person_id, primary_name, gender, year)  
  
init() 
base_p_rdd = sc.textFile(persons_file)
mapped_p_rdd = base_p_rdd.map(persons_parse_line) 

print_rdd(mapped_p_rdd, "mapped_p_rdd")


def singer_songs_parse_line(line):
    # add logic for parsing and cleaning the fields as specified in step 4 of assignment sheet

    fields = line.split(",")
    person_id = fields[0].strip()
    song_id = fields[1].strip()

    return (person_id, song_id)  

base_ss_rdd = sc.textFile(persons_file)
mapped_ss_rdd = base_ss_rdd.map(singer_songs_parse_line) 

print_rdd(mapped_ss_rdd, "mapped_ss_rdd")


ss_collection = base_ss_rdd.collect()
person_id_lst = []
for tupl in ss_collection:
    person_id_lst.append(tupl[0])


def save_rating_to_db(list_of_tuples):
  conn = psycopg2.connect(database=rds_database, user=rds_user, password=rds_password, host=rds_host, port=rds_port)
  conn.autocommit = True
  cur = conn.cursor()

  for tupl in list_of_tuples:
    person_id, primary_name, gender, year = tupl
    
    #print "imdb_id_str = " + imdb_id_str
    #print "avg_rating = " + str(avg_rating)
    #update_stmt = "update title_ratings set movielens_rating = " + str(avg_rating) + " where title_id = '" + imdb_id_str + "'" 
    #print "update_stmt = " + update_stmt + "\n"

    update_stmt = "INSERT INTO Person_Basics (person_id, primary_name, birth_year, gender) VALUES (%s, %s, %s, %s)"

    if person_id in person_id_lst:
        try:
            cur.execute(update_stmt, (person_id, primary_name, gender, year))
        except Exception as e:
            print ("Error in save_rating_to_db: ", e.message)

  
# Saves all data to the RDS instance
base_p_rdd.foreachPartition(save_rating_to_db)


# free up resources
sc.stop()