# Write your MySQL query statement below
# Write your MySQL query statement below
WITH row_user AS (
    SELECT *, ROW_NUMBER() OVER() AS rn FROM Users
)

SELECT DISTINCT(a.user_id) FROM row_user a, row_user b WHERE a.user_id = b.user_id AND a.rn <> b.rn AND ABS(DATEDIFF(b.created_at, a.created_at)) <= 7
