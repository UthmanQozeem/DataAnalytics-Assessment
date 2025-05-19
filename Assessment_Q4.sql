-- Q4: Estimate CLV = (total_tx / tenure_months) * 12 * avg_profit_per_tx
SELECT 
    u.id AS customer_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE()) AS tenure_months,
    COUNT(s.id) AS total_transactions,
    ROUND((SUM(s.confirmed_amount) / NULLIF(TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE()), 0)) * 0.001 * 12, 2) AS estimated_clv
FROM users_customuser u
JOIN savings_savingsaccount s 
    ON s.owner_id = u.id
    AND s.confirmed_amount > 0
GROUP BY u.id, name
ORDER BY estimated_clv DESC;
