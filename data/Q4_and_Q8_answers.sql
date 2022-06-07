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

--Q8

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