/*From 1970 – 2016, what is the largest number of wins for a team that did not win the 
world series? What is the smallest number of wins for a team that did win the world series?
Doing this will probably result in an unusually small number of wins for a world series
champion – determine why this is the case. Then redo your query, excluding the problem year.
How often from 1970 – 2016 was it the case that a team with the most wins also won the 
world series? What percentage of the time?*/

--part 1
SELECT MAX(t.w),
	   tf.franchname

FROM teams AS t
INNER JOIN teamsfranchises AS tf
ON t.franchid = tf.franchid
WHERE yearid BETWEEN 1970 AND 2016
      AND t.wswin ILIKE 'N'
GROUP BY tf.franchname
ORDER BY MAX(t.w) DESC;


--p2
SELECT MIN(t.w),
	   tf.franchname

FROM teams AS t
INNER JOIN teamsfranchises AS tf
ON t.franchid = tf.franchid
WHERE yearid BETWEEN 1970 AND 2016
      AND t.wswin ILIKE 'Y'
GROUP BY tf.franchname
ORDER BY MIN(t.w) ;


--p3 -1981
SELECT MIN(t.w),
	   tf.franchname,
	   yearid

FROM teams AS t
INNER JOIN teamsfranchises AS tf
ON t.franchid = tf.franchid
WHERE yearid BETWEEN 1970 AND 2016
      AND t.wswin ILIKE 'Y'
GROUP BY tf.franchname, yearid
ORDER BY MIN(t.w) ;


/*How often from 1970 – 2016 was it the case that a team with the most wins also won the 
world series? What percentage of the time?*/

WITH maxwins AS (SELECT yearid,
				        MAX(w) as maxw
				 FROM teams
				 GROUP BY yearid)
SELECT 
	   AVG(CASE WHEN t.wswin = 'Y' THEN 1 ELSE 0 END) AS wswinperc
FROM teams AS t
INNER JOIN maxwins AS mw
ON t.yearid = mw.yearid
WHERE t.yearid BETWEEN 1970 AND 2016
      AND t.yearid <> 1981
	  AND t.w = mw.maxw
