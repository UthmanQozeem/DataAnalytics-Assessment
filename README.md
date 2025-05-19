# DataAnalytics-Assessment

This repository contains SQL scripts details I developed to answer a set of analytical questions related to user transactions, account activity, and customer value using a financial database.

---

## ✅ Questions & Approaches

### Q1: High-Value Customers with Multiple Products

**Goal**: Identify customers with at least one funded savings plan and one funded investment plan, and sort them by total deposits.

**Approach**:
-I Joined `users_customuser`, `savings_savingsaccount`, and `plans_plan` using `owner_id`
-I Filtered savings accounts with `confirmed_amount > 0`
-I Filtered plans with `is_a_fund = 1` for investments
-I Grouped results by user and counted each plan type
-I Aggregated `confirmed_amount` to calculate deposits
-I Sorted by `total_deposits`

---

### Q2: Transaction Frequency Analysis

**Goal**: Classify customers as High, Medium, or Low frequency users based on average monthly transactions.

**Approach**:
-I Counted all transactions per customer
-I Calculated the active period in months using `transaction_date`
-I Categorized frequency based on thresholds (≥10, 3–9, ≤2)
-I Grouped by frequency category to get average and count

---

### Q3: Account Inactivity Alert

**Goal**: Identify savings or investment plans with no transactions in the past 365 days.

**Approach**:
-I Joined `plans_plan` and `savings_savingsaccount` via `plan_id`
-I Retrieved latest `transaction_date` per plan
-I Calculated the number of inactive days using `DATEDIFF`
-I Filtered those with more than 365 days of inactivity

---

### Q4: Customer Lifetime Value (CLV) Estimation

**Goal**: Estimate customer CLV based on transaction history and account tenure.

**Approach**:
-I Used `date_joined` from `users_customuser` to calculate tenure in months
-I Counted `confirmed_amount` transactions from `savings_savingsaccount`
-I Assumed profit = 0.1% of transaction amount
-I Applied formula: `CLV = (Total Confirmed Amount / Tenure) * 0.001 * 12`
-I Ranked customers by estimated CLV

---

## ⚠️ Challenges Encountered

1. **Handling Division by Zero**:  
   Some users may have very short tenure (0 months), causing divide-by-zero errors. This was resolved using `NULLIF(..., 0)`.

2. **Data Gaps in Tables**:  
   Some plans may exist without matching savings accounts or transaction records. `LEFT JOIN` and appropriate filters were used to ensure inclusivity without null errors.

3. **Category Boundaries in Frequency Classification**:  
   Clear conditional logic was used to assign users to `High`, `Medium`, or `Low` categories with precise boundary checks (`BETWEEN`, `>=`, etc.).

---

## 📁 File Descriptions

| File              | Description                                     |
|-------------------|-------------------------------------------------|
| Assessment_Q1.sql | SQL to identify high-value multi-product users  |
| Assessment_Q2.sql | SQL to categorize users by transaction frequency |
| Assessment_Q3.sql | SQL to find inactive accounts                   |
| Assessment_Q4.sql | SQL to estimate customer lifetime value (CLV)   |

---

## 📌 Notes
- All monetary fields were assumed to be in **kobo**, hence divided by 100 for Naira.
- All results assume accurate time values in the `date_joined` and `transaction_date` fields.
- These scripts were written in standard MySQL syntax.

---

