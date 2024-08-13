# Write your MySQL query statement below
WITH customer_contact AS(
    SELECT customer_id
        , customer_name
        , COUNT(contact_name) AS contacts_cnt
        , SUM(CASE WHEN contact_email IN (SELECT email FROM Customers) THEN 1
                ELSE 0 END) AS trusted_contacts_cnt
    FROM Customers cu
    LEFT JOIN Contacts co
    ON cu.customer_id = co.user_id
    GROUP BY customer_id
)
SELECT invoice_id, customer_name, price, contacts_cnt, trusted_contacts_cnt
FROM Invoices i
LEFT JOIN customer_contact cc
ON i.user_id = cc.customer_id
ORDER BY 1