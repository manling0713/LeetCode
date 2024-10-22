# Write your MySQL query statement below
-- caculate the max number of followers
WITH user_follower AS(
    SELECT r1.user_id AS user1_id
        , r2.user_id AS user2_id
        , COUNT(DISTINCT r1.follower_id) AS common
    FROM Relations r1
    INNER JOIN Relations r2
    ON r1.user_id < r2.user_id
        AND r1.follower_id = r2.follower_id
    GROUP BY r1.user_id, r2.user_id
)


SELECT user1_id
    , user2_id
FROM user_follower
WHERE common IN (SELECT MAX(common) from user_follower)
    

