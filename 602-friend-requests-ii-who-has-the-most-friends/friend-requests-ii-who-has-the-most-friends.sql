# Write your MySQL query statement below
WITH id_friend AS(
    SELECT requester_id AS id
        , accepter_id AS friend_id
    FROM RequestAccepted
    UNION
    SELECT accepter_id AS id
        , requester_id AS friend_id
    FROM RequestAccepted
)
SELECT id
    , COUNT(DISTINCT friend_id) AS num
FROM id_friend
GROUP BY id
ORDER BY num DESC
LIMIT 1;
