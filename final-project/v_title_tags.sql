/* Find occurences of most frequently used tag for each title-type.
Useful for psychological groupthink studies */

CREATE VIEW v_title_tags AS
	SELECT foo.title_type, max(foo.tag_count) FROM
	(SELECT tb.title_type, tt.tag, count(tt.tag) AS tag_count
	FROM Title_Tags tt JOIN Title_Basics tb ON tt.title_id = tb.title_id
	GROUP BY tb.title_type, tt.tag) AS foo
	GROUP BY foo.title_type;