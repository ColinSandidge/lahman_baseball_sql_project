--Q9

WITH ntl AS (SELECT p.namefirst as fn, p.namelast as ln, a.yearid as yr, a.playerid as pid
		    FROM awardsmanagers as a
		    left join people as p
		    on a.playerid = p.playerid
		    where a.awardid ='TSN Manager of the Year' AND a.lgid = 'NL'),
			
			alls AS (SELECT p.namefirst as faa, p.namelast as laa, a.yearid as yrr, a.playerid as players
		   			 FROM awardsmanagers as a
		    		left join people as p
		    		on a.playerid = p.playerid
		    		where a.awardid ='TSN Manager of the Year' AND a.lgid = 'AL'),
					
			mg AS    (SELECT teamid, lgid, yearid, m.playerid
				    	FROM managershalf as m
						left join people as p on m.playerid = p.playerid )
		 
SELECT  fn, ln, yr, alls.yrr, mg.teamid
FROM ntl
INNER JOIN  alls
ON ntl.pid = alls.players
LEFT join mg on mg.playerid = ntl.pid
ORDER BY yr;

--Q 13

WITH numleft	AS (SELECT p.playerid AS a, ppl.throws AS lh, p.yearid AS cc
					FROM pitching as p
					LEFT join people AS ppl on ppl.playerid = p.playerid
					WHERE  throws = 'L'),
					
				numright AS	(SELECT p.playerid AS a, ppl.throws AS rh, p.yearid AS cc
								FROM pitching as p
								LEFT join people AS ppl on ppl.playerid = p.playerid
								WHERE  throws = 'R')
					
SELECT COUNT(numleft.lh) as countlh, COUNT(numright.rh) AS countrh
FROM numleft
FULL JOIN numright ON numleft.cc = numright.cc
GROUP BY numleft.cc;

--

-- COUNT LH 12500
SELECT COUNT(ppl.throws) AS lh
FROM pitching as p
LEFT join people AS ppl on ppl.playerid = p.playerid
WHERE  throws = 'L'
GROUP BY ppl.throws

-- COUNT RH 32124
SELECT COUNT(ppl.throws) AS lh
					FROM pitching as p
					LEFT join people AS ppl on ppl.playerid = p.playerid
					WHERE  throws = 'R'
					GROUP BY ppl.throws
