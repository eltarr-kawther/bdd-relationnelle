CREATE DATABASE IF NOT EXISTS netflix;

USE netflix;

CREATE TABLE IF NOT EXISTS netflix_titles(
  show_id VARCHAR(10),
  type VARCHAR(10),
  title VARCHAR(110),
  director VARCHAR(210),
  cast VARCHAR(780),
  country VARCHAR(130),
  date_added VARCHAR(20),
  release_year INT NOT NULL,
  rating VARCHAR(10),
  duration VARCHAR(10),
  listed_in VARCHAR(80),
  description VARCHAR(280),
  PRIMARY KEY(show_id)
  );

CREATE TABLE IF NOT EXISTS netflix_shows(
  id INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(64),
  rating VARCHAR(9),
  ratingLevel VARCHAR(126),
  ratingDescription INT NOT NULL,
  `release year` INT NOT NULL,
  `user rating score` VARCHAR(4),
  `user rating size` INT NOT NULL,
  PRIMARY KEY(id)
  );

;mysql --local_infile=1 -u root -p netflix

LOAD DATA LOCAL INFILE 'C:/Users/straw/Desktop/AIS/ProjectPool 2/BDD-Relationnelle/Data/netflix_titles.csv'
INTO TABLE netflix_titles 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/Users/straw/Desktop/AIS/ProjectPool 2/BDD-Relationnelle/Data/Netflix_shows.csv'
INTO TABLE netflix_shows
CHARACTER SET latin1 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r'
IGNORE 1 LINES(title, rating, ratingLevel, ratingDescription,`release year`, `user rating score`, `user rating size`);

SELECT title FROM netflix_title WHERE show_id<80000000;

SELECT duration FROM netflix_title WHERE type = "TV Show";

SELECT title FROM netflix_titles WHERE title IN (SELECT netflix_shows.title FROM netflix_shows);

SELECT SUM(duration) FROM netflix_titles WHERE type = "Movie";

SELECT COUNT(rating) FROM netflix_shows WHERE SUBSTRING(rating,1,3)="TV-" AND ratingLevel IS NOT NULL;

SELECT type FROM netflix_titles LIMIT 5;

SELECT COUNT(t.title) FROM netflix_titles t, netflix_shows s WHERE t.title = s.title AND t.type = "TV Show" AND s.ratingLevel IS NOT NULL;

SELECT COUNT(t.title),COUNT(s.title) FROM netflix_titles t, netflix_shows s WHERE t.title = s.title AND t.release_year > 2016;

ALTER TABLE netflix_shows DROP COLUMN rating;

DELETE FROM netflix_shows ORDER BY id DESC LIMIT 100;

UPDATE netflix_shows SET ratingLevel = "For mature audiences. May not be suitable for children 17 and under." WHERE title="Marvel\'s Iron Fist";

SELECT * FROM netflix_shows WHERE title="Marvel\'s Iron Fist";