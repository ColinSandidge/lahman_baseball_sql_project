--Q9

WITH an AS (SELECT p.namefirst as fa, p.namelast as la, a.yearid as ya, a.playerid as pid
		    FROM awardsmanagers as a
		    left join people as p
		    on a.playerid = p.playerid
		    where a.awardid ='TSN Manager of the Year' AND a.lgid = 'NL'),
			
			al AS (SELECT p.namefirst as faa, p.namelast as laa, a.yearid as yaa
		   			 FROM awardsmanagers as a
		    		left join people as p
		    		on a.playerid = p.playerid
		    		where a.awardid ='TSN Manager of the Year' AND a.lgid = 'AL'),
					
			mg AS    (SELECT teamid, lgid, yearid, m.playerid
				    	FROM managershalf as m
						left join people as p on m.playerid = p.playerid )
		 
SELECT fa,la, ya, mg.teamid
FROM an
INNER JOIN  al
ON an.fa = al.faa
left join mg on mg.playerid = an.pid
ORDER BY ya;

--Q 13

WITH numleft	AS (SELECT p.playerid AS a, ppl.throws AS lh, p.yearid AS cc
					FROM pitching as p
					LEFT join people AS ppl on ppl.playerid = p.playerid
					WHERE  throws = 'L'),
					
				numright AS	(SELECT p.playerid AS a, ppl.throws AS rh, p.yearid AS cc
								FROM pitching as p
								LEFT join people AS ppl on ppl.playerid = p.playerid
								WHERE  throws = 'R')
					
SELECT COUNT(numleft.lh) as countlh, COUNT(numright.rh) AS countrh, numleft.cc 
FROM numleft
FULL JOIN numright ON numleft.cc = numright.cc
GROUP BY numleft.cc

--


