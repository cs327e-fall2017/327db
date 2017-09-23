
/* QUERY #1
Find me the highest rated movie in the databases,
but make sure it's kid-friendly so that I can watch
it with my little cousin this evening.*/

SELECT tb.primary_title, tr.average_rating
FROM title_basics tb JOIN title_ratings tr ON tb.title_id = tr.title_id
WHERE tr.num_votes > 100 and tb.title_type = 'movie' and is_adult = FALSE
ORDER BY tr.average_rating desc;
