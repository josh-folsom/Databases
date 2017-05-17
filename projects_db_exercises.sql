#1 What are all projects that use JavaScript?; #
SELECT project_id, tech_id FROM project_uses_tech WHERE tech_id = 3;



#2 What are all technologies used by the Personal Website?;#
SELECT tech_id FROM project_uses_tech WHERE project_id = 4;



#3 Perform a left outer join from the tech table to the project_uses_tech table - which techs has no associated project? RUBY JAVASCRIPT JAVA; #

SELECT *  FROM tech
LEFT OUTER JOIN project_uses_tech
ON  project_uses_tech.tech_id = tech.id;



#4 Based on the previous query, get the count of the number of techs used by each project.; #

SELECT project.id, project.name, COUNT(project_uses_tech.project_id)AS tech_totals
FROM project 
LEFT OUTER JOIN project_uses_tech
ON  project_uses_tech.project_id = project.id
GROUP BY project.id;


#5 Perform a left outer join from the project table to the project_users_tech table - which projects has no associated tech?; Whiteboard Exercises#;

SELECT project.id, project.name, COUNT(project_uses_tech.project_id)AS tech_totals
FROM project 
LEFT OUTER JOIN project_uses_tech
ON  project_uses_tech.project_id = project.id
GROUP BY project.id;


#6 Based on the previous query, get the count of the number of projects that use each tech.;#

SELECT tech.id, tech.name, COUNT(project_uses_tech.tech_id)AS project_totals
FROM tech 
LEFT OUTER JOIN project_uses_tech
ON  project_uses_tech.tech_id = tech.id
GROUP BY tech.id;

#7 List all projects along with each technology used by it. You will need to do a three-way join.;#

SELECT * FROM project

JOIN project_uses_tech ON  project_uses_tech.project_id = project.id
JOIN tech ON project_uses_tech.tech_id = tech_id;

#8 List all the distinct techs that are used by at least one project.;
SELECT tech.id, tech.name, COUNT(project_uses_tech.project_id)AS total_project_ids
FROM tech
  JOIN project_uses_tech ON project_uses_tech.tech_id = tech.id 
  JOIN project ON project_uses_tech.project_id = project.id
  GROUP BY tech.id;  

#9 List all the distinct techs that are not used by any projects.;
SELECT DISTINCT(tech.name) 
FROM project
RIGHT OUTER JOIN project_uses_tech ON project_uses_tech.project_id = project.id
RIGHT OUTER JOIN tech ON project_uses_tech.tech_id = tech.id
WHERE project_id IS NULL;


#10 List all the distinct prjects that use at least one tech.;
SELECT DISTINCT(tech.name) 
FROM project
RIGHT OUTER JOIN project_uses_tech ON project_uses_tech.project_id = project.id
RIGHT OUTER JOIN tech ON project_uses_tech.tech_id = tech.id
WHERE project_id IS NOT NULL;

#11 List all the distinct projects that use no tech.;
SELECT DISTINCT(project.name) 
FROM tech
RIGHT OUTER JOIN project_uses_tech ON project_uses_tech.tech_id = tech.id
RIGHT OUTER JOIN project ON project_uses_tech.project_id = project.id
WHERE tech_id is NULL;

#12 Order the projects by how many tech it uses.;
SELECT project.id, project.name, COUNT(project_uses_tech.project_id)AS tech_totals
FROM project 
LEFT OUTER JOIN project_uses_tech
ON  project_uses_tech.project_id = project.id
GROUP BY project.id ORDER BY tech_totals DESC;

#13 Order the tech by how many projects use it.;
SELECT tech.id, tech.name, COUNT(project_uses_tech.tech_id)AS project_totals
FROM tech 
LEFT OUTER JOIN project_uses_tech
ON  project_uses_tech.tech_id = tech.id
GROUP BY tech.id ORDER BY project_totals DESC;

#14 What is the average number of techs used per project?;
SELECT
AVG(tech_totals)
FROM (SELECT project.id, project.name, COUNT(project_uses_tech.project_id)AS tech_totals
FROM project 
LEFT OUTER JOIN project_uses_tech
ON  project_uses_tech.project_id = project.id
GROUP BY project.id ORDER BY tech_totals) AS techs_per_project;



# RESTAURANT DB V2

UPDATE student SET points=9 WHERE id = 1;
CREATE TABLE student (
  id SERIAL NOT NULL PRIMARY KEY,
  name VARCHAR,
  github VARCHAR,
  points INTEGER DEFAULT 0,
  start_date DATE,
  graduated BOOLEAN DEFAULT FALSE
);

#1 List all the reviews for a given restaurant given a specific restaurant ID.;#
SELECT review FROM review WHERE restaurant_id = 4;

#2 List all the reviews for a given restaurant, given a specific restaurant name.;#

SELECT review FROM review
JOIN restaurant
ON review.restaurant_id = restaurant.id
WHERE restaurant.name = 'R4';

#3 List all reviews for a given reviewer, given a spefic reviewers name.;

SELECT review FROM review
JOIN reviewer
ON review.reviewer_id = reviewer.id
WHERE reviewer.name = 'Old Fart';

#4 List all the reviews along with the restaurant they were written for.  In the query result, select the restaurant name and the review text.;

SELECT review, restaurant_id FROM review
JOIN restaurant
ON review.restaurant_id = restaurant.id
WHERE restaurant.name = 'R4';

#5 Get the average stars by restaurant. the result should have the restaurant name and its average star rating;.

SELECT restaurant.name, AVG(stars) AS avg_stars
FROM review
JOIN restaurant
ON restaurant_id = restaurant.id
WHERE restaurant.name = 'R4'
GROUP BY restaurant.name;

#6 Get the number of reviews written for each restaurant. The result should have the restaurant name and its review count.;

SELECT restaurant.name, COUNT(review) AS total_num_of_reviews
FROM review
JOIN restaurant
ON restaurant_id = restaurant.id
GROUP BY restaurant.name;

#7 List all the reviews along with the restaurant, and the reviewers name. The result should have the restaurant name, the review text, and the reviewer name. Hint: you will need to do a three-way join - i.e. joining all three tables together.;

SELECT review, restaurant.name AS restaurant_name, reviewer.name AS reviewer_name
FROM review
LEFT JOIN restaurant ON review.restaurant_id = restaurant.id
LEFT JOIN reviewer ON review.reviewer_id = reviewer.id;

#8 Get the average stars given by each reviewer(reviewer name, averag star rating);

SELECT reviewer.name, AVG(stars) AS avg_stars
FROM review
JOIN reviewer
ON reviewer_id = reviewer.id
GROUP BY reviewer.name;

#9 Get the lowest star rating given by each reviewer. (reviewer name, lowest star rating);

SELECT reviewer.name, MIN(stars) AS lowest_stars
FROM review
JOIN reviewer
ON reviewer_id = reviewer.id
GROUP BY reviewer.name;

#10 Get the number of restaurants in each category. (category name, restaurant count);
SELECT category, COUNT(name) AS restaurant_count
FROM restaurant
GROUP BY restaurant.category;

#11 Get number of 5 star reviews given by restaurant. (restaurant name, 5-star count);

SELECT restaurant.name AS restaurant_name, COUNT(stars) AS total_5_star_reviews
FROM review
JOIN restaurant
ON restaurant_id = restaurant.id
WHERE stars = 5
GROUP BY restaurant.name;

#12 Get the average star rating for a food category. (category name, average star rating);

SELECT restaurant.category, AVG(stars) AS avg_stars_by_category
FROM review
JOIN restaurant
ON restaurant_id = restaurant.id
GROUP BY restaurant.category;
