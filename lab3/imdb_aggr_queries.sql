
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