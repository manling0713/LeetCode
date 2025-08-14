# Write your MySQL query statement below
-- join table using skill 
-- LEFT JOIN Candidates
-- using case when to calculate the score
-- SUM score GROUP BY candidate_id
-- ROW_NUMBER() OVER(PARTITION BY project_id ORDER BY score DESC, candidate_id)
-- WHERE candidate_id is not null

-- WITH project_candidate AS(
--     SELECT project_id
--         , candidate_id
--         , p.skill
--         , CASE WHEN proficiency > importance THEN 10
--             WHEN proficiency < importance THEN -5
--             WHEN proficiency IS NULL THEN -1000
--             ELSE 0 END AS score
--     FROM Projects p
--     LEFT JOIN Candidates c
--     ON p.skill = c.skill
-- ), total_score AS(
--     SELECT project_id
--         , candidate_id
--         , SUM(score) + 100 AS sum_score
--         , ROW_NUMBER() OVER(PARTITION BY project_id ORDER BY SUM(score) DESC, candidate_id) AS rnk
--     FROM project_candidate
--     GROUP BY project_id, candidate_id
-- )

-- SELECT project_id
--     , candidate_id
--     , sum_score AS score
-- FROM total_score
-- WHERE rnk = 1
--     AND sum_score > 0
-- ORDER BY project_id;

with candidate_info as(
    select candidate_id,project_id,count(skill)skills,
    100+sum(
        case when proficiency>importance  then 10
        when proficiency<importance  then -5
        else 0 end
    )score
    from Candidates 
    join projects
    using(skill)
    group by 1,2
),
project_info as(
select project_id  ,count(skill)skills
from projects
group by 1
),
cte as(
    select project_id  ,candidate_id ,score,
    dense_rank() over(partition by project_id order by score desc,candidate_id )rnk
    from candidate_info
    join project_info
    using(skills,project_id)
    )
    select project_id  ,candidate_id ,score
    from cte
    where rnk=1

