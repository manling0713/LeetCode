# Write your MySQL query statement below

WITH overlap_shift AS(
    SELECT e1.employee_id
        , e1.start_time
        , e1.end_time
        , e2.start_time AS next_shift
    FROM EmployeeShifts e1
    INNER JOIN EmployeeShifts e2
    ON e1.employee_id = e2.employee_id
        AND e2.start_time <> e1.start_time
        AND e2.start_time BETWEEN e1.start_time AND e1.end_time
)

SELECT employee_id
    , COUNT(*) AS overlapping_shifts
FROM overlap_shift
GROUP BY employee_id
ORDER BY 1;

