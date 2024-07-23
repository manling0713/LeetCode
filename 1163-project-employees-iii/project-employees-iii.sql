# Write your MySQL query statement below
SELECT project_id, employee_id
FROM Project p
LEFT JOIN Employee e
USING(employee_id)
WHERE (project_id, experience_years) IN (
    SELECT project_id, MAX(experience_years) AS experience_years
    FROM Project p
    LEFT JOIN Employee e
    USING(employee_id)
    GROUP BY project_id
)