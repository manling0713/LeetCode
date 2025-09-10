# Write your MySQL query statement below
WITH all_trans AS(
    SELECT id
        , country
        , state
        , amount
        , trans_date
    FROM Transactions
    WHERE state = 'approved'
    UNION ALL
    SELECT t.id
        , t.country
        , 'cb' AS state
        , t.amount
        , c.trans_date
    FROM Chargebacks c
    JOIN Transactions t
    ON t.id = c.trans_id
)
SELECT date_format(trans_date, '%Y-%m') AS month
    , country
    , SUM(IF(state='approved', 1, 0)) AS approved_count
    , SUM(IF(state='approved', amount, 0)) AS approved_amount
    , SUM(IF(state='cb', 1, 0)) AS chargeback_count
    , SUM(IF(state='cb', amount, 0)) AS chargeback_amount
FROM all_trans
GROUP BY 1, 2;

