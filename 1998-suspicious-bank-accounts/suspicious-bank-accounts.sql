# Write your MySQL query statement below
-- account_id, SUM(amount)
-- group by account_id, month
-- SUM(amount) > max_income

# Write your MySQL query statement below
WITH income_table AS(
    SELECT account_id
        , DATE_FORMAT(day, '%Y%m') AS months
        , sum(amount) as total_income 
    FROM Transactions 
    WHERE type = 'Creditor'
    GROUP BY account_id, DATE_FORMAT(day, '%Y%m')
), time_table AS(
    SELECT i.account_id
        , months,total_income
        , LEAD(months, 1) OVER(PARTITION BY account_id ORDER BY months) as next_month  
FROM income_table i 
LEFT JOIN Accounts a
ON i.account_id = a.account_id
WHERE total_income > max_income
)

SELECT DISTINCT account_id
FROM time_table 
WHERE next_month - months = 1 