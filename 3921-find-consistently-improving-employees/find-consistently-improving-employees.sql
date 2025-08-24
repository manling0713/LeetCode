# Write your MySQL query statement below
-- ROW_NUMBER() OVER(PARTITION BY employee_id ORDER BY review_date DESC)
-- rnk = 1
-- ON rating_1 > rating_2
-- rating_1 - rating_3 AS improvement_score
WITH employee_rank AS(
    SELECT employee_id
        , rating
        , ROW_NUMBER() OVER(PARTITION BY employee_id ORDER BY review_date DESC) AS rnk
    FROM performance_reviews 
), employee_rating_1 AS (
    SELECT employee_id
        , rating AS rating_1
    FROM employee_rank
    WHERE rnk = 1
), employee_rating_2 AS (
    SELECT employee_id
        , rating AS rating_2
    FROM employee_rank
    WHERE rnk = 2
), employee_rating_3 AS (
    SELECT employee_id
        , rating AS rating_3
    FROM employee_rank
    WHERE rnk = 3
)

SELECT r1.employee_id
    , name
    , rating_1 - rating_3 AS improvement_score
FROM employee_rating_1 r1
INNER JOIN employee_rating_2 r2
ON r1.employee_id = r2.employee_id AND rating_1 > rating_2
INNER JOIN employee_rating_3 r3
ON r2.employee_id = r3.employee_id AND rating_2 > rating_3
LEFT JOIN employees e
ON e.employee_id = r1.employee_id
ORDER BY improvement_score DESC, name;
