/* song_id max_length from excel file = 8
*/

CREATE TABLE Songs (
	song_id varchar(15),
	song_title varchar(60),
	song_duration real,
	PRIMARY KEY (song_id)
);


CREATE TABLE Title_Songs (
	title_id varchar(15),
	song_id varchar(15),
	PRIMARY KEY (title_id, song_id)
);


CREATE TABLE Singer_Songs (
	person_id varchar(15),
	song_id varchar(15),
	PRIMARY KEY (person_id, song_id)
);
