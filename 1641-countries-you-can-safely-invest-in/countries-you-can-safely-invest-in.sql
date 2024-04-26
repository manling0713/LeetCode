# Write your MySQL query statement below
WITH person_c AS(
    SELECT id, c.name AS country
    FROM Person p
    LEFT JOIN Country c
    ON LEFT(phone_number, 3) = country_code 
), all_calls AS(
    SELECT caller_id, country, duration
    FROM Calls c
    LEFT JOIN person_c pc
    ON c.caller_id = pc.id 
    UNION ALL 
    SELECT callee_id, country, duration
    FROM Calls c
    LEFT JOIN person_c pc
    ON c.callee_id = pc.id 
)
SELECT country
FROM all_calls
GROUP BY country
HAVING AVG(duration) > (
    SELECT AVG(duration)
    FROM all_calls
)