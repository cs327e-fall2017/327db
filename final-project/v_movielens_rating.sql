/* Displays difference between imdb rating and movielens rating for each movie genre */
SELECT tg.genre, tr.average_rating, tr.movielens_rating*2, ABS(tr.average_rating-tr.movielens_rating*2) AS rating_difference
FROM title_genres tg JOIN title_ratings tr ON tg.title_id = tr.title_id
WHERE tr.movielens_rating IS NOT NULL
ORDER BY tg.genre;

