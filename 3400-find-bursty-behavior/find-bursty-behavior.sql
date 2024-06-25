# Write your MySQL query statement below
WITH avg_post AS(
    SELECT user_id
        , COUNT(post_id) OVER(PARTITION BY user_id)/4 AS avg_weekly_posts
        , COUNT(post_id) OVER(PARTITION BY user_id ORDER BY post_date RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW) AS weekly_post
    FROM  Posts
    WHERE post_date BETWEEN '2024-02-01' AND '2024-02-28'
), max_post AS(
    SELECT user_id
        , MAX(weekly_post) OVER(PARTITIOn BY user_id) AS max_7day_posts
        , avg_weekly_posts
    FROM avg_post
)
SELECT DISTINCT *
FROM max_post
WHERE  avg_weekly_posts*2 <= max_7day_posts
ORDER BY user_id 

