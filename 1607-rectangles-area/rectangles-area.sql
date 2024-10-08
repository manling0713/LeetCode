# Write your MySQL query statement below
SELECT p1.id AS P1, p2.id AS P2
    , ABS(p1.x_value - p2.x_value) * ABS(p1.y_value - p2.y_value) AS area
FROM Points p1, Points p2
WHERE p1.id < p2.id AND p1.x_value <> p2.x_value AND p1.y_value <> p2.y_value
ORDER BY area DESC, p1, p2