# Write your MySQL query statement below

SELECT SUM(CASE WHEN weekday(submit_date) > 4 THEN 1 ELSE 0 END) AS weekend_cnt
    , SUM(CASE WHEN weekday(submit_date) <= 4 THEN 1 ELSE 0 END) AS working_cnt
FROM Tasks
