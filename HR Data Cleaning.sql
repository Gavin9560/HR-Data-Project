SET sql_safe_updates = 0;

USE `hr_project`;

SELECT * FROM `human resources`;

ALTER TABLE `human resources`
CHANGE COLUMN ï»¿id empl_id VARCHAR(20) NULL;

DESCRIBE `human resources`;

SELECT birthdate FROM `human resources`;

UPDATE `human resources`
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date (birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date (birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE `human resources`
MODIFY COLUMN birthdate DATE;

SELECT hire_date FROM `human resources`;

UPDATE `human resources`
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date (hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date (hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE `human resources`
MODIFY COLUMN hire_date DATE;

SELECT termdate FROM `human resources`;

-- Step 1: Update invalid or empty values to NULL
UPDATE `human resources`
SET termdate = NULL
WHERE termdate = '' OR termdate IS NULL;

-- Step 2: Format termdate values correctly
UPDATE `human resources`
SET termdate = DATE(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != '';

-- Step 3: Modify the column to the DATE data type
ALTER TABLE `human resources`
MODIFY COLUMN termdate DATE;

UPDATE `human resources`
SET termdate = '0000-00-00'
WHERE termdate IS NULL;

SET sql_mode = '';

-- Changing other column's data type, we have:
ALTER TABLE `human resources`
MODIFY COLUMN last_name VARCHAR(20);

ALTER TABLE `human resources`
MODIFY COLUMN gender VARCHAR(7);

ALTER TABLE `human resources`
MODIFY COLUMN race VARCHAR(20);

ALTER TABLE `human resources`
MODIFY COLUMN department VARCHAR(30);

ALTER TABLE `human resources`
MODIFY COLUMN jobtitle VARCHAR(50);

ALTER TABLE `human resources`
MODIFY COLUMN location VARCHAR(50);

ALTER TABLE `human resources`
MODIFY COLUMN location_city VARCHAR(45);

ALTER TABLE `human resources`
MODIFY COLUMN location_state VARCHAR(50);

ALTER TABLE `human resources`
ADD COLUMN age INT;

UPDATE `human resources`
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT birthdate, age FROM `human resources`;

SELECT
	MIN(age) AS youngest,
    MAX(age) AS Oldest
FROM `human resources`;

SELECT COUNT(*) FROM `human resources` 
WHERE age < 18;

SELECT * FROM `human resources`;