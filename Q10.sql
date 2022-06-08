/*Find all players who hit their career highest number of home runs in 2016. 
Consider only players who have played in the league for at least 10 years, and who hit at 
least one home run in 2016. Report the players' first and last names and the number of 
home runs they hit in 2016.*/

--cte for hr and years played
WITH hrhit2016 AS (SELECT playerid, yearid, MAX(hr) AS maxhr 
			   FROM batting
			   WHERE yearid = 2016 
			   		 AND hr >= 1
			   GROUP BY playerid, yearid),
     years AS (SELECT playerid, SUM(yearid) AS sumyears
			   FROM batting
			   GROUP BY playerid)


--
SELECT p.namefirst, 
	   p.namelast,
	   b.hr
	   
FROM batting AS b
INNER JOIN people AS p ON b.playerid = p.playerid
INNER JOIN hrhit2016 ON b.playerid = hrhit2016.playerid
INNER JOIN years ON b.playerid = years.playerid
WHERE years.sumyears >= 22121
      AND b.hr >= hrhit2016.maxhr
	  AND b.yearid = 2016