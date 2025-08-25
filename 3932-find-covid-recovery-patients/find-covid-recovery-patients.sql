# Write your MySQL query statement below
SELECT c1.patient_id
    , patient_name
    , age
    , DATEDIFF(MIN(c2.test_date), MIN(c1.test_date)) AS recovery_time
FROM covid_tests c1
INNER JOIN covid_tests c2
ON c1.patient_id = c2.patient_id
    AND c1.test_date < c2.test_date
    AND c1.result = 'Positive' AND c2.result = 'Negative'
LEFT JOIN patients p
ON c1.patient_id = p.patient_id
GROUP BY c1.patient_id, patient_name, age
ORDER BY recovery_time, patient_name;

-- SELECT c.patient_id
--     , p.patient_name
--     , p.age
--     , datediff(MIN(c1.test_date) , MIN(c.test_date)) recovery_time
-- FROM covid_tests c 
-- INNER JOIN covid_tests c1 
-- ON c.patient_id = c1.patient_id 
--     AND c.test_date < c1.test_date 
--     AND c.result = 'Positive' AND c1.result = 'Negative'
-- INNER JOIN patients p 
-- ON c.patient_id = p.patient_id
-- GROUP BY c.patient_id, p.patient_name, p.age
-- ORDER BY recovery_time, p.patient_name;