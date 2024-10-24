# Write your MySQL query statement below
SELECT school_id
    , IFNULL(MIN(score),-1) as score
FROM Schools 
LEFT JOIN Exam
ON capacity >= student_count
GROUP BY school_id
