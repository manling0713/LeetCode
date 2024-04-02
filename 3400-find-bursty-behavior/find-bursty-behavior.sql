-- create cte for avg weekly posts
WITH AVG_WEEKLY AS (
    SELECT user_id,
           COUNT(*) / 4 AS avg_weekly_posts
    FROM Posts
    WHERE post_date BETWEEN '2024-02-01' AND '2024-02-28'
    GROUP BY user_id
),
-- create cte for agg daily posts
AGG_DAILY AS (
    SELECT user_id,
           post_date,
           COUNT(*) AS daily_posts
    FROM Posts
    WHERE post_date BETWEEN '2024-02-01' AND '2024-02-28'
    GROUP BY user_id, post_date
),
-- create cte to get agg posts in 7 day windows
7DAY_POSTS AS (
    SELECT user_id,
           post_date,
           SUM(daily_posts) OVER(PARTITION BY user_id ORDER BY post_date ASC RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW) AS 7day_posts
    FROM AGG_DAILY
),
-- get max 7day posts of each user
MAX_7DAY_POSTS AS (
    SELECT user_id,
           MAX(7day_posts) AS max_7day_posts
    FROM 7DAY_POSTS
    GROUP BY user_id
)
-- join avg_weekly with max_7day and filter
SELECT M.user_id,
       M.max_7day_posts,
       A.avg_weekly_posts
FROM MAX_7DAY_POSTS M
INNER JOIN AVG_WEEKLY A
ON M.user_id = A.user_id
WHERE M.max_7day_posts >= 2 * A.avg_weekly_posts
ORDER BY M.user_id ASC