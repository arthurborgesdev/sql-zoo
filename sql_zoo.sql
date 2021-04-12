/* 0 - SELECT BASICS */
-- 0.1
SELECT population FROM world
  WHERE name = 'Germany'

-- 0.2
SELECT name, population FROM world
  WHERE name IN ('Sweden', 'Norway', 'Denmark');

-- 0.3
SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000


/* 1 - SELECT NAMES */
-- 1.1
SELECT name FROM world
  WHERE name LIKE 'Y%'

-- 1.2
SELECT name FROM world
  WHERE name LIKE '%y'

-- 1.3
SELECT name FROM world
  WHERE name LIKE '%x%'

-- 1.4
SELECT name FROM world
  WHERE name LIKE '%land'

-- 1.5
SELECT name FROM world
  WHERE name LIKE 'C%ia'

-- 1.6
SELECT name FROM world
  WHERE name LIKE '%oo%'

-- 1.7
SELECT name FROM world
  WHERE name LIKE '%a%a%a%'

-- 1.8
SELECT name FROM world
 WHERE name LIKE '_t%'
ORDER BY name

-- 1.9
SELECT name FROM world
 WHERE name LIKE '%o__o%'

-- 1.10
SELECT name FROM world
 WHERE name LIKE '____'

-- 1.11
SELECT name
  FROM world
 WHERE name LIKE capital

-- 1.12
SELECT name 
  FROM world
 WHERE capital = concat(name, ' City')

-- 1.13
SELECT capital, name
  FROM world
 WHERE capital LIKE concat('%', name, '%')

-- 1.14
SELECT capital, name
  FROM world
 WHERE capital LIKE concat(name, '_%')

-- 1.15
SELECT name, REPLACE(capital, name, '')
  FROM world
 WHERE capital LIKE concat(name, '_%')


/* 2 - SELECT FROM WORLD */

-- 2.1 
SELECT name, continent, population FROM world

-- 2.2
SELECT name
  FROM world
 WHERE population > 200000000

-- 2.3
SELECT name, gdp/population AS per_capita_gdp
  FROM world
 WHERE population > 200000000

-- 2.4
SELECT name, population/1000000 AS population_millions
  FROM world
 WHERE continent LIKE 'South America'

-- 2.5
SELECT name, population
  FROM world
 WHERE name IN('France', 'Germany', 'Italy')

-- 2.6
SELECT name
  FROM world
 WHERE name LIKE '%United%'

-- 2.7
SELECT name, population, area
  FROM world
 WHERE area > 3000000 OR population > 250000000

-- 2.8
SELECT name, population, area
  FROM world
 WHERE area > 3000000 XOR population > 250000000

-- 2.9
SELECT name, ROUND(population/1000000, 2) AS population_millions, ROUND(gdp/1000000000, 2) AS gdp_billions
  FROM world
 WHERE continent = 'South America'

-- 2.10
SELECT name, ROUND(gdp/population, -3) AS gdp_per_capita
  FROM world
 WHERE gdp >= 1000000000000