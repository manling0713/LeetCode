# Write your MySQL query statement below
-- years_of_exp >= 2
-- SUM(score) > 15

SELECT candidate_id
FROM Candidates c
LEFT JOIN Rounds r
ON c.interview_id = r.interview_id
WHERE years_of_exp >= 2
GROUP BY candidate_id
HAVING SUM(score) > 15;