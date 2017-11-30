/* Same process as m4_singer_songs_table.sql file */
CREATE TABLE temp_title_songs (
	song_id varchar(15),
	c_movie_id varchar(15)
);
#c is for cinemalytics

CREATE TABLE temp_titles (
	c_movie_id varchar(15),
	imdb_id varchar(10),
	primary_title varchar(60),
	original_title varchar(60),
	genre varchar(15),
	release_year int
);

CREATE TABLE Title_Songs (
	title_id varchar(10),
	song_id varchar(15),
	PRIMARY KEY (title_id, song_id)
);

\copy temp_title_songs from C:/Users/Peter/Documents/FALL2017/Database/cinemalytics-with-headers/title_songs.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');
\copy temp_titles from C:/Users/Peter/Documents/FALL2017/Database/cinemalytics-with-headers/titles.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

insert into title_songs select distinct tt.imdb_id, tts.song_id 
						from temp_title_songs tts 
						join temp_titles tt on tts.c_movie_id = tt.c_movie_id
						where tt.imdb_id is not null and tts.song_id is not null;

drop table temp_titles;

drop table temp_title_songs;