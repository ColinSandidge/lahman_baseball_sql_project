/* Find the player who had the most success stealing bases in 2016, where __success__ 
is measured as the percentage of stolen base attempts which are successful. 
(A stolen base attempt results either in a stolen base or being caught stealing.) 
Consider only players who attempted _at least_ 20 stolen bases.*/


SELECT p.namegiven,
	   ROUND((b.sb-b.cs)/b.sb::decimal*100, 2) AS percent_successful_steals

FROM people AS p
INNER JOIN batting AS b
ON p.playerid = b.playerid
WHERE b.sb >= 20 AND yearid = 2016
GROUP BY p.namegiven, b.cs, b.sb
ORDER BY percent_successful_steals DESC