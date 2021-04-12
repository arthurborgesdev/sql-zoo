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