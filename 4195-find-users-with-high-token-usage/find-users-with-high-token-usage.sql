# Write your MySQL query statement below
WITH user_avg_tokens AS(
    SELECT user_id
        , COUNT(*) AS prompt_count
        , ROUND(AVG(tokens), 2) AS avg_tokens
    FROM prompts
    GROUP BY user_id
    HAVING COUNT(*) >= 3
)
SELECT DISTINCT p.user_id
    , prompt_count
    , avg_tokens
FROM prompts p
INNER JOIN user_avg_tokens u
ON p.user_id = u.user_id
    AND tokens > u.avg_tokens
ORDER BY avg_tokens DESC, p.user_id


