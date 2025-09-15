# Write your MySQL query statement below
WITH user_visit AS(
    SELECT user_id
        , visit_date
        , IF(LEAD(visit_date, 1) OVER(PARTITION BY user_id ORDER BY visit_date) IS NOT NULL, LEAD(visit_date, 1) OVER(PARTITION BY user_id ORDER BY visit_date), '2021-1-1') AS next_visit
    FROM UserVisits
), user_window AS(
    SELECT user_id
        , DATEDIFF(next_visit, visit_date) AS visit_window
    FROM user_visit
)
SELECT user_id
    , MAX(visit_window) AS biggest_window
FROM user_window
GROUP BY user_id
ORDER BY user_id

