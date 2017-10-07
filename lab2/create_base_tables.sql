\c dev

drop database if exists imdb;

create database imdb;

\c imdb


DROP TABLE if exists title_basics;
CREATE TABLE if not exists title_basics (
  title_id varchar(10) PRIMARY KEY,
  title_types varchar(12),
  primary_title varchar(400),
  original_title varchar(400),
  is_adult boolean,
  start_year int,
  end_year int,
  runtime_minutes int 
);

DROP TABLE if exists person_basics;
CREATE TABLE if not exists person_basics (
  person_id varchar(10) PRIMARY KEY,
  primary_name char(105),
  birth_year int,
  death_year int
);

DROP TABLE if exists title_episodes;
CREATE TABLE if not exists title_episodes (
  title_id varchar(10) PRIMARY KEY,
  parent_title varchar(10),
  season_num int,
  episode_num int,
  FOREIGN KEY (title_id) REFERENCES title_basics (title_id) ON DELETE CASCADE,
  FOREIGN KEY (parent_title) REFERENCES title_basics (title_id) ON DELETE CASCADE
);

DROP TABLE if exists title_ratings;
CREATE TABLE if not exists title_ratings (
  title_id char(9) PRIMARY KEY,
  average_rating numeric,
  num_votes int,
  FOREIGN KEY (title_id) REFERENCES title_basics (title_id) ON DELETE CASCADE
);

DROP TABLE if exists directors;
CREATE TABLE if not exists directors (
  title_id char(9),
  person_id char(9),
  PRIMARY KEY (title_id, person_id),
  FOREIGN KEY (title_id) REFERENCES title_basics (title_id) ON DELETE CASCADE,
  FOREIGN KEY (person_id) REFERENCES person_basics (person_id) ON DELETE CASCADE
);

DROP TABLE if exists writers;
CREATE TABLE if not exists writers (
  title_id char(9),
  person_id char(9),
  PRIMARY KEY (title_id, person_id),
  FOREIGN KEY (title_id) REFERENCES title_basics (title_id) ON DELETE CASCADE,
  FOREIGN KEY (person_id) REFERENCES person_basics (person_id) ON DELETE CASCADE
);

DROP TABLE if exists principals;
CREATE TABLE if not exists principals (
  title_id char(9),
  person_id char(9),
  PRIMARY KEY (title_id, person_id)
  /*FOREIGN KEY (title_id) REFERENCES title_basics (title_id) ON DELETE CASCADE,
  FOREIGN KEY (person_id) REFERENCES person_basics (person_id) ON DELETE CASCADE*/
);

DROP TABLE if exists stars;
CREATE TABLE if not exists stars (
  person_id char(9),
  title_id char(9),
  PRIMARY KEY (person_id, title_id)
  /*FOREIGN KEY (person_id) REFERENCES person_basics (person_id) ON DELETE CASCADE,
  FOREIGN KEY (title_id) REFERENCES title_basics (title_id) ON DELETE CASCADE*/
);

DROP TABLE if exists person_professions;
CREATE TABLE if not exists person_professions (
  person_id char(9),
  professions varchar(25),
  PRIMARY KEY (person_id, professions),
  FOREIGN KEY (person_id) REFERENCES person_basics (person_id) ON DELETE CASCADE
);

DROP TABLE if exists title_genres;
CREATE TABLE if not exists title_genres (
  title_id char(9),
  genre varchar(11),
  PRIMARY KEY (title_id, genre),
  FOREIGN KEY (title_id) REFERENCES title_basics (title_id) ON DELETE CASCADE
);