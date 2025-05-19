-- Q1: Identify customers with at least one funded savings plan and one funded investment plan

-- Step 1: How many savings accounts with confirmed deposits?
SELECT COUNT(*) FROM savings_savingsaccount WHERE confirmed_amount > 0;

-- Step 2: How many investment plans exist?
-- REFACTORED: High-Value Customers with Multiple Products
WITH savings AS (
    SELECT owner_id, SUM(confirmed_amount) AS total_savings, COUNT(*) AS savings_count
    FROM savings_savingsaccount
    WHERE confirmed_amount > 0
    GROUP BY owner_id
),
investments AS (
    SELECT owner_id, COUNT(*) AS investment_count
    FROM plans_plan
    WHERE is_a_fund = 1
    GROUP BY owner_id
)

SELECT 
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    s.savings_count,
    i.investment_count,
    ROUND(s.total_savings / 100, 2) AS total_deposits
FROM users_customuser u
JOIN savings s ON s.owner_id = u.id
JOIN investments i ON i.owner_id = u.id
ORDER BY total_deposits DESC;
