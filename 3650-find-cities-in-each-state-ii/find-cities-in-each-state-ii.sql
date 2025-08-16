# Write your MySQL query statement below
-- GROUP BY state COUNT(city)
-- HAVING COUNT(city) >= 3
-- LEFT(state, 1) = LEFT(city, 1)
-- WHERE (state, city) = match state, city name
-- CONCAT(city, ",")
WITH state_3_cities AS (
    SELECT DISTINCT state
    FROM cities
    GROUP BY state
    HAVING COUNT(city) >= 3
), state_same_name AS (
    SELECT DISTINCT state AS matching_letter_state
        , COUNT(city) AS matching_letter_count
    FROM cities
    WHERE LEFT(state, 1) = LEFT(city, 1)
    GROUP BY state
)

SELECT state
    , GROUP_CONCAT(city ORDER BY city SEPARATOR ', ') AS cities
    , matching_letter_count
FROM cities c
INNER JOIN state_same_name s
ON c.state = s.matching_letter_state
WHERE state IN (SELECT state FROM state_3_cities)
GROUP BY state
ORDER BY matching_letter_count DESC, state;
