# Write your MySQL query statement below
WITH first_login AS(
    SELECT player_id, MIN(event_date) AS first
    FROM Activity
    GROUP BY player_id
), cons_player AS(
    SELECT COUNT(DISTINCT f.player_id) AS players
    FROM first_login f, Activity a2
    WHERE f.player_id = a2.player_id 
        AND event_date = DATE_ADD(first, INTERVAL 1 DAY) 
)
SELECT ROUND(players/COUNT(DISTINCT player_id), 2) AS fraction
FROM Activity
JOIN cons_player

