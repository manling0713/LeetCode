# Write your MySQL query statement below
WITH goal AS(
    SELECT home_team_id AS team_id, home_team_goals AS goals_for, away_team_goals AS against
        , CASE WHEN home_team_goals > away_team_goals THEN 3
            WHEN home_team_goals = away_team_goals THEN 1
            ELSE 0 END AS points
    FROM Matches 
    UNION ALL
    SELECT away_team_id AS team_id, away_team_goals AS goals_for, home_team_goals AS against
            , CASE WHEN home_team_goals < away_team_goals THEN 3
            WHEN home_team_goals = away_team_goals THEN 1
            ELSE 0 END AS points
    FROM Matches 
)
SELECT team_name
    , COUNT(*) AS matches_played
    , SUM(points) AS points
    , SUM(goals_for) AS goal_for
    , SUM(against) AS goal_against
    , SUM(goals_for) - SUM(against) AS goal_diff
FROM goal g
LEFT JOIN Teams t USING(team_id)
GROUP BY team_name
ORDER BY points DESC, points, goal_diff DESC, team_name
