# Write your MySQL query statement below
WITH all_friend AS(
    SELECT requester_id AS id, accepter_id AS friend
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id, requester_id AS friend
    FROM RequestAccepted
)
SELECT id, COUNT(friend) AS num
FROM all_friend
GROUP BY id
ORDER BY num DESC
LIMIT 1
