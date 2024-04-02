# Write your MySQL query statement below
# Write your MySQL query statement below


WITH A AS(
    SELECT * FROM Posts WHERE '2024-02-01' <= post_date AND post_date <= '2024-02-28'
),
B AS(
    SELECT user_id, COUNT(*)/4 AS avg_weekly_posts  FROM A GROUP BY 1
),
C AS(
    SELECT user_id, post_date, COUNT(*) OVER(PARTITION BY user_id ORDER BY post_date RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW ) AS cnt7 FROM A
),
D AS(
    SELECT user_id, MAX(cnt7) AS max_7day_posts FROM C GROUP BY 1
),
E AS(
    SELECT * FROM D INNER JOIN B USING(user_id) HAVING(avg_weekly_posts *2 <= max_7day_posts ) ORDER BY user_id
)
SELECT * FROM E
