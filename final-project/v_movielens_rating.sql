/* Displays difference between imdb rating and movielens rating for each movie genre */
CREATE VIEW v_movielens_rating AS
	SELECT tg.genre, AVG(ABS(tr.average_rating-tr.movielens_rating*2)) AS rating_difference
	FROM title_genres tg JOIN title_ratings tr ON tg.title_id = tr.title_id
	WHERE tr.movielens_rating IS NOT NULL
	GROUP BY tg.genre
	ORDER BY tg.genre;

