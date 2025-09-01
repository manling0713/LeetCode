# Write your MySQL query statement below
WITH new_seat AS(
    SELECT CASE WHEN MOD(id, 2) = 1 AND id IN (SELECT MAX(id) FROM Seat) THEN id
            WHEN MOD(id, 2) = 1 THEN id + 1
            ELSE id - 1 END AS new_id
        , student
    FROM Seat
)


SELECT new_id AS id
    , student
FROM new_seat
ORDER BY id;
