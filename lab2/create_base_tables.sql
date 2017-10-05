/*\c dev

drop database if exists imdb;

create database imdb;

\c imdb
*/

create table if not exists title_basics (
  title_id char(9) primary key,
  title_types varchar(12),
  primary_title varchar(292),
  original_title varchar(292),
  is_adult boolean,
    start_year int,
    end_year int,
    runtime_minutes int 
);

create table if not exists person_basics (
  person_id char(9) primary key,
  primary_name char(105),
  birth_year int,
  death_year int
);