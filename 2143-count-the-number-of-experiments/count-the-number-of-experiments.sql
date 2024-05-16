# Write your MySQL query statement below
WITH platforms AS (
    SELECT 'Android' AS platform
    UNION ALL
    SELECT 'IOS' AS platform
    UNION ALL
    SELECT 'Web' AS platform
), experiment AS (
    SELECT 'Reading' AS experiment_name
    UNION ALL
    SELECT 'Sports' AS experiment_name
    UNION ALL
    SELECT 'Programming' AS experiment_name
)
SELECT p.platform, ex.experiment_name, COUNT(e.experiment_name) AS num_experiments 
FROM platforms p
CROSS JOIN experiment ex
LEFT JOIN Experiments e
ON p.platform = e.platform AND ex.experiment_name = e.experiment_name
GROUP BY p.platform, ex.experiment_name
