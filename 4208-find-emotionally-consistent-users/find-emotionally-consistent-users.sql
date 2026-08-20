# Write your MySQL query statement below
# user_id, dominant_reaction, reaction_ratio
# COUNT(DISTINCT content_id) AS content_cnt
# GROUP BY user_id
# HAVING eaction_type >= 5 -> user_id
# COUNT(*) AS reaction_cnt GROUP BY user_id, reaction
# COUNT(*) AS total_reaction GROUP BY user_id
# ROUND(reaction_cnt / total_reaction, 2)*100 AS reaction_ratio
# WHERE reaction_cnt / total_reaction >= 60
WITH target_users AS(
    SELECT user_id
    FROM reactions
    GROUP BY user_id
    HAVING COUNT(content_id) >= 5
), user_reaction As(
    SELECT user_id
        , reaction
        , COUNT(*) AS reaction_cnt
    FROM reactions
    WHERE user_id IN (SELECT user_id FROM target_users)
    GROUP BY user_id, reaction
), user_total AS(
    SELECT user_id
        , COUNT(*) AS total_reactions
    FROM reactions
    WHERE user_id IN (SELECT user_id FROM target_users)
    GROUP BY user_id
)
SELECT ur.user_id
    , reaction AS dominant_reaction
    , ROUND(reaction_cnt / total_reactions, 2) AS reaction_ratio
FROM user_reaction ur
LEFT JOIN user_total ut
ON ur.user_id = ut.user_id
WHERE ROUND(reaction_cnt / total_reactions, 2) > 0.6
ORDER BY 3 DESC, 1



