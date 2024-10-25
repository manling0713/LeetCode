# Write your MySQL query statement below
-- # of likes/# of votes < 0.6

SELECT problem_id
FROM Problems
WHERE likes/(likes + dislikes) < 0.6
ORDER BY problem_id;