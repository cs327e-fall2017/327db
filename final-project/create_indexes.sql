CREATE INDEX year_title_idx ON Title_Basics (start_year, UPPER(primary_title));
CREATE INDEX year_title_type_idx ON Title_Basics (start_year, UPPER(primary_title), title_type) WHERE title_type <> 'tvEpisode';
CREATE INDEX genre_idx ON Title_Genres (genre);