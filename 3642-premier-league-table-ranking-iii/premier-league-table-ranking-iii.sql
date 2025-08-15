# Write your MySQL query statement below
-- wins * 3 + draws + losses * 0 AS points
-- goals_for - goals_against AS goal_difference
-- ROW_NUMBER() OVER(PARTITION BY season_id ORDER BY points DESC, gd DESC, team_name)
-- ORDER BY season_id, position, team_name

SELECT season_id
    , team_id
    , team_name
    , wins * 3 + draws AS points
    , goals_for - goals_against AS goal_difference
    , ROW_NUMBER() OVER(PARTITION BY season_id ORDER BY wins * 3 + draws DESC, goals_for - goals_against DESC, team_name) AS position
FROM SeasonStats
ORDER BY season_id, position, team_name;