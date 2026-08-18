# Write your MySQL query statement below
-- WITH current_plan AS(
--     SELECT *
--     FROM subscription_events 
--     WHERE (user_id, event_date) IN (SELECT user_id, MAX(event_date) FROM subscription_events GROUP BY user_id)
--         AND plan_name IS NOT NULL
-- ), active_users AS(
--     SELECT DISTINCT user_id AS active_id
--     FROM subscription_events
--     WHERE (user_id, event_date) IN (SELECT user_id, event_date FROM current_plan)
--         AND event_type <> 'cancel'
-- ), downgrade_users AS(
--     SELECT DISTINCT user_id AS downgrade_id
--     FROM subscription_events
--     WHERE event_type = 'downgrade'
-- ), user_max AS(
--     SELECT user_id
--         , MAX(monthly_amount) AS max_rev
--     FROM subscription_events
--     GROUP BY user_id
-- ), days_users AS(
--     SELECT user_id
--         , DATEDIFF(MAX(event_date), MIN(event_date)) AS days_as_subscriber
--     FROM subscription_events
--     GROUP BY user_id
--     HAVING days_as_subscriber >= 60
-- )

-- SELECT c.user_id
--     , c.plan_name AS current_plan
--     , c.monthly_amount AS current_monthly_amount
--     , u.max_rev AS max_historical_amount
--     , days_as_subscriber
-- FROM current_plan c
-- INNER JOIN user_max u
-- ON c.user_id = u.user_id
--     AND c.monthly_amount < u.max_rev * 0.5
-- INNER JOIN days_users d
-- ON c.user_id = d.user_id
-- WHERE c.user_id IN (SELECT * FROM active_users)
--     AND c.user_id IN (SELECT * FROM downgrade_users)
-- ORDER BY days_as_subscriber DESC, c.user_id

WITH ranked_events AS (
    SELECT 
        user_id,
        event_date,
        event_type,
        plan_name,
        monthly_amount,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY event_date DESC, event_id DESC) AS rn,
        MAX(monthly_amount) OVER (PARTITION BY user_id) AS max_historical_amount,
        MIN(event_date) OVER (PARTITION BY user_id) AS first_date,
        MAX(event_date) OVER () AS max_system_date -- 全系統最新日期作為當前基準點
    FROM subscription_events
),
downgrade_users AS (
    SELECT DISTINCT user_id
    FROM subscription_events
    WHERE event_type = 'downgrade'
)
SELECT 
    r.user_id,
    r.plan_name AS current_plan,
    r.monthly_amount AS current_monthly_amount,
    r.max_historical_amount,
    DATEDIFF(r.event_date, r.first_date) AS days_as_subscriber
FROM ranked_events r
JOIN downgrade_users d ON r.user_id = d.user_id
WHERE r.rn = 1                             -- 鎖定最後一筆事件
  AND r.event_type <> 'cancel'             -- 條件 1：目前非取消狀態
  AND r.monthly_amount < r.max_historical_amount * 0.5 -- 條件 3：低於最高金額 50%
  AND DATEDIFF(r.event_date, r.first_date) >= 60      -- 條件 4：訂閱滿 60 天以上
ORDER BY 
    days_as_subscriber DESC,
    r.user_id ASC;