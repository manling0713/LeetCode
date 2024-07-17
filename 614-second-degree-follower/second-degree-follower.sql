# Write your MySQL query statement below
SELECT followee AS follower
    , COUNT(*) AS num
FROM Follow
WHERE followee IN (
    SELECT DISTINCT follower AS followee
    FROM Follow
)
GROUP BY followee
ORDER BY follower
