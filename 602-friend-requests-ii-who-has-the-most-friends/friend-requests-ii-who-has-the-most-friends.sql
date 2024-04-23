# Write your MySQL query statement below
WITH friend AS (
    SELECT requester_id AS id
        ,accepter_id AS friend_id
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id
        ,requester_id AS friend_id
    FROM RequestAccepted
)
SELECT id, COUNT(*) AS num
FROM friend
GROUP BY id
ORDER BY num DESC
LIMIT 1
