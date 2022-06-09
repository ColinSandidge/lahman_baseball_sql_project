SELECT MIN(yearid),
		MAX(yearid)
FROM batting;

select * 
from teams;

select * 
from fielding
WHERE yearid = 2016;

SELECT pos  as infield
FROM  fielding
WHERE pos = 'ss' or pos = '1B' or pos = '2B' or pos = '3B';

SELECT pos  as outfield
FROM  fielding
WHERE pos = 'OF';

SELECT pos  as battery
FROM  fielding
WHERE pos = 'P' pos = 'C';



SELECT pos,
		SUM(PO) OVER() AS sum_po,
	CASE WHEN pos = 'ss' or pos = '1B' or pos = '2B' or pos = '3B' THEN 'infield'
		 WHEN pos = 'OF' THEN 'outfield' 
		 WHEN pos = 'P' or pos = 'C' THEN 'battery' END AS position
		 
FROM fielding
WHERE yearid = 2016
ORDER BY pos;
--
WITH qqq AS
		(SELECT  SUM(PO) OVER(PARTITION BY pos) AS sum_po,
			CASE WHEN pos = 'ss' or pos = '1B' or pos = '2B' or pos = '3B' THEN 'infield'
				 WHEN pos = 'OF' THEN 'outfield' 
		 		 WHEN pos = 'P' or pos = 'C' THEN 'battery' END AS position)
		 
FROM fielding
WHERE yearid = 2016
GROUP BY position

SELECT  DISTINCT(position)
from fielding;


WITH vandy_players AS (SELECT *
 						FROM collegeplaying
 						WHERE schoolid = 'vandy')
 SELECT DISTINCT people.playerid, namefirst, namelast, salary 
 FROM vandy_players
 INNER JOIN people ON vandy_players.playerid = people.playerid
 INNER JOIN salaries ON people.playerid = salaries.playerid
 WHERE salary IN (SELECT SUM(salary) FROM salaries GROUP BY playerid)
 ORDER BY salary DESC;









