# Write your MySQL query statement below
-- SELECT c1.seat_id
-- FROM Cinema c1
-- LEFT JOIN Cinema c2
-- ON c1.seat_id = c2.seat_id - 1
-- WHERE c1.free = 1
--     AND (c2.free = 1 OR c2.free IS NULL)
-- ORDER BY 1;
select distinct t1.seat_id from cinema as t1 
inner join cinema as t2 
on abs(t1.seat_id - t2.seat_id) = 1 and 
t1.free =1 and t2.free =1 
order by t1.seat_id ; 
