# Write your MySQL query statement below
WITH users_contest as (
    SELECT gold_medal as user
        , contest_id 
    FROM contests 
    UNION ALL 
    SELECT silver_medal as user
        , contest_id 
    FROM contests 
    UNION ALL 
    SELECT bronze_medal as user
        , contest_id 
    FROM contests 
)
, number AS (
    SELECT user
        , contest_id
        , row_number() OVER(PARTITION BY user ORDER BY contest_id) AS rn 
    FROM users_contest
)
, candidates AS (
    SELECT user AS user_id -- consecutive medal winners
    FROM number 
    GROUP BY user, contest_id - rn 
    HAVING COUNT(*) >= 3 -- replace 3 with any number to solve the N problem
    UNION ALL
    SELECT gold_medal AS user_id  -- gold medal winners
    FROM contests 
    GROUP BY gold_medal 
    HAVING COUNT(*) >= 3
)
SELECT DISTINCT u.name, u.mail 
from candidates c
LEFT JOIN users u
ON c.user_id = u.user_id