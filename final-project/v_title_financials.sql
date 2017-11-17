/* For big-budget movies, look for correlation between
rating and budget and between
rating and box_office */

CREATE VIEW v_title_financials AS
	SELECT tb.title_id, tf.budget, tf.box_office, tr.average_rating
	FROM title_ratings tr JOIN title_basics tb ON tb.title_id=tr.title_id
	JOIN Title_Financials tf ON tf.title_id = tb.title_id
	WHERE tf.budget > 1000000;