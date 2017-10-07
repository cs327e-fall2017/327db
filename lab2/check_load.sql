SELECT count(*) FROM title_basics;
SELECT * FROM title_basics LIMIT 10;

SELECT count(*) FROM person_basics;
SELECT * FROM person_basics LIMIT 10;

SELECT count(*) FROM title_episodes;
SELECT * FROM title_episodes LIMIT 10;

SELECT count(*) FROM title_ratings;
SELECT * FROM title_ratings LIMIT 10;

SELECT count(*) FROM directors;
SELECT * FROM directors LIMIT 10;

SELECT count(*) FROM writers;
SELECT * FROM writers LIMIT 10;

SELECT count(*) FROM principals;
SELECT * FROM principals LIMIT 10;

SELECT count(*) FROM stars;
SELECT * FROM stars LIMIT 10;

SELECT count(*) FROM person_professions;
SELECT * FROM person_professions LIMIT 10;

SELECT count(*) FROM title_genres;
SELECT * FROM title_genres LIMIT 10;


/* Queries below are pasted from Lab 1.
Demonstrate that joins and relationships are effective
in this database.*/

/* QUERY #1 (DJS3745)

Find me the highest rated movie in the databases,

but make sure it's kid-friendly so that I can watch

it with my little cousin this evening.*/



SELECT tb.primary_title, tr.average_rating

FROM title_basics tb JOIN title_ratings tr ON tb.title_id = tr.title_id

WHERE tr.num_votes > 100 and tb.title_type = 'movie' and is_adult = FALSE

ORDER BY tr.average_rating desc;





/* QUERY #2 (CPY86)

This query searches for foreign movies by checking the primary title is

different toits original title, since the original title uses the foreign

language and the primary title is the translation. It also returns the

director's name. All of this will be ordered by the movie's starting year.*/



SELECT tb.primary_title, pb.primary_name

FROM title_basics tb JOIN directors d ON (tb.title_id = d.title_id) JOIN person_basics pb ON (d.person_id = pb.person_id)

WHERE tb.original_title <> tb.primary_title

AND tb.title_type = 'movie'

ORDER BY tb.start_year asc;





/*QUERY #3 (CPY86)

This query searches for people and the title they're most famous for,

where the person has already deceased. It makes sure to pass living

people by checking if death year is null or not, and is ordered by the

title's starting year*/



SELECT pb.primary_name, pb.death_year, tb.primary_title

FROM title_basics tb JOIN stars s ON (tb.title_id = s.title_id) JOIN person_basics pb ON (s.person_id = pb.person_id)

WHERE pb.death_year is NOT NULL

ORDER by tb.start_year asc;

