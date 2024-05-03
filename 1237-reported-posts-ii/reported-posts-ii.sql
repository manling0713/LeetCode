# Write your MySQL query statement below
SELECT ROUND(AVG(cnt), 2) AS average_daily_percent
FROM(
    SELECT (COUNT(DISTINCT r.post_id))/COUNT(DISTINCT a.post_id) * 100 AS cnt
    FROM Actions a 
    LEFT JOIN Removals r
    USING(post_id)
    WHERE extra = 'spam'
    GROUP BY action_date
) AS cnt

