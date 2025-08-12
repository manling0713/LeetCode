-- # Write your MySQL query statement below
-- WITH team_rnk AS (
--     SELECT team_name
--         , wins * 3 + draws * 1 AS points
--         , RANK() OVER(ORDER BY wins * 3 + draws * 1 DESC) AS position
--     FROM TeamStats
-- )

-- SELECT team_name
--     , points
--     , position
--     , CASE WHEN ROUND(PERCENT_RANK() OVER(ORDER BY position), 2) <= 0.33 THEN 'Tier 1'
--     WHEN ROUND(PERCENT_RANK() OVER(ORDER BY position), 2) > 0.67 THEN 'Tier 3'
--     ELSE 'Tier 2' END tier
-- FROM team_rnk
-- ORDER BY points DESC, team_name

# Write your MySQL query statement below
with cte as(select team_id,team_name,
wins*3+draws*1 as points from TeamStats),

 cte2 as(select *,
rank() over(order by points desc) as position,
count(*) over() as total_teams
from cte)

select team_name,points,position,
case when position<=ceil(total_teams/3.0) then 'Tier 1'
when position<=ceil(2*total_teams/3.0) then 'Tier 2'
else 'Tier 3'
end as tier
from cte2
order by points desc,team_name