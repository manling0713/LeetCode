# Write your MySQL query statement below
-- account_id, SUM(amount)
-- group by account_id, month
-- SUM(amount) > max_income

# Write your MySQL query statement below
with income_table as(SELECT account_id, DATE_FORMAT(day, '%Y%m') AS months, sum(amount) as total_income 
FROM Transactions 
where type = 'Creditor'
GROUP BY account_id, DATE_FORMAT(day, '%Y%m')),

time_table as(SELECT i.account_id, months,total_income, max_income, 
lead(months, 1) over(partition by account_id order by months) as next_month  
FROM income_table i join Accounts a
on i.account_id = a.account_id
where total_income>max_income)

select distinct(account_id)
from time_table 
where next_month - months = 1 