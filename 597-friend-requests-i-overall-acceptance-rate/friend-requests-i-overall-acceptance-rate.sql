# Write your MySQL query statement below
WITH total_request AS(
    SELECT COUNT(DISTINCT sender_id, send_to_id) AS total
    FROM FriendRequest
), accept AS(
    SELECT COUNT(DISTINCT requester_id, accepter_id) AS acceptance
    FROM RequestAccepted
)
SELECT ROUND(IFNULL(acceptance/total, 0), 2) AS accept_rate
FROM total_request, accept
