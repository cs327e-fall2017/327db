CREATE TABLE Temp_Singer_Songs (
	person_id varchar(10),
	song_id varchar(15)
);

CREATE TABLE Temp_Persons (
	person_id varchar(10),
	primary_name varchar(50),
	gender char(1),
	dob varchar(10)
);

CREATE TABLE Singer_Songs (
	person_id varchar(10),
	song_id varchar(15),
	PRIMARY KEY (person_id, song_id)
);

\copy temp_singer_songs from C:/Users/Peter/Documents/FALL2017/Database/cinemalytics-with-headers/singer_songs.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy temp_persons from C:/Users/Peter/Documents/FALL2017/Database/cinemalytics-with-headers/persons.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

insert into singer_songs select * from temp_singer_songs where person_id IN (select person_id from temp_persons);

drop table temp_singer_songs;

drop table temp_persons;