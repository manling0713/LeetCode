# Write your MySQL query statement below
# Write your MySQL query statement below

with cte as (
select user_id, 
       count(post_id) over(partition by user_id) / 4 as avg_weekly_posts ,
       count(post_id) over(partition by user_id order by post_date range between interval 6 Day preceding and current row) as weekly_post
from Posts 
where post_date between '2024-02-01' and '2024-02-28'
)
, temp as (
select user_id, 
       max(weekly_post) over (partition by user_id) as max_7day_posts,
       avg_weekly_posts
from cte 
)

select distinct * 
from temp
where avg_weekly_posts *2 <=max_7day_posts
order by user_id asc 