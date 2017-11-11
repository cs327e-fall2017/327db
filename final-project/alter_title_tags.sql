ALTER TABLE Title_Tags
ADD FOREIGN KEY (title_id) REFERENCES Title_Basics(title_id);