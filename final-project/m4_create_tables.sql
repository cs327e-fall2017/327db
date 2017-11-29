/* song_id max_length from excel file = 8
*/

CREATE TABLE Songs (
	song_id varchar(15),
	song_title varchar(60),
	song_duration real,
	PRIMARY KEY (song_id)
);


CREATE TABLE Title_Songs (
	title_id varchar(10),
	song_id varchar(15),
	PRIMARY KEY (title_id, song_id)
);


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