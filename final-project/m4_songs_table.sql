/* Initialize table */
CREATE TABLE Songs (
	song_id varchar(15),
	song_title varchar(60),
	song_duration real,
	PRIMARY KEY (song_id)
);

/* Load records into table from csv file */
\copy songs from C:/Users/Peter/Documents/FALL2017/Database/cinemalytics-with-headers/songs.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');
