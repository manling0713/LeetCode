# Write your MySQL query statement below
WITH id_country AS(
    SELECT id, p.name, c.name AS country 
    From Person p 
    LEFT JOIN Country c
    ON LEFT(phone_number, 3) = country_code
), all_call AS(
    SELECT caller_id AS id, country, duration
    FROM Calls c
    LEFT JOIN id_country i
    ON c.caller_id = i.id
    UNION ALL
    SELECT callee_id AS id, country, duration
    FROM Calls c
    LEFT JOIN id_country i
    ON c.callee_id = i.id
)

SELECT country
FROM all_call
GROUP BY country
HAVING AVG(duration) > (
    SELECT AVG(duration)
    FROM all_call
)







