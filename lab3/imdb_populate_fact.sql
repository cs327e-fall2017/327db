/* a) appalling titles */
CREATE TABLE Title_Rating_Facts_Appalling AS
SELECT tb.title_type AS title_type, tb.start_year AS year, tg.genre AS genre, COUNT(*) AS appalling_titles
FROM title_basics tb FULL OUTER JOIN title_genres tg ON tb.title_id = tg.title_id
FULL OUTER JOIN title_ratings tr ON tb.title_id = tr.title_id
WHERE tr.average_rating <= 2.0
GROUP BY tb.title_type, tb.start_year, tg.genre;

/* a) average titles */
CREATE TABLE Title_Rating_Facts_Average AS
SELECT tb.title_type AS title_type, tb.start_year AS year, tg.genre AS genre, COUNT(*) AS average_titles
FROM title_basics tb FULL OUTER JOIN title_genres tg ON tb.title_id = tg.title_id
FULL OUTER JOIN title_ratings tr ON tb.title_id = tr.title_id
WHERE tr.average_rating BETWEEN 2.1 AND 7.9
GROUP BY tb.title_type, tb.start_year, tg.genre;

/* a) outstanding titles */
CREATE TABLE Title_Rating_Facts_Outstanding AS
SELECT tb.title_type AS title_type, tb.start_year AS year, tg.genre AS genre, COUNT(*) AS outstanding_titles
FROM title_basics tb FULL OUTER JOIN title_genres tg ON tb.title_id = tg.title_id
FULL OUTER JOIN title_ratings tr ON tb.title_id = tr.title_id
WHERE tr.average_rating >= 8.0
GROUP BY tb.title_type, tb.start_year, tg.genre;

/* Final Fact Table */
CREATE TABLE Title_Rating_Facts AS
SELECT ap.title_type AS title_type, ap.year AS year, ap.genre AS genre,
ap.appalling_titles AS appalling_titles, av.average_titles AS average_titles, o.outstanding_titles AS outstanding_titles
FROM Title_Rating_Facts_Appalling ap FULL OUTER JOIN Title_Rating_Facts_Average av
ON ap.title_type = av.title_type AND ap.year = av.year AND ap.genre = av.genre
FULL OUTER JOIN Title_Rating_Facts_Outstanding o
ON av.title_type = o.title_type AND av.year = o.year AND av.genre = o.genre;

/* Set values to null */
UPDATE Title_Rating_Facts
SET title_type = 0 WHERE title_type IS NULL;
UPDATE Title_Rating_Facts
SET year = 0 WHERE year IS NULL;
UPDATE Title_Rating_Facts
SET genre = 0 WHERE genre IS NULL;
UPDATE Title_Rating_Facts
SET appalling_titles = 0 WHERE appalling_titles IS NULL;
UPDATE Title_Rating_Facts
SET outstanding_titles = 0 WHERE outstanding_titles IS NULL;
UPDATE Title_Rating_Facts
SET average_titles = 0 WHERE average_titles IS NULL;

/* Delete Null PK Values */
DELETE FROM Title_Rating_Facts
WHERE title_type == 0 OR year == 0 OR genre == 0;

/* Add Primary Key Constraints */
ALTER TABLE Title_Rating_Facts
ADD CONSTRAINT PK_type_genre_year PRIMARY KEY (title_type, year, genre);

/*Part f aggregate query */
CREATE VIEW v_outstanding_titles_by_year_genre AS
SELECT TRF.year, TRF.genre, SUM(TRF.outstanding_titles)
FROM Title_Rating_Facts TRF
WHERE year >= 1930
GROUP BY TRF.year, TRF.genre
HAVING SUM(TRF.outstanding_titles) > 0
ORDER BY TRF.year, TRF.genre
LIMIT 100;