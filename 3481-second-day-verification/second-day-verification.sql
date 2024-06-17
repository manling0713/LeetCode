# Write your MySQL query statement below
SELECT DISTINCT user_id
FROM emails e
LEFT JOIN texts t
USING(email_id)
WHERE signup_action = 'Verified'
    AND DATEDIFF(action_date, signup_date) = 1
ORDER BY user_id