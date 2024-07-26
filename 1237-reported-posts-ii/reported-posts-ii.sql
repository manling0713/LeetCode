# Write your MySQL query statement below
WITH report AS(
    SELECT action_date, COUNT(DISTINCT post_id) total_spam
    FROM Actions a
    LEFT JOIN Removals r
    USING(post_id)
    WHERE action = 'report' AND extra = 'spam'
    GROUP BY action_date
), remove AS(
    SELECT action_date, COUNT(DISTINCT post_id) total_remove
    FROM Actions a
    LEFT JOIN Removals r
    USING(post_id)
    WHERE action = 'report' AND extra = 'spam' AND remove_date IS NOT NULL
    GROUP BY action_date
)

SELECT ROUND(AVG(IFNULL(total_remove, 0)/total_spam)*100, 2) AS average_daily_percent 
FROM report
LEFT JOIN remove
USING(action_date)