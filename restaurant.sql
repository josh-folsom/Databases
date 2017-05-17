CREATE TABLE restaurant (
id SERIAL NOT NULL PRIMARY KEY,
name VARCHAR,
distance INTEGER,
stars INTEGER,
category VARCHAR,
fav_dish VARCHAR,
does_takeout BOOLEAN,
last_time_eaten DATE
);

INSERT INTO restaurant VALUES (DEFAULT, 'Moon Tower', 1, 4, 'BBQ', 'beans', TRUE, '2017-04-17');
INSERT INTO restaurant VALUES (DEFAULT, 'Taco Bell', 3, 2, 'Fast Food', 'taco', TRUE, '2014-03-17');
INSERT INTO restaurant VALUES (DEFAULT, 'Whattaburger', 4, 5, 'Fast Food', 'cheeseburger', TRUE, '2017-04-30');
INSERT INTO restaurant VALUES (DEFAULT, 'McDonalds', 3, 1, 'Fast Food', 'fries', TRUE, '2017-02-15');
INSERT INTO restaurant VALUES (DEFAULT, 'Chipotle', 5, 5, 'Mexican', 'burrito', TRUE, '2017-05-07');

SELECT name FROM restaurant WHERE stars = 5;
SELECT fav_dish FROM restaurant WHERE stars = 5;
SELECT id FROM restaurant WHERE name = 'Moon Tower';
SELECT name FROM restaurant WHERE category = 'BBQ';
SELECT name FROM restaurant WHERE does_takeout = TRUE;
SELECT name FROM restaurant WHERE does_takeout = TRUE AND category = 'BBQ';
SELECT name FROM restaurant WHERE distance < 2;
SELECT name FROM restaurant WHERE last_time_eaten <= '2017-05-08';
SELECT name FROM restaurant WHERE last_time_eaten <= '2017-05-08' AND stars = 5;

SELECT * FROM restaurant ORDER BY distance;
SELECT * FROM restaurant ORDER BY stars DESC, distance LIMIT 2;
SELECT * FROM restaurant ORDER BY stars DESC LIMIT 2;
SELECT name FROM restaurant WHERE distance < '2' ORDER BY stars DESC;
SELECT COUNT (id) FROM restaurant;
SELECT COUNT (category) FROM restaurant;
SELECT AVG(stars) FROM restaurant;
SELECT MAX(stars) FROM restaurant GROUP BY category;
