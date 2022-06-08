--Q11
/*Is there any correlation between number of wins and team salary? 
Use data from 2000 and later to answer this question. As you do this analysis, 
keep in mind that salaries across the whole league tend to increase together, 
so you may want to look on a year-by-year basis. */

WITH total_team_salary AS (SELECT yearid, teamid, SUM(salary) as year_team_salary
						FROM salaries
						WHERE yearid >= 2000
						GROUP BY yearid, teamid
						ORDER BY yearid, teamid)
SELECT total_team_salary.yearid, total_team_salary.teamid, year_team_salary, teams.w
		
FROM total_team_salary LEFT JOIN teams ON teams.teamid = total_team_salary.teamid
WHERE teams.yearid = total_team_salary.yearid
GROUP BY total_team_salary.yearid, total_team_salary.teamid, year_team_salary, teams.w
ORDER BY total_team_salary.yearid, total_team_salary.teamid;

--Q12
/* 12. In this question, you will explore the connection between number of wins and attendance.
    <ol type="a">
      <li>Does there appear to be any correlation between attendance at home games and number of wins? </li>
      <li>Do teams that win the world series see a boost in attendance the following year? What about teams that made the playoffs? Making the playoffs means either being a division winner or a wild card winner. */
WITH total_team_salary AS (SELECT yearid, teamid, SUM(salary) as year_team_salary
						FROM salaries
						WHERE yearid >= 2000
						GROUP BY yearid, teamid
						ORDER BY yearid, teamid)
SELECT total_team_salary.yearid, total_team_salary.teamid, year_team_salary, teams.w, teams.attendance as home_games, wswin, divwin, wcwin
		
FROM total_team_salary LEFT JOIN teams ON teams.teamid = total_team_salary.teamid
WHERE teams.yearid = total_team_salary.yearid
GROUP BY total_team_salary.yearid, total_team_salary.teamid, year_team_salary, teams.w, home_games, wswin, divwin, wcwin
ORDER BY total_team_salary.yearid, total_team_salary.teamid;
