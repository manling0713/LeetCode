# Write your MySQL query statement below
WITH all_champ AS(
    SELECT home_team_id
        , home_team_goals
        , away_team_goals
    FROM Matches
    UNION ALL
    SELECT away_team_id AS home_team_id
        , away_team_goals AS home_team_goals
        , home_team_goals AS away_team_goals
    FROM Matches
)
SELECT team_name
    , COUNT(*) AS matches_played
    , SUM(CASE WHEN home_team_goals > away_team_goals THEN 3
        WHEN home_team_goals = away_team_goals THEN 1
        ELSE 0 END) AS points
    , SUM(home_team_goals) AS goal_for
    , SUM(away_team_goals) AS goal_against
    , SUM(home_team_goals) - SUM(away_team_goals) AS goal_diff
FROM all_champ a
LEFT JOIN teams t
ON a.home_team_id = t.team_id
GROUP BY team_name
ORDER BY points DESC, goal_diff DESC, team_name