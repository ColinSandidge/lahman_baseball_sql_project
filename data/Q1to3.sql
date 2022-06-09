SELECT *
FROM salaries
-- Q1
SELECT MIN (yearid),
	   MAX (yearid)
FROM batting
-- Q2

-- Q3 Find all players in the database who played at Vanderbilt University. Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues. Sort this list in descending order by the total salary earned. Which Vanderbilt player earned the most money in the majors?
WITH vandy_players AS (SELECT *
						FROM collegeplaying
						WHERE schoolid = 'vandy')
SELECT DISTINCT people.playerid, namefirst, namelast, salary 
FROM vandy_players
INNER JOIN people ON vandy_players.playerid = people.playerid
INNER JOIN salaries ON people.playerid = salaries.playerid
WHERE salary IN (SELECT SUM(salary) FROM salaries GROUP BY playerid)
ORDER BY salary DESC;