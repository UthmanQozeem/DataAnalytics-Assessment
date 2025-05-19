-- Q2: Categorize customers based on transaction frequency (monthly average)
-- Includes customer counts per category and their average transaction rate

WITH transaction_counts AS (
    SELECT 
        owner_id,
        COUNT(*) AS total_transactions,
        TIMESTAMPDIFF(MONTH, MIN(transaction_date), MAX(transaction_date)) AS active_months
    FROM savings_savingsaccount
    WHERE confirmed_amount > 0
    GROUP BY owner_id
),
frequency_summary AS (
    SELECT 
        CASE 
            WHEN total_transactions / NULLIF(active_months, 0) >= 10 THEN 'High Frequency'
            WHEN total_transactions / NULLIF(active_months, 0) BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        COUNT(*) AS customer_count,
        ROUND(AVG(total_transactions / NULLIF(active_months, 0)), 1) AS avg_transactions_per_month
    FROM transaction_counts
    GROUP BY frequency_category
)
SELECT * FROM frequency_summary;
