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


/* 6 - JOIN */
-- 6.1
SELECT matchid, player FROM goal 
  WHERE teamid = 'GER'

-- 6.2
SELECT id,stadium,team1,team2
  FROM game
 WHERE id = 1012

-- 6.3
SELECT player, teamid, stadium, mdate
  FROM game JOIN goal ON (id=matchid)
 WHERE teamid = 'GER'

-- 6.4
SELECT team1, team2, player
  FROM game JOIN goal ON (id = matchid)
 WHERE player LIKE 'Mario%'

-- 6.5
SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam ON (teamid=id)
 WHERE gtime<=10

-- 6.6
SELECT mdate, teamname
  FROM game JOIN eteam ON (team1 = eteam.id)
 WHERE coach = 'Fernando Santos'

-- 6.7
SELECT player
  FROM game JOIN goal ON (matchid=id)
 WHERE stadium = 'National Stadium, Warsaw'

-- 6.8
SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id 
    WHERE teamid != 'GER' AND (team1 = 'GER' OR team2 ='GER')

-- 6.9
SELECT teamname, COUNT(matchid)
  FROM eteam JOIN goal ON id=teamid
 GROUP BY teamname

-- 6.10
SELECT stadium, COUNT(1)
  FROM game JOIN goal ON (game.id = goal.matchid)
 GROUP BY stadium

-- 6.11
SELECT matchid, mdate, COUNT(teamid)
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
  GROUP BY matchid, mdate

-- 6.12
SELECT matchid, mdate, COUNT(teamid)
  FROM game JOIN goal ON matchid = id
 WHERE(teamid = 'GER')
  GROUP BY matchid, mdate

-- 6.13 (NOT COVERED BEFORE)

/* 7 - MORE JOIN */
-- 7.1
SELECT id, title
 FROM movie
 WHERE yr=1962

-- 7.2
SELECT yr
  FROM movie
 WHERE title = 'Citizen Kane'

-- 7.3
SELECT id, title, yr
  FROM movie
 WHERE title LIKE '%Star Trek%'
 ORDER BY yr

-- 7.4
SELECT id
  FROM actor
 WHERE name = 'Glenn Close'

-- 7.5
SELECT id
  FROM movie
 WHERE title = 'Casablanca'

-- 7.6
SELECT name
  FROM movie JOIN casting ON (movie.id = casting.movieid)
             JOIN actor ON (casting.actorid = actor.id)
  WHERE movieid = 11768 

-- 7.7
SELECT name
  FROM movie JOIN casting ON (movie.id = casting.movieid)
             JOIN actor ON (casting.actorid = actor.id)
  WHERE title = 'Alien' 

-- 7.8
SELECT title
  FROM movie JOIN casting ON (movie.id = casting.movieid)
             JOIN actor ON (casting.actorid = actor.id)
  WHERE name = 'Harrison Ford' 

-- 7.9
SELECT title
  FROM movie JOIN casting ON (movie.id = casting.movieid)
             JOIN actor ON (casting.actorid = actor.id)
  WHERE name = 'Harrison Ford' AND ord != 1

-- 7.10
SELECT title, name
  FROM movie JOIN casting ON (movie.id = casting.movieid)
             JOIN actor ON (casting.actorid = actor.id)
  WHERE yr = 1962 AND ord = 1

-- 7.11
SELECT yr, COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
  WHERE name='Rock Hudson'
  GROUP BY yr
  HAVING COUNT(title) > 2

-- 7.12 (BASED FROM YOUTUBE)
SELECT movie.title, actor.name
FROM movie
JOIN casting ON casting.movieid = movie.id
JOIN actor ON casting.actorid = actor.id
WHERE  movie.id IN (SELECT movie.id
                     FROM movie
                     JOIN casting ON casting.movieid = movie.id
                     JOIN actor ON casting.actorid = actor.id
                     WHERE actor.name = 'Julie Andrews'
) AND casting.ord = 1

-- (HARD ONES, SAVE FOR LATER)
-- 7.13
-- 7.14
-- 7.15 


/* 8 - USING NULL */
-- 8.1
SELECT name
  FROM teacher
 WHERE dept IS NULL

-- 8.2
SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)

-- 8.3
SELECT teacher.name, dept.name
  FROM teacher LEFT JOIN dept
    ON (teacher.dept = dept.id)

-- 8.4
SELECT teacher.name, dept.name
  FROM teacher RIGHT JOIN dept
    ON (teacher.dept = dept.id)

-- 8.5
SELECT name, COALESCE(mobile, '07986 444 2266')
  FROM teacher

-- 8.6
SELECT teacher.name, COALESCE(dept.name, 'None')
  FROM teacher LEFT JOIN dept ON (teacher.dept = dept.id)

-- 8.7
SELECT COUNT(teacher.name), COUNT(teacher.mobile)
  FROM teacher 

-- 8.8
SELECT dept.name, COUNT(teacher.name)
  FROM teacher RIGHT JOIN dept ON (teacher.dept = dept.id)
 GROUP BY dept.name

-- 8.9
SELECT name, CASE WHEN dept IS NULL THEN 'Art' ELSE 'Sci' END
  FROM teacher

-- 8.10
SELECT teacher.name,
  CASE WHEN dept IS NULL THEN 'None'
       WHEN dept = 3 THEN 'Art'
       ELSE 'Sci'
  END
 FROM teacher

 
/* 9 - SELF JOIN */
-- 9.1
SELECT COUNT(id)
  FROM stops

-- 9.2
SELECT id
  FROM stops
 WHERE name = 'Craiglockhart'

-- 9.3
SELECT id, name
  FROM stops JOIN route ON (stops.id = route.stop)
 WHERE num = '4' AND company = 'LRT'

-- 9.4
SELECT company, num, COUNT(*)
  FROM route 
 WHERE stop=149 OR stop=53
 GROUP BY company, num
 HAVING COUNT(*) = 2

-- 9.5
SELECT a.company, a.num, a.stop, b.stop
  FROM route a 
 JOIN route b ON (a.num = b.num)
 WHERE a.stop = 53
 AND b.stop = 149

-- 9.6
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'
AND stopb.name = 'London Road'

-- 9.7
-- 9.8
-- 9.9
-- 9.10 (SELF JOINS - DO LATER)