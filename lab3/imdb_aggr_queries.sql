/* Query 1: Count of an actor that have starred in a form of media whose average rating is higher than 9.5 between the years 2005 - 2015*/
SELECT pb.primary_name AS actor_name, count(*) AS num_media, tb.start_year as year
FROM person_basics pb JOIN stars s ON pb.person_id = s.person_id
JOIN title_basics tb ON s.title_id = tb.title_id
JOIN title_ratings tr ON tb.title_id = tr.title_id
WHERE tb.start_year BETWEEN 2005 AND 2015
GROUP BY pb.primary_name, tr.average_rating, tb.start_year
HAVING tr.average_rating > 9.5
ORDER BY year desc, num_media desc
LIMIT 20;


/* Movie writers and their longest titles;
Only include movies that are full-length (>90min.);
Sort by name of writer.
For visualization, useful to see if there's a corellation between 
writer age (i.e. birthday) and longest one*/
SELECT pb.primary_name AS writer, pb.birth_year as birth_year, MAX(tb.runtime_minutes) AS longest_length
FROM writers w INNER JOIN person_basics pb ON pb.person_id = w.person_id
INNER JOIN title_basics tb ON w.title_id = tb.title_id
WHERE tb.title_type = 'movie' AND pb.birth_year IS NOT NULL
GROUP BY writer, birth_year
HAVING MAX(tb.runtime_minutes) > 90
ORDER BY writer
LIMIT 20;


/* Query 2: Living directors that only worked on more than five foreign media and the number they made*/
SELECT pb.primary_name AS director, tg.genre AS genre, count(*) as num_media
FROM person_basics pb INNER JOIN directors d ON pb.person_id=d.person_id
INNER JOIN title_genres tg ON d.title_id=tg.title_id
RIGHT OUTER JOIN title_basics tb ON d.title_id=tb.title_id
WHERE original_title IS NOT NULL AND pb.death_year IS NOT NULL
GROUP BY director, genre
HAVING count(*) > 5
ORDER BY genre, director
LIMIT 20;


/* Earliest instance of each genre.
If database has no instance of a particular genre,
show that this is the case */
SELECT tg.genre, MIN(tb.start_year) as earliest_instance
FROM title_basics tb RIGHT OUTER JOIN title_genres tg ON tg.title_id=tb.title_id
WHERE tb.start_year > 1900 AND tb.runtime_minutes > 80
GROUP BY tg.genre
ORDER BY MIN(start_year)
LIMIT 20;


/* Query 3: Number of seasons/episodes and the show's average rating*/
SELECT tb.primary_title AS show_title, MAX(te.season_num) AS show_max_season, AVG(tr.average_rating) AS show_rating
FROM title_basics tb INNER JOIN title_episodes te ON tb.title_id=te.parent_title
INNER JOIN title_ratings tr ON tb.title_id = tr.title_id
WHERE te.parent_title IS NOT NULL AND te.episode_num IS NOT NULL AND te.season_num IS NOT NULL
GROUP BY tb.primary_title
ORDER BY show_title, show_rating
LIMIT 20;


/* Wealthy figures.
List of principals and how many screentime minutes
they have been the principal for, and the type
of works they were principals for. */
SELECT pb.primary_name as Name, tb.title_type as type, SUM(tb.runtime_minutes) as sum
FROM person_basics pb JOIN principals p ON pb.person_id = p.person_id
JOIN title_basics tb on p.title_id = tb.title_id
GROUP BY pb.primary_name, tb.title_type
HAVING SUM(tb.runtime_minutes) > 2000
ORDER BY SUM(tb.runtime_minutes) DESC
LIMIT 20;
