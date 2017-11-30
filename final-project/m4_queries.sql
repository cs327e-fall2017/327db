/*Finds correlation between the title's start year and song duration*/
CREATE VIEW v_year_song_duration AS
	SELECT tb.start_year, s.song_duration
	FROM title_basics tb JOIN title_songs ts ON tb.title_id = ts.title_id 
	JOIN songs s ON ts.song_id = s.song_id
	ORDER BY tb.start_year desc;
	

/* How many minutes of total music are in the database by gender?
Is there gender bias? */
CREATE VIEW v_gender_song_lengths AS
	SELECT pb.gender, SUM(s.song_duration)
	FROM person_basics pb JOIN singer_songs ss ON pb.person_id=ss.person_id
	JOIN songs s ON s.song_id=ss.song_id
	GROUP BY pb.gender;