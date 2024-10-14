# Write your MySQL query statement below
WITH all_matches AS(
    SELECT home_team_id
        , home_team_goals AS home
        , away_team_goals AS away 
    FROM matches
    UNION ALL
    SELECT away_team_id AS home_team_id
        , away_team_goals AS home
        , home_team_goals AS away 
    FROM matches
)

SELECT team_name
    , COUNT(*) AS matches_played
    , SUM(CASE WHEN home > away THEN 3
            WHEN home = away THEN 1 ELSE 0 END) AS points
    , SUM(home) AS goal_for
    , SUM(away) AS goal_against
    , SUM(home) - SUM(away) AS goal_diff
FROM all_matches a
LEFT JOIN teams t
ON a.home_team_id = t.team_id
GROUP BY team_name
ORDER BY points DESC, goal_diff DESC, team_name