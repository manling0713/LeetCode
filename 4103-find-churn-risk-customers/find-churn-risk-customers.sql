# Write your MySQL query statement below
WITH ranked_event AS(
    SELECT user_id
        , event_date
        , event_type
        , plan_name
        , monthly_amount
        , ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY event_date DESC, event_id DESC) AS rn
        , MAX(monthly_amount) OVER(PARTITION BY user_id) AS max_historical_amount
        , MIN(event_date) OVER(PARTITION BY user_id) AS first_date
    FROM subscription_events
), downgrade_user AS(
    SELECT DISTINCT user_id
    FROM subscription_events
    WHERE event_type = 'downgrade'
)
SELECT user_id
    , plan_name AS current_plan
    , monthly_amount AS current_monthly_amount
    , max_historical_amount
    , DATEDIFF(event_date, first_date) AS days_as_subscriber
FROM ranked_event
WHERE rn = 1
    AND event_type <> 'cancel'
    AND user_id IN (SELECT * FROM downgrade_user)
    AND monthly_amount < 0.5*max_historical_amount
    AND DATEDIFF(event_date, first_date) >= 60
ORDER BY days_as_subscriber DESC, user_id