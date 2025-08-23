# Write your MySQL query statement below
WITH borrowed AS(
    SELECT book_id
        , COUNT(record_id) AS current_borrowers
    FROM borrowing_records
    WHERE return_date IS NULL
    GROUP BY book_id
)

SELECT l.book_id
    , title
    , author
    , genre
    , publication_year
    , current_borrowers
FROM library_books l
LEFT JOIN borrowed b
ON l.book_id = b.book_id
WHERE total_copies = current_borrowers
ORDER BY current_borrowers DESC, title;
