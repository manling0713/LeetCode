# Write your MySQL query statement below
WITH same_policy AS(
    SELECT DISTINCT i1.pid, i1.tiv_2016
    FROM Insurance i1, Insurance i2
    WHERE i1.pid <> i2.pid AND i1.tiv_2015 = i2.tiv_2015
), location AS(
    SELECT DISTINCT i1.pid
    FROM Insurance i1, Insurance i2
    WHERE i1.pid <> i2.pid AND i1.lat = i2.lat AND i1.lon = i2.lon
)
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM same_policy
WHERE pid NOT IN (
    SELECT pid
    FROM location
)