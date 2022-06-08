/*Find all players who hit their career highest number of home runs in 2016. 
Consider only players who have played in the league for at least 10 years, and who hit at 
least one home run in 2016. Report the players' first and last names and the number of 
home runs they hit in 2016.*/

--cte for hr and years played
WITH hrhit2016 AS (SELECT playerid, MAX(hr) AS maxhr 
			       FROM batting
			       WHERE hr >= 1
			       GROUP BY playerid)

SELECT DISTINCT p.namefirst, 
	   p.namelast,
	   maxhr
	  	   
FROM people AS p
INNER JOIN hrhit2016 ON p.playerid = hrhit2016.playerid
INNER JOIN batting ON p.playerid = batting.playerid
WHERE (2016-EXTRACT(year FROM debut::date)) >= 10
	  AND batting.yearid = 2016
	  AND hr=maxhr