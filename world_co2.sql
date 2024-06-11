/*World Co2 exploration

Skills used: Joins, CTE's, Case Statements, Window Functions, Aggregate Functions, Creating Views, Converting Data Types*/

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

--Select and display all the data that will be used
SELECT 
    ci.country, 
    ci.year, 
	ci.population, 
	ci.gdp, 
	co.cement_mt, 
	co.co2_mt, 
	co.coal_mt, 
	co.gas_mt, 
	co.oil_mt
FROM country_info ci
    JOIN co2 co
    ON ci.id = co.ci_id;
	

-- Creating a filtered view of the combined data, including only current countries and no null co2 data
CREATE VIEW current_countries AS
SELECT 
    ci.country, 
	ci.year, 
	ci.population, 
	ci.gdp, 
	co.cement_mt, 
	co.co2_mt, 
	co.coal_mt, 
	co.gas_mt, 
	co.oil_mt
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
	AND co.co2_mt IS NOT NULL
	AND co.coal_mt IS NOT NULL
	AND co.gas_mt IS NOT NULL
	AND co.oil_mt IS NOT NULL
	AND co.cement_mt IS NOT NULL;


--Select and display total cumulative co2 levels
SELECT 
    country, 
	ROUND(SUM(co2_mt)) as cumulative_co2
FROM current_countries
GROUP BY country
HAVING SUM(co2_mt) IS NOT NULL
ORDER BY cumulative_co2 DESC
LIMIT 10;


--SELECT and display co2 per capita levels for Canada in metric tonnes
SELECT 
    country, 
	year, 
	ROUND(CAST(co2_mt/population*1000000 AS numeric),2) AS per_capita_co2
FROM current_countries
WHERE country = 'Canada';


--Calculate and display percentage change in per capita year over year
WITH per_capita AS(
SELECT 
    country, 
	year, 
	ROUND(CAST(co2_mt/population*1000000 AS numeric),2) AS per_capita_co2
FROM current_countries
)
, per_capita_lag AS (
SELECT 
	country, 
	year, 
	per_capita_co2,
	LAG(per_capita_co2) OVER (PARTITION BY country ORDER BY year) AS prev_per_capita
FROM per_capita
)
SELECT 
    country, 
	year, 
	per_capita_co2, 
	CASE
	    WHEN prev_per_capita IS NULL THEN NULL
		ELSE ROUND((per_capita_co2 - prev_per_capita) / prev_per_capita * 100)
	END AS pct_change
FROM per_capita_lag
WHERE year = 2020
ORDER BY pct_change;


/*Calculate and display the percentage of coal, oil, gas and cement CO2 emissions
in total cumulative CO2 emissions by year*/
SELECT 
    year, 
    ROUND(CAST(SUM(co2_mt) AS numeric), 2) AS total_co2, 
    ROUND(CAST(SUM(coal_mt)/SUM(co2_mt) AS numeric) * 100, 2) AS coal_percentage,
	ROUND(CAST(SUM(gas_mt)/SUM(co2_mt) AS numeric) * 100, 2) AS gas_percentage,
	ROUND(CAST(SUM(oil_mt)/SUM(co2_mt) AS numeric) * 100, 2) AS oil_percentage,
	ROUND(CAST(SUM(cement_mt)/SUM(co2_mt) AS numeric) * 100, 2) AS cement_percentage
FROM current_countries
GROUP BY year
ORDER BY year;


/*Calculate and display the percentage of coal, oil, gas and cement CO2 emissions
in total cumulative CO2 emissions by country*/
SELECT 
    country,
	ROUND(CAST(SUM(co2_mt) AS numeric), 2) AS total_co2, 
    ROUND(CAST(SUM(coal_mt)/SUM(co2_mt) AS numeric) * 100, 2) AS coal_percentage,
	ROUND(CAST(SUM(gas_mt)/SUM(co2_mt) AS numeric) * 100, 2) AS gas_percentage,
	ROUND(CAST(SUM(oil_mt)/SUM(co2_mt) AS numeric) * 100, 2) AS oil_percentage,
	ROUND(CAST(SUM(cement_mt)/SUM(co2_mt) AS numeric) * 100, 2) AS cement_percentage
FROM current_countries
GROUP BY country
ORDER BY total_co2 DESC;
 

--Calculate and display the total historic co2 emissions and the percentage of that total ordered by top 10 countries
WITH total_co2 AS(
SELECT 
	ROUND(SUM(co2_mt)*1000000) AS total_co2
FROM current_countries
)

SELECT 
    country, 
	ROUND(SUM(cc.co2_mt)) AS total_co2_mt,
    ROUND(SUM(cc.co2_mt*1000000/tc.total_co2 * 100)) AS percentage
FROM current_countries cc
CROSS JOIN total_co2 tc
GROUP BY country
ORDER BY percentage DESC
LIMIT 10;


--Calculate and display year over year percentage change
WITH lag_data AS (
SELECT 
    year, 
	country,
	gdp,
	population,
	co2_mt,
	LAG(gdp) OVER (PARTITION BY country ORDER BY year) AS prev_gdp,
	LAG(co2_mt) OVER (PARTITION BY country ORDER BY year) AS prev_co2,
	LAG(population) OVER (PARTITION BY country ORDER BY year) AS prev_pop
FROM current_countries
)
SELECT 
    year, 
	country,
	gdp,
	CASE
	    WHEN prev_gdp != 0
		THEN ROUND((gdp - prev_gdp)/prev_gdp * 100)
		ELSE NULL
	END AS gdp_pct_change,
	co2_mt,
	CASE
	    WHEN prev_co2 != 0
		THEN ROUND((co2_mt - prev_co2)/prev_co2 * 100)
		ELSE NULL
	END AS co2_pct_change,
	population,
	CASE
	    WHEN prev_pop != 0
		THEN ROUND((population - prev_pop)/prev_pop * 100)
		ELSE NULL
	END AS pop_pct_change
FROM lag_data
WHERE country = 'Canada';
