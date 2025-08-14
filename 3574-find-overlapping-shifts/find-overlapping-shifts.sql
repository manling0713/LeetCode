# Write your MySQL query statement below

-- WITH all_shifts AS(
--     SELECT employee_id
--         , start_time
--         , end_time
--         , LEAD(start_time, 1) OVER(PARTITION BY employee_id ORDER BY start_time) AS next_shift_start
--     FROM EmployeeShifts
-- ), overlap_shifts AS(
--     SELECT *
--     FROM all_shifts
--     WHERE next_shift_start BETWEEN start_time AND end_time
-- )

-- SELECT employee_id
--     , COUNT(*) AS overlapping_shifts
-- FROM overlap_shifts
-- GROUP BY employee_id
-- ORDER BY employee_id;

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

