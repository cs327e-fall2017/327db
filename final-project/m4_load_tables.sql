\copy songs from C:/Users/Peter/Documents/FALL2017/Database/cinemalytics-with-headers/songs.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy temp_singer_songs from C:/Users/Peter/Documents/FALL2017/Database/cinemalytics-with-headers/singer_songs.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

\copy temp_persons from C:/Users/Peter/Documents/FALL2017/Database/cinemalytics-with-headers/persons.csv (header TRUE, format csv, delimiter ',', null '', encoding 'UTF8');

insert into singer_songs select * from temp_singer_songs where person_id IN (select person_id from temp_persons);