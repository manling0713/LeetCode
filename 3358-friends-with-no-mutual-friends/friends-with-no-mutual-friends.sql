# Write your MySQL query statement below
WITH all_friend AS(
    SELECT user_id1 AS user_id
        , user_id2 AS friend
    FROM Friends
    UNION ALL
    SELECT user_id2 AS user_id
        , user_id1 AS friend
    FROM Friends
), mutual AS(
    SELECT a1.user_id As user_id1
        , a2.user_id AS user_id2
    FROM all_friend a1
    LEFT JOIN all_friend a2
    USING(friend)
)

SELECT *
FROM Friends
WHERE(user_id1, user_id2) NOT IN(
    SELECT user_id1, user_id2
    FROM mutual
)
ORDER BY user_id1, user_id2
