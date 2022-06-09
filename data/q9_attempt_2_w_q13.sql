--Q9

WITH ntl AS (SELECT p.namefirst as firstn, p.namelast as lastn, a.yearid as yr, a.playerid as pid
		    FROM awardsmanagers as a
		    left join people as p
		    on a.playerid = p.playerid
		    where a.awardid ='TSN Manager of the Year' AND a.lgid = 'NL'
			ORDER BY yr),
			
			alls AS (SELECT p.namefirst as fname, p.namelast as lname, a.yearid as yrr, a.playerid as pid
		   			 FROM awardsmanagers as a
		    		left join people as p
		    		on a.playerid = p.playerid
		    		where a.awardid ='TSN Manager of the Year' AND a.lgid = 'AL'
					ORDER BY yrr),
					
			mg AS    (SELECT teamid AS tm, lgid, yearid, m.playerid
				    	FROM managers as m
						left join people as p on m.playerid = p.playerid
						 ORDER BY yearid)
		 
SELECT  firstn, lastn, yr, alls.yrr, ntl.pid, mg.tm, mgalls.tm 
FROM ntl
INNER JOIN  alls
ON ntl.pid = alls.pid
LEFT join mg on mg.playerid = ntl.pid AND mg.yearid = ntl.yr
LEFT JOIN mg AS mgalls  on mgalls.playerid = alls.pid AND mgalls.yearid = alls.yrr
ORDER BY yr; 


/*SELECT teamid
FROM managershalf
WHERE yearid= 1998 AND playerid ='leylaji99'*/

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
