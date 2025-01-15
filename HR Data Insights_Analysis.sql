USE `hr_project`;
SET sql_safe_updates = 0;
SET sql_mode = '';

-- PROJECT QUESTIONS AND SOLUTIONS:
-- 1: What is the gender breakdown of emloyees currently in the company?
SELECT gender, COUNT(*) AS count
FROM `human resources`
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY gender;

-- 2: What is the race/ehnicity breakdown of emloyees in the company?
SELECT race, COUNT(*) AS count
FROM `human resources`
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY race
ORDER BY COUNT(*) DESC;

-- 3: What is the age distribution of employees in the company?
SELECT 
	MIN(age) AS youngest,
    MAX(age) AS oldest
FROM `human resources`
WHERE age >= 18 AND termdate = '0000-00-00';

SELECT
	CASE
		WHEN age >= 18 AND age <= 24 THEN '18-24'
        WHEN age >= 25 AND age <= 34 THEN '25-34'
        WHEN age >= 35 AND age <= 44 THEN '35-44'
        WHEN age >= 45 AND age <= 54 THEN '45-54'
        WHEN age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
	END AS age_group,
	COUNT(*) AS count
FROM `human resources`
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY age_group
ORDER BY age_group;

SELECT
	CASE
		WHEN age >= 18 AND age <= 24 THEN '18-24'
        WHEN age >= 25 AND age <= 34 THEN '25-34'
        WHEN age >= 35 AND age <= 44 THEN '35-44'
        WHEN age >= 45 AND age <= 54 THEN '45-54'
        WHEN age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
	END AS age_group, gender,
	COUNT(*) AS count
FROM `human resources`
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY age_group, gender
ORDER BY age_group, gender;

-- 4: How many Employees work at headquarters versus remote Locations?
SELECT location, count(*) AS count
FROM `human resources`
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location;

-- 5: What is the average length of enployment for the employees wh have been ternminated?
SELECT
avg(datediff(termdate, hire_date))/365 AS avg_lenght_employment
FROM `human resources`
WHERE termdate <= curdate() AND termdate <> '0000-00-00' AND age >= 18;

SELECT
round(avg(datediff(termdate, hire_date))/365,0) AS avg_lenght_employment
FROM `human resources`
WHERE termdate <= curdate() AND termdate <> '0000-00-00' AND age >= 18;


-- 6: How does the gender distribution vary across departments and titles?
SELECT department, gender, 
COUNT(*) AS coount
FROM `human resources`
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY department, gender
ORDER BY department;

-- 7: What is the distribution of job titles across the company?
SELECT jobtitle, COUNT(*) AS count
FROM `human resources`
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY jobtitle
ORDER BY jobtitle ASC;


-- 8: Which department has the highest turnover rate?
SELECT department, 
	total_count, 
    terminated_count,
	terminated_count/total_count AS termination_rate
FROM(
	SELECT department,
    COUNT(*) AS total_count,
    SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminated_count
    FROM `human resources`
    WHERE age >= 18
    GROUP BY department
    ) AS Subquery
ORDER BY termination_rate DESC;

-- 9: What is the distribution of employees across location by city and state?
SELECT location_state, COUNT(*) AS count
FROM `human resources`
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location_state
ORDER BY count DESC;

-- 10: How has the company's employee count changed over time based on the hire and term dates?
SELECT year,
hires, terminations,
hires - terminations AS net_change,
round((hires - terminations)/hires * 100, 2) AS net_change_percent
FROM(
	SELECT 
		year(hire_date) AS year,
        count(*) AS hires,
        SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminations
		FROM `human resources`
        WHERE age >= 18
        GROUP BY year(hire_date)
        ) AS subquery
ORDER BY year ASC;


-- 11: What is the tenure distribution for each department?
SELECT department, round(avg(datediff(termdate, hire_date)/365), 0) AS avg_tenure
FROM `human resources`
WHERE termdate <= curdate() AND termdate <> '0000-00-00' AND age >= 18
GROUP BY department;

