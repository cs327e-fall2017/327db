ALTER TABLE Person_Basics ADD gender char(1);

ALTER TABLE Title_Songs
ADD FOREIGN KEY (title_id) REFERENCES Title_Basics(title_id);
#insert or update on table "title_songs" violates foreign key constraint "title_songs_title_id_fkey"
#Key (title_id)=(tt5544787) is not present in table "title_basics"
DELETE FROM Title_Songs
WHERE title_id = 'tt5544787';
#insert or update on table "title_songs" violates foreign key constraint "title_songs_title_id_fkey"
#Key (title_id)=(tt3515718) is not present in table "title_basics"
DELETE FROM Title_Songs
WHERE title_id = 'tt3515718';

ALTER TABLE Title_Songs
ADD FOREIGN KEY (song_id) REFERENCES Songs(song_id);

ALTER TABLE Singer_Songs
ADD FOREIGN KEY (person_id) REFERENCES Person_Basics(person_id);

ALTER TABLE Singer_Songs
ADD FOREIGN KEY (song_id) REFERENCES Songs(song_id);