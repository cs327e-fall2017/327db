
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


/*QUERY #4 (DJS3745)
What is the oldest movie in the database
that Tom Cruise starred in? */

SELECT tb.primary_title, tb.start_year
FROM person_basics pb JOIN stars s ON s.person_id = pb.person_id
JOIN title_basics tb ON tb.title_id = s.title_id
WHERE tb.title_type = 'movie'and pb.primary_name = 'Tom Cruise'
ORDER BY tb.start_year asc;


/*QUERY #5 (CPY86)
This query searches for people's name, the title they were starred
in, and it's number of votes, by order of it's average rating from
10 to 0. */

SELECT pb.primary_name, tb.primary_title, tr.average_rating, tr.num_votes
FROM person_basics pb JOIN stars s ON (pb.person_id = s.person_id)
JOIN title_basics tb ON (s.title_id = tb.title_id) JOIN title_ratings tr ON (tb.title_id = tr.title_id)
ORDER BY tr.average_rating desc;


/* QUERY #6 (DJS3745)
What movies do people hate so much they just NEED to rate it terribly?*/

SELECT tr.num_votes, tr.average_rating, tb.primary_title
FROM title_basics tb JOIN title_ratings tr ON tb.title_id = tr.title_id
ORDER BY tr.average_rating asc, tr.num_votes desc


/* QUERY #7 (DJS3745)
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

SELECT pb.primary_name, pb.birth_year
FROM person_basics pb JOIN person_professions pp ON (pb.person_id = pp.person_id)
WHERE pb.birth_year > 2000
and pp.profession = 'actor'
ORDER BY pb.primary_name asc;


/* QUERY #9 (DJS3745)
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


/*QUERY # 10 (CPY86)
This query searches for the actor, title, and runtime minutes, where the
title is adult themed and is ordered from longest runtime to least*/

SELECT distinct tb.primary_title, pb.primary_name, tb.runtime_minutes
FROM title_basics tb join principals p ON (tb.title_id = p.title_id) JOIN person_basics pb ON (p.person_id = pb.person_id)
WHERE tb.is_adult = TRUE
ORDER BY tb.runtime_minutes desc;\


/* QUERY #11 (DJS3745)
Has George Clooney ever done a comedy movie?
If so I'm quite curious, so curious in fact
that I'd like to watch it tonight. */

SELECT tb.primary_title, tb.start_year
FROM stars s JOIN person_basics pb ON s.person_id = pb.person_id
JOIN title_basics tb ON s.title_id = tb.title_id
JOIN title_genres tg ON tg.title_id = tb.title_id
WHERE tg.genre = 'Comedy' and pb.primary_name = 'George Clooney' and tb.start_year <= 2016
ORDER BY tb.start_year desc


/*QUERY # 12 (CPY86)
This query searches for the title, adult status, and average rating, where
the adult status is true, and is ordered by highest rating to low*/

SELECT tb.primary_title, tb.is_adult, tr.average_rating
FROM title_basics tb JOIN title_ratings tr ON (tb.title_id = tr.title_id)
WHERE tb.is_adult = TRUE
ORDER BY tr.average_rating desc;


/* QUERY #13 (DJS3745)
Who directed the top-rated documentaries?
Make sure ratings are validated by lots of people.*/

SELECT DISTINCT pb.primary_name, tr.average_rating, tb.primary_title
FROM directors d JOIN person_basics pb ON d.person_id = pb.person_id
JOIN title_ratings tr ON d.title_id = tr.title_id
JOIN title_genres tg ON tg.title_id = d.title_id
JOIN title_basics tb ON tb.title_id = d.title_id
WHERE tg.genre = 'Documentary' and tr.num_votes >= 100
ORDER BY tr.average_rating desc


/* QUERY #14 (CPY86)
This query searches for the comedy title, and its average rating. It will
be ordered by highest rating to low*/

SELECT tb.primary_title, tr.average_rating
FROM title_genres tg JOIN title_basics tb ON (tg.title_id = tb.title_id) JOIN title_ratings tr ON (tb.title_id = tr.title_id)
WHERE tg.genre = 'Comedy'
ORDER BY tr.average_rating desc


/* Query #15 (CPY86)
This query searches for actor name and number of votes, where the actor
is still alive, and is ordered by the number of votes */

SELECT pb.primary_name, tr.num_votes
FROM title_ratings tr JOIN stars s ON (tr.title_id = s.title_id)
JOIN person_basics pb ON (s.person_id = pb.person_id)
WHERE pb.death_year is not null
order by tr.num_votes desc


/* QUERY #16 (DJS3745)
Show me old family movies so that I can
educate my cousins on what Disney used to be
back in the day. Though I don't think they'll have
the patience for silent films.*/

SELECT tb.primary_title, tb.start_year
FROM title_genres tg JOIN title_basics tb ON tb.title_id = tg.title_id
WHERE tg.genre = 'Family' and tb.title_type = 'movie'
AND tb.start_year <= 1970 and tb.start_year >= 1950
ORDER BY tb.start_year asc


/* QUERY #17 (DJS3745)
How  has the ratings of movies that
James Franco has been in changed over time? */

SELECT tb.primary_title, tr.average_rating, tb.start_year
FROM title_basics tb JOIN title_ratings tr ON tb.title_id = tr.title_id
JOIN stars s ON s.title_id = tb.title_id
JOIN person_basics pb ON pb.person_id = s.person_id
WHERE pb.primary_name = 'James Franco'
ORDER BY start_year asc


/* QUERY #18 (CPY86)
This query searches for the person's name if they wrote and/or directed.
It's checked if the person is alive and is ordered by name*/

SELECT pb.primary_name, pp.profession
FROM person_professions pp JOIN person_basics pb ON (pp.person_id = pb.person_id)
WHERE pp.profession = 'writer'
or pp.profession = 'director'
and death_year is not null
ORDER BY pb.primary_name desc


/* QUERY #19 (CPY86)
This query searches for Wes Anderson Movies by its rating*/

SELECT pb.primary_name, tb.primary_title
FROM person_basics pb JOIN directors d ON (pb.person_id = d.person_id)
JOIN title_basics tb ON (d.title_id = tb.title_id) JOIN title_ratings tr ON (tb.title_id = tr.title_id)
where pb.primary_name = 'Wes Anderson'
ORDER BY tr.average_rating desc;


/* QUERY #20 (DJS3745)
Generate a list of the oldest living
actresses and actors */

SELECT pb.primary_name, pb.birth_year
FROM person_basics pb JOIN person_professions pp ON pb.person_id = pp.person_id
WHERE (pp.profession = 'actor' or pp.profession = 'actress')
AND pb.birth_year > 1900
AND pb.death_year IS NULL
ORDER BY pb.birth_year asc
