/*Finds correlation between the title's start year and song duration*/
CREATE VIEW v_year_song_duration AS
	SELECT tb.start_year, s.song_duration
	FROM title_basics tb JOIN title_songs ts ON tb.title_id = ts.title_id 
	JOIN songs s ON ts.song_id = s.song_id
	ORDER BY tb.start_year desc;