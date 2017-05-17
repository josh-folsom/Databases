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
WHERE project_id is NULL;


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