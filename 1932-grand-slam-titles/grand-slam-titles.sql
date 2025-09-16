# Write your MySQL query statement below
WITH all_champ AS(
    SELECT year
        , Wimbledon AS player_id
    FROM Championships
    UNION ALL
    SELECT year
        , Fr_open AS player_id
    FROM Championships
    UNION ALL
    SELECT year
        , Us_open AS player_id
    FROM Championships
    UNION ALL
    SELECT year
        , AU_open AS player_id
    FROM Championships
)
SELECT a.player_id
    , player_name
    , COUNT(*) AS grand_slams_count
FROM all_champ a
LEFT JOIN Players p
ON a.player_id = p.player_id 
GROUP BY a.player_id, player_name
