\c imdb;

\copy title_basics from C:/Users/Peter/Documents/FALL2017/Database/pg/title_basics.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy person_basics from C:/Users/Peter/Documents/FALL2017/Database/pg/person_basics.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy title_episodes from C:/Users/Peter/Documents/FALL2017/Database/pg/title_episodes.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy title_ratings from C:/Users/Peter/Documents/FALL2017/Database/pg/title_ratings.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy directors from C:/Users/Peter/Documents/FALL2017/Database/pg/directors.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy writers from C:/Users/Peter/Documents/FALL2017/Database/pg/writers.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from 'C:/Users/Peter/Documents/FALL2017/Database/split_principals/xaa' (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from 'C:/Users/Peter/Documents/FALL2017/Database/split_principals/xab' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from 'C:/Users/Peter/Documents/FALL2017/Database/split_principals/xac' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from 'C:/Users/Peter/Documents/FALL2017/Database/split_principals/xad' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from 'C:/Users/Peter/Documents/FALL2017/Database/split_principals/xae' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from 'C:/Users/Peter/Documents/FALL2017/Database/split_principals/xaf' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from 'C:/Users/Peter/Documents/FALL2017/Database/split_principals/xag' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from 'C:/Users/Peter/Documents/FALL2017/Database/split_principals/xah' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from 'C:/Users/Peter/Documents/FALL2017/Database/split_principals/xai' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from 'C:/Users/Peter/Documents/FALL2017/Database/split_principals/xaj' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from 'C:/Users/Peter/Documents/FALL2017/Database/split_principals/xak' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from 'C:/Users/Peter/Documents/FALL2017/Database/split_principals/xal' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from 'C:/Users/Peter/Documents/FALL2017/Database/split_principals/xam' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

alter table principals add foreign key(title_id) references title_basics(title_id);
alter table principals add foreign key(person_id) references person_basics(person_id);

\copy stars from 'C:/Users/Peter/Documents/FALL2017/Database/split_stars/xaa' (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy stars from 'C:/Users/Peter/Documents/FALL2017/Database/split_stars/xab' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy stars from 'C:/Users/Peter/Documents/FALL2017/Database/split_stars/xac' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy stars from 'C:/Users/Peter/Documents/FALL2017/Database/split_stars/xad' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy stars from 'C:/Users/Peter/Documents/FALL2017/Database/split_stars/xae' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy stars from 'C:/Users/Peter/Documents/FALL2017/Database/split_stars/xaf' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy stars from 'C:/Users/Peter/Documents/FALL2017/Database/split_stars/xag' (header FALSE, format csv, delimiter ',', null '', encoding 'UTF8');


alter table stars add FOREIGN KEY (title_id) REFERENCES title_basics (title_id) ON DELETE CASCADE;
alter table stars add FOREIGN KEY (person_id) REFERENCES person_basics (person_id) ON DELETE CASCADE;

\copy person_professions from C:/Users/Peter/Documents/FALL2017/Database/pg/person_professions.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy title_genres from C:/Users/Peter/Documents/FALL2017/Database/pg/title_genres.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');