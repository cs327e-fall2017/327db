\c imdb;

\copy title_basics from C:/Users/Peter/Documents/FALL2017/Database/pg/title_basics.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy person_basics from C:/Users/Peter/Documents/FALL2017/Database/pg/person_basics.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy title_episodes from C:/Users/Peter/Documents/FALL2017/Database/pg/title_episodes.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy title_ratings from C:/Users/Peter/Documents/FALL2017/Database/pg/title_ratings.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy directors from C:/Users/Peter/Documents/FALL2017/Database/pg/directors.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy writers from C:/Users/Peter/Documents/FALL2017/Database/pg/writers.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy principals from C:/Users/Peter/Documents/FALL2017/Database/pg/principals.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy stars from C:/Users/Peter/Documents/FALL2017/Database/pg/stars.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy person_professions from C:/Users/Peter/Documents/FALL2017/Database/pg/person_professions.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy title_genres from C:/Users/Peter/Documents/FALL2017/Database/pg/title_genres.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');
