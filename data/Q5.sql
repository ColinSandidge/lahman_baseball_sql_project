--Q5
/* Find the average number of strikeouts per game by decade since 1920. 
Round the numbers you report to 2 decimal places. Do the same for home runs per game. Do you see any trends? */
WITH yearly_games AS (SELECT 
					   CASE WHEN yearid BETWEEN 1920 AND 1929 THEN '1920s'
	 					    WHEN yearid BETWEEN 1930 AND 1939 THEN '1930s'
					  		WHEN yearid BETWEEN 1940 AND 1949 THEN '1940s'
					  		WHEN yearid BETWEEN 1950 AND 1959 THEN '1950s'
					  		WHEN yearid BETWEEN 1960 AND 1969 THEN '1960s'
					  		WHEN yearid BETWEEN 1970 AND 1979 THEN '1970s'
					  		WHEN yearid BETWEEN 1980 AND 1989 THEN '1980s'
					  		WHEN yearid BETWEEN 1990 AND 1999 THEN '1990s'
					  		WHEN yearid BETWEEN 2000 AND 2009 THEN '2000s'
	 						ELSE '2010s' END as decade,
					  SUM(g) AS total_games, SUM(hr) AS total_homeruns, SUM(so) AS total_strikeouts 
					   FROM batting
					   WHERE yearid >= 1920 
					   GROUP BY decade
					   ORDER BY decade)
SELECT decade, 
		ROUND(total_strikeouts/total_games::decimal, 2) AS avg_so_per_game,
		ROUND(total_homeruns/total_games::decimal, 2) AS avg_hr_per_game
FROM yearly_games;
