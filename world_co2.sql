CREATE Table country_info (
	id SERIAL PRIMARY KEY,
	country VARCHAR(50),
	year INT,
	population FLOAT,
	gdp FLOAT
);


CREATE TABLE co2 (
    ci_id SERIAL,
    cement_co2 FLOAT,
	co2 FLOAT, 
	coal_co2 FLOAT,
	gas_co2 FLOAT, 
	oil_co2 FLOAT,
    share_global_co2 FLOAT,
    FOREIGN KEY (ci_id) REFERENCES country_info(id)
);

SELECT * FROM co2;

SELECT * FROM country_info;

-- Join country_info/co2 tables
SELECT * FROM country_info AS ci
JOIN co2 AS co
ON ci.id = co.ci_id

-- Count entries of joined tables
SELECT COUNT(*)
FROM country_info AS ci
JOIN co2 AS co
ON ci.id = co.ci_id

--Total co2 by year
SELECT ci.year, SUM(co.co2) AS total_co2
FROM country_info as ci
JOIN co2 as co
    ON ci.id = co.ci_id
GROUP BY ci.year
ORDER BY total_co2 DESC


--Calculate and display the percentage of coal, oil, gas and cement CO2 emissions in total CO2 emissions by year, 
--ordered by year
SELECT ci.year, 
    ROUND(CAST(SUM(co.co2) AS numeric), 2) AS total_co2, 
    --ROUND(CAST(SUM(co.coal_co2) AS numeric), 2) AS total_coal,
    ROUND(CAST(SUM(co.coal_co2)/SUM(co.co2) AS numeric) * 100, 2) AS coal_percentage,
	ROUND(CAST(SUM(co.gas_co2)/SUM(co.co2) AS numeric) * 100, 2) AS gas_percentage,
	ROUND(CAST(SUM(co.oil_co)/SUM(co.co2) AS numeric) * 100, 2) AS oil_percentage,
	ROUND(CAST(SUM(co.cement_co2)/SUM(co.co2) AS numeric) * 100, 2) AS cement_percentage
FROM country_info as ci
JOIN co2 as co
    ON ci.id = co.ci_id
GROUP BY ci.year
ORDER BY ci.year


--Calculate and display the total historic co2 emissions and the percentage of that total ordered by top 10 countries
SELECT ci.country, 
    ROUND(CAST(SUM(co.co2) AS numeric), 2) AS cumlative_co2
FROM country_info AS ci
JOIN co2 AS co
    ON ci.id = co.ci_id
WHERE country != 'World' 
    AND country NOT LIKE '%countries' 
    AND country NOT LIKE '%(%' 
    AND country NOT IN ('Asia', 'Europe', 'North America', 'Africa', 'South America')
GROUP BY country
HAVING SUM(co.co2) NOTNULL
ORDER BY cumlative_co2 DESC
limit 10;
-- Creating a filtered view of the combined data, including only countries and no null co2 data
CREATE VIEW country_data AS
SELECT * FROM country_info AS ci
JOIN co2 AS co
ON ci.id = co.ci_id
WHERE co2 IS NOT NULL
    OR cement_co2 IS NOT NULL
    OR coal_co2 IS NOT NULL
	OR gas_co2 IS NOT NULL
	OR oil_co2 IS NOT NULL 
	
DROP VIEW country_data
--percent total with nested queries??
WITH total_co2 AS (
    SELECT SUM(CAST(co.co2 AS numeric)) AS total_co2
    FROM country_info AS ci
    JOIN co2 AS co
    ON ci.id = co.ci_id
)

SELECT ci.country, SUM(co.co2) FROM country_info AS ci
JOIN co2 AS co
ON ci.id = co.ci_id
GROUP BY country
HAVING SUM(co.co2) NOTNULL
ORDER BY SUM(co.co2) DESC

--Select and display total co2 of highest 10 countries, broken down by coal, gas, oil, and cement co2 for a specific year.

SELECT ci.country, co.co2, co.coal_co2, co.gas_co2, co.oil_co, co.cement_co2
FROM country_info AS ci
    JOIN co2 AS co
    ON ci.id = co.ci_id
WHERE country NOT IN('World', 'Africa', 'South America') 
    AND country NOT LIKE '%countries%'
    AND country NOT LIKE '%GCP%'
	AND country NOT LIKE '%International%'
	AND country NOT LIKE '%Asia%'
	AND country NOT LIKE '%Europe%'
	AND country NOT LIKE 'North America%'
    AND year = 1999
	AND co.co2 IS NOT NULL
	AND co.coal_co2 IS NOT NULL
	AND co.gas_co2 IS NOT NULL
	AND co.oil_co IS NOT NULL
	AND co.cement_co2 IS NOT NULL
ORDER BY co.oil_co DESC
LIMIT 10;

--Select and display c
SELECT *
FROM country_info AS ci
JOIN co2 AS co
ON ci.id = co.ci_id
WHERE year = 2021
    AND population IS NOT NULL
	AND country NOT LIKE '%countries%'
    AND country NOT LIKE '%GCP%'
	AND country NOT LIKE '%International%'
	AND country NOT LIKE '%Asia%'
	AND country NOT LIKE '%Europe%'
	AND country NOT LIKE 'North America%'
	AND country NOT IN('World', 'Africa', 'South America')
	AND co.co2 IS NOT NULL
	AND co.coal_co2 IS NOT NULL
	AND co.gas_co2 IS NOT NULL
	AND co.oil_co IS NOT NULL
	AND co.cement_co2 IS NOT NULL


