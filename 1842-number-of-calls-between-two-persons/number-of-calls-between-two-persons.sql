# Write your MySQL query statement below
WITH all_call AS(
    SELECT from_id AS person1
        , to_id AS person2
        , duration
    FROM Calls
    UNION ALL
    SELECT to_id AS person1
        , from_id AS person2
        , duration
    FROM Calls
)
SELECT person1
    , person2
    , COUNT(*) AS call_count
    , SUM(duration) AS total_duration
FROM all_call
WHERE person1 < person2
GROUP BY person1, person2

