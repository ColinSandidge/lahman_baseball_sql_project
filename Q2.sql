/* Find the name and height of the shortest player in the database. 
How many games did he play in? What is the name of the team for which he played? 
*/

SELECT p.namegiven,
	   MIN(p.height),
	   a.g_all,
	   tf.franchname
FROM people AS p
INNER JOIN appearances AS a
ON p.playerid = a.playerid
INNER JOIN teams AS t
ON a.teamid = t.teamid
INNER JOIN teamsfranchises AS tf
ON t.franchid = tf.franchid
GROUP BY p.namegiven, a.g_all,tf.franchname
ORDER BY MIN(p.height);