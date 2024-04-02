WITH avg_weekly AS(
    SELECT user_id
        , COUNT(*)/4 AS avg_weekly_posts
    FROM Posts
    WHERE post_date BETWEEN '2024-02-01' AND '2024-02-28'
    GROUP BY user_id
), agg_daily AS(
    SELECT user_id
        , post_date
        , COUNT(*) AS daily_posts
    FROM Posts
    WHERE post_date BETWEEN '2024-02-01' AND '2024-02-28'
    GROUP BY user_id, post_date
), 7day_posts AS (
    SELECT user_id
        , post_date
        , SUM(daily_posts) OVER(PARTITION BY user_id ORDER BY post_date RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW) AS 7day_posts
        FROM agg_daily
), max_7day_posts AS(
    SELECT user_id
        , MAX(7day_posts) AS max_7day_posts
    FROM 7day_posts
    GROUP BY user_id
)

SELECT m.user_id
    , max_7day_posts
    , avg_weekly_posts
FROM max_7day_posts m
INNER JOIN avg_weekly a 
USING(user_id)
WHERE m.max_7day_posts >= 2*a.avg_weekly_posts
ORDER BY m.user_id