# Write your MySQL query statement below
SELECT s.sub_id AS post_id,
(SELECT COUNT(DISTINCT(s1.sub_id)) FROM Submissions s1 WHERE s1.parent_id = s.sub_id) 
AS number_of_comments
FROM Submissions s
WHERE s.parent_id IS null
GROUP BY s.sub_id
ORDER BY post_id
;