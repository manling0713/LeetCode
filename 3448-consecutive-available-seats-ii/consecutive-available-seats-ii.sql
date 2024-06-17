# Write your MySQL query statement below
WITH free_seats AS(
    SELECT *,
        seat_id - ROW_NUMBER() OVER(ORDER BY seat_id) AS gap
    FROM Cinema
    WHERE free = 1
), free_seats_ranking AS(
    SELECT MIN(seat_id) AS first_seat_id,
        MAX(seat_id) AS last_seat_id,
        COUNT(*) AS consecutive_seats_len,
        RANK() OVER(ORDER BY COUNT(*) DESC) AS rnk
    FROM free_seats
    GROUP BY gap
)

SELECT first_seat_id, last_seat_id , consecutive_seats_len
FROM free_seats_ranking
WHERE rnk = 1
ORDER BY first_seat_id