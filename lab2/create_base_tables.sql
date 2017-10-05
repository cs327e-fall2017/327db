/*\c dev

drop database if exists imdb;

create database imdb;

\c imdb
*/

create table if not exists title_basics (
  title_id char(9) primary key,
  title_types varchar(12),
  primary_title varchar(292) not null,
  original_title varchar(292),
  is_adult boolean,
  start_year int,
  end_year int,
  runtime_minutes int 
);

create table if not exists person_basics (
  person_id char(9) primary key,
  primary_name char(105) not null,
  birth_year int,
  death_year int
);

create table if not exists title_episodes (
  title_id char(9) primary key,
  parent_title char(9),
  season_num int,
  episode_num int
);

create table if not exists title_ratings (
  title_id char(9) primary key,
  average_rating numeric,
  num_votes int,
);

create table if not exists directors (
  title_id char(9),
  person_id char(9)
  PRIMARY KEY (title_id, person_id),
  FOREIGN KEY director2title_basics (title_id)
  REFERENCES title_basics
  FOREIGN KEY directors2person_basics (person_id)
  REFERENCES person_basics
  );

create table if not exists writers (
  title_id char(9),
  person_id char(9) 
);

create table if not exists principals (
  title_id char(9),
  person_id char(9)
);

create table if not exists stars (
  person_id char(9),
  title_id char(9)
);

create table if not exists person_professions (
  person_id char(9),
  professions varchar(25)
);

create table if not exists title_genres (
  title_id char(9),
  genre varchar(11)
);