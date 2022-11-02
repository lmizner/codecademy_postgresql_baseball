-- For each of these awards, write a query to find the award winner. 

-- Heaviest Hitters
-- This award goes to the team with the highest average weight of its batters on a given year.

SELECT
	AVG(people.weight),
    teams.name,
    batting.yearid
FROM people
INNER JOIN batting
	ON people.playerid = batting.playerid
INNER JOIN teams
	ON batting.team_id = teams.id
GROUP BY
	teams.name,
    batting.yearid
ORDER BY
	AVG(people.weight)
    DESC;


-- Shortest Sluggers
-- This award goes to the team with the smallest average height of its batters on a given year. 
-- This query should look very similar to the one you wrote to find the heaviest teams.

SELECT 
    AVG(people.height),
    teams.name,
    batting.yearid
FROM people
INNER JOIN batting 
    ON people.playerid = batting.playerid
INNER JOIN teams
    ON batting.team_id = teams.id
GROUP BY
    teams.name,
    batting.yearid
ORDER BY
    AVG(people.height)
    ASC;


-- Biggest Spenders
-- This award goes to the team with the largest total salary of all players in a given year.

SELECT
    SUM(salaries.salary),
    teams.name,
    salaries.yearid
FROM salaries
LEFT JOIN teams
    ON salaries.teamid = teams.teamid
    AND salaries.yearid = teams.yearid
GROUP BY 
    teams.name,
    salaries.yearid
ORDER BY
    SUM(salaries.salary)
    DESC;


-- Most Bang For Their Buck In 2010
-- This award goes to the team that had the smallest “cost per win” in 2010. Cost per win is 
-- determined by the total salary of the team divided by the number of wins in a given year. 
-- Note that we decided to look at just teams in 2010 because when we found this award looking 
-- across all years, we found that due to inflation, teams from the 1900s spent much less money 
-- per win. We thought that looking at all teams in just the year 2010 gave a more interesting 
-- statistic.

SELECT
    ROUND(SUM(salary)/teams.w),
    teams.w,
    teams.name,
    salaries.yearid
FROM salaries
LEFT JOIN teams
    ON salaries.teamid = teams.teamid
    AND salaries.yearid = teams.yearid
WHERE teams.yearid = 2010
GROUP BY
    teams.name,
    teams.w,
    salaries.yearid
ORDER BY
    ROUND(SUM(salary)/teams.w)
    ASC;


-- Priciest Starter
-- This award goes to the pitcher who, in a given year, cost the most money per game in which they 
-- were the starting pitcher. Note that many pitchers only started a single game, so to be eligible 
-- for this award, you had to start at least 10 games.

SELECT
    people.namegiven,
    ROUND(salaries.salary / pitching.g) as cost_per_game,
    salaries.yearid,
    pitching.g
FROM salaries
INNER JOIN pitching
    ON salaries.yearid = pitching.yearid
    AND salaries.playerid = pitching.playerid
    AND salaries.teamid = pitching.teamid
INNER JOIN people
    ON salaries.playerid = people.playerid
WHERE pitching.g >= 10
ORDER BY
    ROUND(salaries.salary / pitching.g)
    DESC;





