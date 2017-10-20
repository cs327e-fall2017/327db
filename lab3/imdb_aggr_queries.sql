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
Sort by name of writer*/
SELECT pb.primary_name AS writer, pb.birth_year as birth_year, MAX(tb.runtime_minutes) AS longest_length
FROM writers w INNER JOIN person_basics pb ON pb.person_id = w.person_id
INNER JOIN title_basics tb ON w.title_id = tb.title_id
WHERE tb.title_type = 'movie' AND pb.birth_year IS NOT NULL
GROUP BY writer, birth_year
HAVING MAX(tb.runtime_minutes) > 90
ORDER BY writer
LIMIT 20;


/* Query 3: Living directors that only worked on more than five foreign media and the number they made*/
SELECT pb.primary_name AS director, tg.genre AS genre, count(*) as num_media
FROM person_basics pb INNER JOIN directors d ON pb.person_id=d.person_id
INNER JOIN title_genres tg ON d.title_id=tg.title_id
RIGHT OUTER JOIN title_basics tb ON d.title_id=tb.title_id
WHERE original_title IS NOT NULL AND pb.death_year IS NOT NULL
GROUP BY director, genre
HAVING count(*) > 5
ORDER BY genre, director
LIMIT 20;


/* Query 3: Number of seasons/episodes and the show's average rating*/
SELECT tb.primary_title AS show_title, MAX(te.season_num) AS show_max_season, MAX(te.episode_num) AS show_max_episode, AVG(tr.average_rating) AS show_rating
FROM title_basics tb INNER JOIN title_episodes te ON tb.title_id=te.parent_title_id
INNER JOIN title_ratings tr ON tb.title_id = tr.title_ratings
WHERE te.parent_title_id IS NOT NULL AND te.episode_num IS NOT NULL AND te.season_num IS NOT NULL
GROUP BY show_title, show_max_season, show_max_episode
ORDER BY show_rating
LIMIT 20;