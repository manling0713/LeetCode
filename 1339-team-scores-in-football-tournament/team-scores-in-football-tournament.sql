# Write your MySQL query statement below
WITH score AS(
    SELECT host_team AS team_id,
        CASE WHEN host_goals > guest_goals THEN 3
        WHEN host_goals = guest_goals THEN 1
        ELSE 0 END AS scores
    FROM Matches
    UNION ALL
    SELECT guest_team AS team_id,
        CASE WHEN host_goals < guest_goals THEN 3
        WHEN host_goals = guest_goals THEN 1
        ELSE 0 END AS scores
    FROM Matches
)
SELECT t.team_id, t.team_name, IFNULL(SUM(scores), 0) AS num_points
FROM Teams t
LEFT JOIN score s
USING(team_id)
GROUP BY t.team_id
ORDER BY num_points DESC, team_id

