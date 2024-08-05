# Write your MySQL query statement below
WITH all_friend AS(
    SELECT user1_id AS user, user2_id AS friend
    FROM Friendship f1
    UNION ALL
    SELECT user2_id AS user, user1_id AS friend
    FROM Friendship f2
), friend_like AS(
    SELECT DISTINCT page_id
    FROM all_friend
    LEFT JOIN Likes
    ON friend = user_id
    WHERE user = 1
)

SELECT DISTINCT page_id AS recommended_page
FROM Likes
WHERE page_id IN(
    SELECT DISTINCT page_id
    FROM all_friend
    LEFT JOIN Likes
    ON friend = user_id
    WHERE user = 1
) AND page_id NOT IN(
    SELECT DISTINCT page_id
    FROM Likes
    WHERE user_id = 1
)

