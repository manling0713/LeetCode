# Write your MySQL query statement below
WITH cte1 AS(
    SELECT city, HOUR(call_time) AS hour, COUNT(caller_id) AS number_of_calls
    FROM Calls
    GROUP BY city, HOUR(call_time)
), cte2 AS(
    SELECT *, RANK() OVER(PARTITION BY city ORDER BY number_of_calls DESC) AS rnk
    FROM cte1
)
SELECT city, hour AS peak_calling_hour, number_of_calls
FROM cte2
WHERE rnk = 1
ORDER BY peak_calling_hour DESC, city DESC
