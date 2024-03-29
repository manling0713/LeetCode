# Write your MySQL query statement below
SELECT policy_id, state, fraud_score
FROM(
    SELECT *, PERCENT_RANK() OVER(PARTITION BY state ORDER BY fraud_score DESC) AS per
    FROM Fraud
) AS sub
WHERE per <= 0.05
ORDER BY state, fraud_score DESC, policy_id

