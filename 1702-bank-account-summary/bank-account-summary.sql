# Write your MySQL query statement below
WITH all_trans AS(
    SELECT user_id, credit
    FROM Users u
    UNION ALL
    SELECT user_id, IFNULL(-amount, 0) AS credit
    FROM Users u
    LEFT JOIN Transactions t1
    ON t1.paid_by = u.user_id
    UNION ALL
    SELECT user_id, IFNULL(amount, 0) AS credit
    FROM Users u
    LEFT JOIN Transactions t2
    ON t2.paid_to = u.user_id
)
SELECT u.user_id
    , user_name
    , SUM(a.credit) AS credit
    , IF(SUM(a.credit) > 0, 'No', 'Yes') AS credit_limit_breached
FROM Users u
LEFT JOIN all_trans a
USING(user_id)
GROUP BY u.user_id

