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



SELECT  pos,
		SUM(PO) AS sum_po,
	CASE WHEN pos = 'ss' or pos = '1B' or pos = '2B' or pos = '3B' THEN 'infield'
		 WHEN pos = 'OF' THEN 'outfield' 
		 WHEN pos = 'P' or pos = 'C' THEN 'battery' END AS position
		 
FROM fielding
WHERE yearid = 2016
ORDER BY pos;
--
WITH something AS
		(SELECT  SUM(PO) OVER(PARTITION BY pos) AS sum_po,
			CASE WHEN pos = 'ss' or pos = '1B' or pos = '2B' or pos = '3B' THEN 'infield'
				 WHEN pos = 'OF' THEN 'outfield' 
		 		 WHEN pos = 'P' or pos = 'C' THEN 'battery' END AS position)
		 
FROM fielding
WHERE yearid = 2016
GROUP BY position

SELECT  DISTINCT(position)
from fielding;


--

SELECT DISTINCT(position)
From (SELECT pos,
		SUM(PO) OVER() AS sum_po,
	CASE WHEN pos = 'ss' or pos = '1B' or pos = '2B' or pos = '3B' THEN 'infield'
		 WHEN pos = 'OF' THEN 'outfield' 
		 WHEN pos = 'P' or pos = 'C' THEN 'battery' END AS position
		 
FROM fielding
WHERE yearid = 2016
ORDER BY pos)
--winner
WITH newt AS(SELECT pos,
		SUM(PO) OVER() AS sum_po,
	CASE WHEN pos = 'ss' or pos = '1B' or pos = '2B' or pos = '3B' THEN 'infield'
		 WHEN pos = 'OF' THEN 'outfield' 
		 WHEN pos = 'P' or pos = 'C' THEN 'battery' END AS position
		 
FROM fielding
WHERE yearid = 2016
ORDER BY pos)

SELECT DISTINCT(position), sum_po
FROM newt


--

WITH newt AS(SELECT pos,
		SUM(PO)  OVER(PARTITION BY po) AS sum_po,
	CASE WHEN pos = 'ss' or pos = '1B' or pos = '2B' or pos = '3B' THEN 'infield'
		 WHEN pos = 'OF' THEN 'outfield' 
		 WHEN pos = 'P' or pos = 'C' THEN 'battery' END AS position
		 
FROM fielding
WHERE yearid = 2016
ORDER BY pos)

SELECT position, sum_po
FROM newt

-- Q4 CORRECT ANSWERS

WITH newt AS(SELECT pos,
		  	 		PO AS sum_po,
	CASE WHEN pos = 'ss' or pos = '1B' or pos = '2B' or pos = '3B' THEN 'infield'
		 WHEN pos = 'OF' THEN 'outfield' 
		 WHEN pos = 'P' or pos = 'C' THEN 'battery' END AS position
		 	
		FROM fielding
		WHERE yearid = 2016
		ORDER BY pos)

SELECT DISTINCT(position), SUM(sum_po)
FROM newt
WHERE position is not null
GROUP BY  position;


/*Using the attendance figures from the homegames table, find the teams and parks which had the top 5 average attendance per game
in 2016 (where average attendance is defined as total attendance divided by number of games). Only consider parks where there were
at least 10 games played. Report the park name, team name, and average attendance. Repeat for the lowest 5 average attendance.*/
SELECT *
FROM homegames;

SELECT team, park
FROM homegames;

SELECT park, team
FROM homegames
WHERE games > 10;

--P1
SELECT team, h.park, ROUND(AVG(attendance/games::decimal),2) as avat
FROM homegames as h
WHERE year = 2016 AND  games > 10
GROUP BY team, h.park
ORDER BY avat DESC
LIMIT 5;


--P2
SELECT team, h.park, ROUND(AVG(attendance/games::decimal),2) as avat
FROM homegames as h
WHERE year = 2016 AND  games > 10
GROUP BY team, h.park
ORDER BY avat ASC
LIMIT 5;


/*9. Which managers have won the TSN Manager of the Year award in both the National League (NL) and the American League
(AL)? Give their full name and the teams that they were managing when they won the award.*/

SELECT *
FROM awardsmanagers
--where awardid ='TSN Manager of the Year' AND (lgid = 'NL' or lgid = 'AL';


SELECT p.namefirst, p.namelast, a.yearid
FROM awardsmanagers as a
left join people as p
on a.playerid = p.playerid
where a.awardid ='TSN Manager of the Year' AND a.lgid = 'NL' or a.lgid = 'AL';

WITH an AS (SELECT p.namefirst as fa, p.namelast as la, a.yearid as ya
		    FROM awardsmanagers as a
		    left join people as p
		    on a.playerid = p.playerid
		    where a.awardid ='TSN Manager of the Year' AND a.lgid = 'NL'),
			
			al AS (SELECT p.namefirst as faa, p.namelast as laa, a.yearid as yaa
		   			 FROM awardsmanagers as a
		    		left join people as p
		    		on a.playerid = p.playerid
		    		where a.awardid ='TSN Manager of the Year' AND a.lgid = 'AL')
		 
SELECT fa, la, ya
FROM an
LEFT JOIN  al
ON an.fa = al.faa
ORDER BY ya

											  














