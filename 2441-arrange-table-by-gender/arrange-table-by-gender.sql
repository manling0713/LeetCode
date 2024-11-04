# Write your MySQL query statement below

SELECT user_id
    , gender
FROM(
    SELECT user_id
        , gender
        , CASE WHEN gender = 'female' THEN 1
            WHEN gender = 'other' THEN 2
            ELSE 3 END AS num1
        , ROW_NUMBER() OVER (PARTITION BY gender ORDER BY user_id) num2
    FROM Genders
    ORDER BY num2, num1
) AS sub
