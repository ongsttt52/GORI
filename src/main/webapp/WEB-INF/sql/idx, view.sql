/* index */
-- music (title, lyrics)
show indexes from gori.music;
ALTER TABLE music DROP INDEX title;
SELECT VERSION();
SHOW TABLE STATUS FROM gori WHERE Name = 'music';

ALTER TABLE music ADD INDEX idx_title(title);
ALTER TABLE music ADD FULLTEXT idx_lyrics(lyrics);



/* view */
-- user_genre
CREATE VIEW user_genre_view AS
SELECT ug.user_idx, u.email AS user_email, ug.genre_idx, g.genre_name
FROM user_genre ug
JOIN user u ON ug.user_idx = u.idx
JOIN genre g ON ug.genre_idx = g.idx;

SELECT * FROM user_genre_view;