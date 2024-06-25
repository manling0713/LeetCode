# Write your MySQL query statement below
SELECT firstName
    , lastName
    , IFNULL(city, Null) AS city
    , IFNULL(state, Null) AS state
FROM Person
LEFT JOIN Address
USING(personID)