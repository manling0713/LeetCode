# Write your MySQL query statement below
SELECT name
FROM Vote v
LEFT JOIN Candidate c
ON v.candidateId = c.id
GROUP BY candidateId
ORDER BY COUNT(*) DESC
LIMIT 1