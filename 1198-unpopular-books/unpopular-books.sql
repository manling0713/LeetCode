# Write your MySQL query statement below
SELECT book_id, name
FROM Books b
WHERE available_from < '2019-05-23' AND
    book_id NOT IN(
        SELECT o.book_id
        FROM Books b
        LEFT JOIN Orders o
        USING(book_id)
        WHERE dispatch_date BETWEEN '2018-06-23' AND '2019-06-23'
        GROUP BY o.book_id
        HAVING SUM(quantity) >= 10 
    )
