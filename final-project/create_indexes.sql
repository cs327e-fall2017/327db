CREATE INDEX year_indx ON Title_Basics (start_year);
CREATE INDEX p_title_indx ON Title_Basics (UPPER(primary_title));
CREATE INDEX t_type_indx ON Title_Basics (title_type) WHERE title_type <> 'tvEpisode';
CREATE INDEX genre_indx ON Title_Genres (genre);