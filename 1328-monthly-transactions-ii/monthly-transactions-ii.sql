# Write your MySQL query statement below
WITH trans AS(
    SELECT LEFT(c.trans_date, 7) AS month
        , country
        , "back" AS state
        , amount
    FROM Chargebacks c
    LEFT JOIN Transactions t
    ON c.trans_id = t.id
    UNION ALL
    SELECT LEFT(trans_date, 7) As month
        , country
        , state
        , amount
    FROM Transactions
    WHERE state ='approved'
)
SELECT month
    , country
    , SUM(IF(state='approved',1,0)) AS approved_count
    , SUM(IF(state='approved',amount,0)) AS approved_amount
    , SUM(IF(state='back',1,0)) AS chargeback_count
    , SUM(IF(state='back',amount,0)) AS chargeback_amount
FROM trans
GROUP BY month, country
