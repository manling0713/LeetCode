# Write your MySQL query statement below
WITH tax AS(
    SELECT company_id
        , CASE WHEN MAX(salary) < 1000 THEN 1
            WHEN MAX(salary) > 10000 THEN 0.51
            ELSE 0.76 END AS after_tax
    FROM Salaries
    GROUP BY company_id
)
SELECT company_id
    , employee_id
    , employee_name
    , ROUND(salary * after_tax, 0) AS salary
FROM Salaries
LEFT JOIN tax
USING(company_id)
