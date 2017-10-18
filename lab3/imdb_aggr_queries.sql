/* Query 1: Number of movies an actor have starred in whose average rating is higher than 9.5 between the years 2005 - 2015*/
SELECT pb.primary_name AS actor_name, count(*) AS num_movies, tb.start_year as year
FROM person_basics pb JOIN stars s ON pb.person_id = s.person_id
JOIN title_basics tb ON s.title_id = tb.title_id
JOIN title_ratings tr ON tb.title_id = tr.title_id
WHERE tb.start_year BETWEEN 2005 AND 2015
GROUP BY pb.primary_name, tr.average_rating, tb.start_year
HAVING tr.average_rating > 9.5
ORDER BY year desc, num_movies desc;
=======

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
