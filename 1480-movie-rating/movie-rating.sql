# Write your MySQL query statement below
WITH most_user AS(
    SELECT name AS results
    FROM MovieRating mr
    LEFT JOIN Users u
    USING(user_id)
    GROUP BY mr.user_id
    ORDER BY COUNT(DISTINCT movie_id) DESC, name
    LIMIT 1
), high_movie AS(
    SELECT title AS results
    FROM MovieRating mr
    LEFT JOIN Movies m
    USING(movie_id)
    WHERE created_at BETWEEN '2020-02-01' AND '2020-02-29'
    GROUP BY title
    ORDER BY AVG(rating) DESC, title
    LIMIT 1
)

SELECT *
FROM most_user
UNION ALL
SELECT *
FROM high_movie