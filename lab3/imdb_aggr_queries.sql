/* Query 0: Directors who have directed at least 5 titles per year between the years 2007 - 2017 */
select primary_name as director_name, start_year as year, count(*) as
title_count
from title_basics tb join directors d on tb.title_id = d.title_id
join person_basics pb on pb.person_id = d.person_id
where start_year between 2007 and 2017
group by primary_name, start_year
having count(*) >= 5
order by start_year, count(*);

/* Query 1: Number of movies an actor have starred in whose average rating is higher than 9.5 between the years 2005 - 2015*/
SELECT pb.primary_name AS actor_name, count(*) AS num_movies, tb.start_year as year
FROM person_basics pb JOIN stars s ON pb.person_id = s.person_id
JOIN title_basics tb ON s.title_id = tb.title_id
JOIN title_ratings tr ON tb.title_id = tr.title_id
WHERE tb.start_year BETWEEN 2005 AND 2015
GROUP BY pb.primary_name, tr.average_rating, tb.start_year
HAVING tr.average_rating > 9.5
ORDER BY year desc, num_movies desc;