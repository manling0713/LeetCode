# Write your MySQL query statement below

WITH all_users AS(
    SELECT user1_id AS user_id
        , user2_id AS friend
    FROM Friendship
    UNION ALL
    SELECT user2_id AS user_id 
        , user1_id AS friend
    FROM Friendship
)

SELECT a1.user_id AS user1_id
    , a2.user_id AS user2_id
    , COUNT(*) AS common_friend
FROM all_users a1
LEFT JOIN all_users a2
ON a1.user_id < a2.user_id
    AND a1.friend = a2.friend
WHERE (a1.user_id, a2.user_id) IN (SELECT * FROM friendship)
GROUP BY user1_id, user2_id
HAVING COUNT(*) >= 3;

