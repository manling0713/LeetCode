-- # Write your MySQL query statement below
WITH team_rank AS (
    SELECT team_name
        , wins * 3 + draws * 1 AS points
        , RANK() OVER(ORDER BY wins * 3 + draws * 1 DESC) AS position
        , COUNT(*) OVER() AS team_num
    FROM TeamStats
)
SELECT team_name
    , points
    , position
    , CASE WHEN position <= CEIL(team_num/3) THEN 'Tier 1'
        WHEN position <= CEIL(2*team_num/3) THEN 'Tier 2'
        ELSE 'Tier 3' END AS tier
FROM team_rank
ORDER BY points DESC, team_name
