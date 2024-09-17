# Write your MySQL query statement below
SELECT DISTINCT l1.account_id
FROM LogInfo l1, LogInfo l2
WHERE l1.login BETWEEN l2.login AND l2.logout
    AND l1.account_id = l2.account_id
    AND l1.ip_address != l2.ip_address