# Write your MySQL query statement below
WITH candidate_info AS (
    SELECT candidate_id
        , project_id
        , COUNT(c.skill) AS can_skills
        , SUM(
            CASE WHEN proficiency > importance THEN 10
            WHEN proficiency < importance THEN -5
            ELSE 0 END 
        ) + 100 AS score
    FROM Candidates c
    LEFT JOIN Projects p
    ON c.skill = p.skill
    GROUP BY candidate_id, project_id
), project_info AS (
    SELECT project_id 
        , COUNT(skill) AS proj_skills
    FROM Projects
    GROUP BY project_id
), candidate_rank AS(
    SELECT candidate_id
        , project_id
        , score
        , ROW_NUMBER() OVER(PARTITION BY project_id ORDER BY score DESC, candidate_id) AS rnk
    FROM candidate_info
    WHERE (project_id, can_skills) IN (
        SELECT project_id, proj_skills
        FROM project_info
    )
)

SELECT project_id
    , candidate_id
    , score
FROM candidate_rank
WHERE rnk = 1
ORDER BY project_id;
