
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

select tb.primary_title, pb.primary_name
from title_basics tb join directors d on (tb.title_id = d.title_id) join person_basics pb on (d.person_id = pb.person_id)
where tb.original_title <> tb.primary_title
and tb.title_type = 'movie'
order by tb.start_year asc;


/*QUERY #3 (CPY86)
This query searches for people and the title they're most famous for,
where the person has already deceased. It makes sure to pass living
people by checking if death year is null or not, and is ordered by the
title's starting year*/

select pb.primary_name, pb.death_year, tb.primary_title
from title_basics tb join stars s on (tb.title_id = s.title_id) join person_basics pb on (s.person_id = pb.person_id)
where pb.death_year is NOT NULL
order by tb.start_year asc;


/*Query #4 (DJS3745)
What is the oldest movie in the database
that Tom Cruise starred in? */

SELECT tb.primary_title, tb.start_year
FROM person_basics pb JOIN stars s ON s.person_id = pb.person_id
JOIN title_basics tb ON tb.title_id = s.title_id
WHERE tb.title_type = 'movie'and pb.primary_name = 'Tom Cruise'
ORDER BY tb.start_year asc;


/*Query #5 (CPY86)
This query searches for people's name, the title they were starred
in, and it's number of votes, by order of it's average rating from
10 to 0. */

select pb.primary_name, tb.primary_title, tr.average_rating, tr.num_votes
from person_basics pb join stars s on (pb.person_id = s.person_id)
join title_basics tb on (s.title_id = tb.title_id) join title_ratings tr on (tb.title_id = tr.title_id)
order by tr.average_rating desc;


/* Query #6 (DJS3745)
What movies do people hate so much they just NEED to rate it terribly?*/

SELECT tr.num_votes, tr.average_rating, tb.primary_title
FROM title_basics tb JOIN title_ratings tr ON tb.title_id = tr.title_id
ORDER BY tr.average_rating asc, tr.num_votes desc


/* Query #7 (DJS3745)
Did the writers of any good TV Shows pass away in the last year or so? */

SELECT pb.primary_name, pb.death_year, tb.primary_title, tr.average_rating
FROM writers w JOIN person_basics pb ON w.person_id = pb.person_id
JOIN title_ratings tr ON tr.title_id = w.title_id
JOIN title_basics tb ON tb.title_id = w.title_id
WHERE pb.death_year <= 2017 and pb.death_year >= 2016 and tb.title_type = 'tvSeries'
ORDER BY tr.average_rating desc


/*QUERY #8 (CPY86)
This query searches for actors that were born after 2000 and prints
their birth year, and orders it by actor's name*/

select pb.primary_name, pb.birth_year
from person_basics pb join person_professions pp on (pb.person_id = pp.person_id)
where pb.birth_year > 2000
and pp.profession = 'actor'
order by pb.primary_name asc;


/* Query #9
I want to learn something but I don't
have a lot of time. Show me the shortest
good documentaries available, ideally made
recently. I'm going to assume
that any documentary with a length of less than
20 minutes is an erroneous entry in the
database. */

SELECT tb.primary_title, tb.runtime_minutes, tr.average_rating, tb.start_year
FROM title_basics tb JOIN title_genres tg ON tb.title_id = tg.title_id
JOIN title_ratings tr ON tr.title_id = tb.title_id
WHERE tg.genre = 'Documentary' and tb.runtime_minutes >= 20
ORDER BY tb.runtime_minutes, tb.start_year desc, tr.average_rating desc


/*QUERY # 10
This query searches for the actor, title, and runtime minutes, where the 
title is adult themed and is ordered from longest runtime to least*/

select distinct tb.primary_title, pb.primary_name, tb.runtime_minutes
from title_basics tb join principals p on (tb.title_id = p.title_id) join person_basics pb on (p.person_id = pb.person_id)
where tb.is_adult = TRUE
order by tb.runtime_minutes desc;