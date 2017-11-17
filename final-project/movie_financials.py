import psycopg2
import sys, os, configparser, csv
from pyspark import SparkConf, SparkContext

log_path = "/home/hadoop/logs/" # don't change this
aws_region = "us-east-1"  # don't change this
s3_bucket = "cs327e-fall2017-final-project" # don't change this
the_numbers_files = "s3a://" + s3_bucket + "/the-numbers/*" # dataset for milestone 3

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

def parse_year(fields):
    date = fields.split("/")
    year = int(date[2])

    return (year)

def parse_genre(fields):
    if fields == "Thriller/Suspense":
        return ("Thriller")
    elif fields == "Black Comedy":
        return ("Comedy")
    elif fields == "Romantic Comedy":
        return ("Romance")
    elif len(fields) > 0:
        genre = fields.strip()
        return (genre)
    return ("")


def parse_money(fields):
    if len(fields) > 0:
        total = fields.replace("$", "").replace(",", "").replace('\"', '').strip()
        return (total)
    else:
        return (-1)

def parse_line(line):
    # add logic for parsing and cleaning the fields as specified in step 4 of assignment sheet

    fields = line.split("\t")
    release_year = int (parse_year(fields[0]))
    movie_title = fields[1].upper().strip().encode('utf-8')
    genre = parse_genre(fields[2])
    budget = int (parse_money(fields[3].strip()))
    box_office = int (parse_money(fields[4].strip()))
    
    return (release_year, movie_title, genre, budget, box_office)  
  
init() 
base_rdd = sc.textFile(the_numbers_files)
mapped_rdd = base_rdd.map(parse_line) 
print_rdd(mapped_rdd, "mapped_rdd")

select_stmt = ""

def save_to_db(list_of_tuples):
  
    conn = psycopg2.connect(database="imdb", user="master", password="RDSkey4327", host="cs327epgrds.cjskz2oehjoj.us-west-2.rds.amazonaws.com", port="5432")
    conn.autocommit = True

    for tupl in list_of_tuples:
        release_year, movie_title, genre, budget, box_office = tupl

        select_stmt = "select tb.title_id, tb.primary_title from title_basics tb join title_genres tg on tb.title_id = tg.title_id where tb.start_year = %s and UPPER(tb.primary_title) = %s"
        cur = conn.cursor()
        cur.execute(select_stmt, (release_year, movie_title))
        update_stmt = ""
        
        rows = cur.fetchall()

        if len(rows) == 1:
            update_stmt = "INSERT INTO Title_Financials (title_id, budget, box_office) VALUES (%s, %s, %s)"
        elif len(rows) > 1:
            if box_office > 0:
                select_stmt += "and tb.title_type <> 'tvEpisode'"
                cur.execute(select_stmt, (release_year, movie_title))
            else:
                select_stmt += "and tg.genre = %s"
                cur.execute(select_stmt, (release_year, movie_title, genre))
            rows = cur.fetchall()

            
            update_stmt = "INSERT INTO Title_Financials (title_id, budget, box_office) VALUES (%s, %s, %s)"
        if len(rows) != 0:
            try:
                # Add logic to perform insert statement (step 7)
                cur.execute(update_stmt, (rows[0][0], budget, box_office))    

            except Exception as e:
                print "Error in save_to_db: ", e.message


    
    # add logic to look up the title_id in the database as specified in step 5 of assignment sheet
    # add logic to write out the financial record to the database as specified in step 5 of assignment sheet
   
    cur.close()
    conn.close()
  
  
mapped_rdd.foreachPartition(save_to_db)

# free up resources
sc.stop() 
