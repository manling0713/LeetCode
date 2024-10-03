# Write your MySQL query statement below

SELECT player_id
    , player_name
    , SUM(CASE WHEN player_id = Wimbledon THEN 1 ELSE 0 END +
        CASE WHEN player_id = Fr_open THEN 1 ELSE 0 END +
        CASE WHEN player_id = US_open THEN 1 ELSE 0 END +
        CASE WHEN player_id = Au_open THEN 1 ELSE 0 END ) AS grand_slams_count
FROM Championships c
LEFT JOIN Players p
ON p.player_id = c.Wimbledon
    OR p.player_id = c.Fr_open
    OR p.player_id = c.US_open
    OR p.player_id = c.Au_open
GROUP BY 1;