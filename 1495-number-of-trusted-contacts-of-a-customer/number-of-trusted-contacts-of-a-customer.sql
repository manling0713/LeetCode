# Write your MySQL query statement below
WITH trust AS(
    SELECT user_id, COUNT(DISTINCT email) AS trusted_contacts_cnt
    FROM Contacts co
    LEFT JOIN Customers cu
    ON co.contact_email = cu.email 
    GROUP BY user_id
), cus_trust AS(
    SELECT customer_id, customer_name, IFNULL(trusted_contacts_cnt,0) AS trusted_contacts_cnt
    FROM Customers c 
    LEFT JOIN trust t
    ON c.customer_id = t.user_id
), cnt AS (
    SELECT user_id, COUNT(contact_name) AS contacts_cnt
    FROM Contacts 
    GROUP BY user_id
)

SELECT invoice_id, customer_name, price, IFNULL(contacts_cnt,0) AS contacts_cnt, trusted_contacts_cnt
FROM Invoices i
LEFT JOIN cnt USING(user_id)
LEFT JOIN cus_trust c
ON i.user_id = c.customer_id
ORDER BY invoice_id
