# Write your MySQL query statement below
SELECT first_name
    , type
    , DATE_FORMAT(SEC_TO_TIME(duration), '%H:%i:%s') AS duration_formatted
FROM(
    SELECT *
        , ROW_NUMBER() OVER(PARTITION BY type ORDER BY duration DESC) AS num
    FROM Calls ca
    LEFT JOIN Contacts co
    ON ca.contact_id = co.id
) comb
WHERE num <= 3
ORDER BY type, duration DESC

