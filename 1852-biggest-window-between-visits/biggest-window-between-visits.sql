# Write your MySQL query statement below
WITH user_diff AS(
    SELECT user_id
        , DATEDIFF(LEAD(visit_date, 1, '2021-1-1') OVER(PARTITION BY user_id ORDER BY visit_date), visit_date) AS diff
    FROM UserVisits
)
SELECT user_id, MAX(diff) AS biggest_window
FROM user_diff
GROUP BY user_id
ORDER BY user_id