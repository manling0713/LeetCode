WITH id_count AS(
    SELECT DISTINCT l1.id
    FROM Logins l1
    INNER JOIN Logins l2
    ON l1.id = l2.id AND DATEDIFF(l1.login_date, l2.login_date) BETWEEN 1 AND 4
    GROUP BY l1.id, l1.login_date
    HAVING COUNT(DISTINCT l2.login_date) = 4
)
SELECT *
FROM Accounts
WHERE id IN(
    SELECT *
    FROM id_count
)
ORDER BY id