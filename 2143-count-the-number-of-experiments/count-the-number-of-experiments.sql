WITH all_platform AS (
    SELECT 'Android' AS platform
    UNION ALL 
    SELECT 'IOS' AS platform
    UNION ALL 
    SELECT 'Web' AS platform
), all_experiment AS(
    SELECT 'Reading' AS experiment_name
    UNION ALL 
    SELECT 'Sports' AS experiment_name
    UNION ALL 
    SELECT 'Programming' AS experiment_name
)

SELECT p.platform
    , a.experiment_name
    , COUNT(e.experiment_id) AS num_experiments
FROM all_platform AS p
CROSS JOIN all_experiment AS a
LEFT JOIN Experiments e
    ON e.experiment_name = a.experiment_name AND p.platform = e.platform
GROUP BY p.platform, a.experiment_name;
