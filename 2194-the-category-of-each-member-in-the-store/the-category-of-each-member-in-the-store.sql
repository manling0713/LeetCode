# Write your MySQL query statement below
-- member_id|name|category
-- conversion_rate <- (100 * total number of purchases for the member) / total number of visits for the member

SELECT m.member_id
    , name
    , CASE WHEN 100 * COUNT(charged_amount) / COUNT(v.visit_id) >= 80 THEN 'Diamond'
        WHEN 100 * COUNT(charged_amount) / COUNT(v.visit_id) < 50 THEN 'Silver'
        WHEN COUNT(v.visit_id) = 0 THEN 'Bronze'
        ELSE 'Gold' END AS category 
FROM Members m
LEFT JOIN Visits v
ON m.member_id = v.member_id
LEFT JOIN Purchases p
ON p.visit_id = v.visit_id
GROUP BY m.member_id; 