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

-- 2.11
SELECT name, capital
  FROM world
 WHERE LENGTH(name) = LENGTH(capital)

-- 2.12
SELECT name, capital
  FROM world
 WHERE LEFT(name, 1) = LEFT(capital, 1) AND name <> capital

-- 2.13
SELECT name
   FROM world
WHERE name LIKE '%a%' AND name LIKE '%e%' AND name LIKE '%i%' AND name LIKE '%o%' AND name LIKE '%u%'
  AND name NOT LIKE '% %'


/* 3 - SELECT FROM NOBEL */
-- 3.1 
SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950

-- 3.2
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature'

-- 3.3
SELECT yr, subject
  FROM nobel
 WHERE winner = 'Albert Einstein'

-- 3.4
SELECT winner
  FROM nobel
 WHERE subject = 'Peace' AND yr >= 2000

-- 3.5
SELECT *
  FROM nobel
 WHERE subject = 'Literature' AND yr >= 1980 AND yr <= 1989

-- 3.6
SELECT * FROM nobel
 WHERE winner IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Jimmy Carter',
                  'Barack Obama')

-- 3.7
SELECT winner
  FROM nobel
 WHERE winner LIKE 'John%'

-- 3.8
SELECT yr, subject, winner
  FROM nobel
 WHERE (subject LIKE 'Physics' AND yr = 1980) OR (subject LIKE 'Chemistry' AND yr = 1984) 

-- 3.9
SELECT *
  FROM nobel
 WHERE yr = 1980 AND subject NOT IN('Chemistry', 'Medicine')

-- 3.10
SELECT yr, subject, winner
  FROM nobel
 WHERE (subject LIKE 'Medicine' AND yr < 1910) OR (subject LIKE 'Literature' AND yr >= 2004)

-- 3.11
SELECT *
  FROM nobel
 WHERE winner LIKE 'PETER GRÜNBERG'

-- 3.12
SELECT *
  FROM nobel
 WHERE winner LIKE "EUGENE O\'NEILL"

-- 3.13
SELECT winner, yr, subject
  FROM nobel
 WHERE winner LIKE 'Sir%'

-- 3.14
SELECT winner, subject
  FROM nobel
 WHERE yr=1984
 ORDER BY subject IN ('Physics','Chemistry'), subject, winner


/* 4 - SELECT IN SELECT */
-- 4.1
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

-- 4.2
SELECT name 
  FROM world
 WHERE gdp/population > (
    SELECT
      gdp/population FROM world WHERE name = 'United Kingdom'
 ) AND continent = 'Europe'

-- 4.3
SELECT name, continent
  FROM world
 WHERE continent IN(
  SELECT continent
    FROM world
   WHERE name = 'Argentina' OR name = 'Australia'
  ) ORDER BY name

-- 4.4
SELECT name, population
  FROM world
 WHERE population > (SELECT population FROM world WHERE name = 'Canada') AND 
       population < (SELECT population FROM world WHERE name = 'Poland')

-- 4.5
SELECT name, CONCAT(ROUND(100*population/(SELECT population FROM world WHERE name = 'Germany')), '%')
 FROM world
  WHERE continent = 'Europe'

-- 4.6
SELECT name
  FROM world
 WHERE gdp > ALL(SELECT gdp FROM world WHERE gdp > 0 AND continent = 'Europe') 

-- 4.7
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0)

-- 4.8
SELECT continent, name FROM world x
  WHERE name = (SELECT name FROM world y
                 WHERE x.continent = y.continent
                 LIMIT 1)

-- 4.9 (NOT COVERED BEFORE)
-- 4.10 (NOT COVERED BEFORE)

/* 5 - SUM AND COUNT */
-- 5.1
SELECT SUM(population)
  FROM world

-- 5.2
SELECT DISTINCT continent
  FROM world

-- 5.3
SELECT SUM(gdp)
  FROM world
 WHERE continent = 'Africa'

-- 5.4
SELECT COUNT(name)
  FROM world
 WHERE area > 1000000

-- 5.5
SELECT SUM(population)
  FROM world
 WHERE name IN('Estonia', 'Latvia', 'Lithuania')


-- (USING GROUP BY AND HAVING)
-- extra 1
SELECT continent, COUNT(name)
  FROM world
 GROUP BY continent

-- extra 2
SELECT continent, SUM(population)
  FROM world
 GROUP BY continent

-- extra 3
SELECT continent, COUNT(name)
  FROM world
 WHERE population>200000000
 GROUP BY continent

-- extra 4
SELECT continent, SUM(population)
  FROM world
 GROUP BY continent
HAVING SUM(population)>500000000


-- 5.6
SELECT continent, COUNT(name)
  FROM world
 GROUP BY continent

-- 5.7
SELECT continent, COUNT(name)
  FROM world
 WHERE population > 10000000
 GROUP BY continent

-- 5.8
SELECT continent
  FROM world
 GROUP BY continent
 HAVING SUM(population) > 100000000
