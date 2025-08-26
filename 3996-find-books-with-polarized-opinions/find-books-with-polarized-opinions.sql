# Write your MySQL query statement below

SELECT DISTINCT r.book_id
    , title
    , author
    , genre
    , pages
    , MAX(session_rating) - MIN(session_rating) AS rating_spread
    , ROUND(SUM(IF(session_rating <= 2 OR session_rating >= 4, 1, 0))/COUNT(*), 2) AS polarization_score
FROM reading_sessions r
LEFT JOIN books b
ON r.book_id = b.book_id
GROUP BY r.book_id
HAVING COUNT(*) >= 5 
    AND SUM(IF(session_rating <= 2, 1, 0)) > 0
    AND SUM(IF(session_rating >= 4, 1, 0)) > 0
    AND SUM(IF(session_rating <= 2 OR session_rating >= 4, 1, 0))/COUNT(*) >= 0.6
ORDER BY polarization_score DESC, title DESC;