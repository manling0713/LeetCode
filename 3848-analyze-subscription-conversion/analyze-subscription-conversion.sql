# Write your MySQL query statement below
WITH free_users AS(
    SELECT user_id
        , ROUND(AVG(activity_duration), 2) AS trial_avg_duration
    FROM UserActivity
    WHERE activity_type = 'free_trial'
    GROUP BY user_id
), paid_users AS(
    SELECT user_id
        , ROUND(AVG(activity_duration), 2) AS paid_avg_duration
    FROM UserActivity
    WHERE activity_type = 'paid'
    GROUP BY user_id
)

SELECT f.user_id
    , trial_avg_duration
    , paid_avg_duration
FROM free_users f
INNER JOIN paid_users p
ON f.user_id = p.user_id
ORDER BY f.user_id;