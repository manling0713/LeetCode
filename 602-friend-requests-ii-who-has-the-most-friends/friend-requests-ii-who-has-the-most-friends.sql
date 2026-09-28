# Write your MySQL query statement below
WITH all_friends AS(
    SELECT requester_id AS id
        , accepter_id AS friend_id
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id
        , requester_id AS friend_id
    FROM RequestAccepted
)
SELECT id
    , COUNT(friend_id) AS num
FROM all_friends
GROUP BY id
ORDER BY num DESC
LIMIT 1;
