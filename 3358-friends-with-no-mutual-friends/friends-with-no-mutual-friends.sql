-- Create a table with all friend pairs
WITH all_pairs AS(
    SELECT user_id1 AS user_id
        ,user_id2 AS friend_id
    FROM Friends
    UNION ALL
    SELECT user_id2 AS user_id
        ,user_id1 AS friend_id
    FROM Friends
),
shared_friend_pairs AS(
    SELECT a1.user_id AS user_id1
        , a2.user_id AS user_id2
    FROM all_pairs a1
    LEFT JOIN all_pairs a2
    USING(friend_id)
)
SELECT user_id1, user_id2
FROM Friends
WHERE (user_id1, user_id2) NOT IN (
    SELECT user_id1, user_id2
    FROM shared_friend_pairs
)
ORDER BY user_id1, user_id2