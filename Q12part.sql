/*In this question, you will explore the connection between number of wins and attendance.
    <ol type="a">
      <li>Does there appear to be any correlation between attendance at home games and 
	  number of wins? </li>
      <li>Do teams that win the world series see a boost in attendance the following year? 
	  What about teams that made the playoffs? Making the playoffs means either being a 
	  division winner or a wild card winner.</li>
    </ol>*/

--more wins = more people but correlation is iffy 
SELECT t.teamid,
	   t.w,
	   ROUND(AVG(hg.attendance), 2) AS avg_attendance
FROM teams AS t
INNER JOIN homegames AS hg ON t.teamid = hg.team
GROUP BY t.teamid, t.w
ORDER BY t.w DESC;

/*Do teams that win the world series see a boost in attendance the following year? 
	  What about teams that made the playoffs? Making the playoffs means either being a 
	  division winner or a wild card winner.*/

--FOR WS WINNERS
WITH atten AS (SELECT hg.team,
			  		  hg.year,
			  		  hg.attendance,
			  		  LEAD(hg.attendance) OVER(PARTITION BY hg.team ORDER BY hg.year) AS nxt_yr_atten
				FROM teams AS t INNER JOIN homegames AS hg ON t.teamid = hg.team AND t.yearid = hg.year)
SELECT teams.teamid,
	   atten.attendance,
	   atten.nxt_yr_atten
FROM atten INNER JOIN teams ON atten.team = teams.teamid AND atten.year = teams.yearid
WHERE wswin ILIKE 'y'
ORDER BY atten.year DESC


--FOR PLAYOFF WINNERS
WITH atten AS (SELECT hg.team,
			  		  hg.year,
			  		  hg.attendance,
			  		  LEAD(hg.attendance) OVER(PARTITION BY hg.team ORDER BY hg.year) AS nxt_yr_atten
				FROM teams AS t INNER JOIN homegames AS hg ON t.teamid = hg.team AND t.yearid = hg.year)
SELECT teams.teamid,
	   atten.attendance,
	   atten.nxt_yr_atten,
	   atten.nxt_yr_atten/atten.attendance::decimal
FROM atten INNER JOIN teams ON atten.team = teams.teamid AND atten.year = teams.yearid
WHERE teams.divwin ILIKE 'y'
	  OR teams.wcwin ILIKE 'y'
ORDER BY atten.year DESC
