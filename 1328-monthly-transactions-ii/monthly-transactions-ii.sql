# Write your MySQL query statement below
with cte as(
    select * from Transactions  where state='approved'
    union all
    select id,country,'cbe' state,amount,b.trans_date
    from Chargebacks b
    left join Transactions a
on a.id=b.trans_id
)
select date_format(trans_date,'%Y-%m') month,country,
sum(state='approved')approved_count,
sum(if(state='approved',amount,0)) approved_amount ,
sum(state='cbe') chargeback_count ,
sum(if(state='cbe',amount,0))chargeback_amount 
from cte
group by 1,2

