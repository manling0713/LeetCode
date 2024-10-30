# Write your MySQL query statement below
WITH first_tab AS(
    SELECT first_col
        , ROW_NUMBER() OVER(ORDER BY first_col) num
    FROM Data
    ORDER BY num
), second_tab AS(
    SELECT second_col
        , ROW_NUMBER() OVER(ORDER BY second_col DESC) num
    FROM Data
    ORDER BY num
)

SELECT first_col
    ,second_col
FROM first_tab f
LEFT JOIN second_tab s
ON f.num = s.num