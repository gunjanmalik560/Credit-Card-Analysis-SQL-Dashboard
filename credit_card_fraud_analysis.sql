-- ============================================
-- Credit Card Fraud Analysis Queries
-- ============================================

-- 1. Total transactions vs fraud transactions
SELECT 
    is_fraud,
    COUNT(*) AS total_transactions
FROM transactions
GROUP BY is_fraud;


-- 2. Transaction amount summary
SELECT 
    MIN(amount) AS min_amount,
    MAX(amount) AS max_amount,
    AVG(amount) AS avg_amount
FROM transactions;


-- 3. Overall fraud percentage
SELECT 
    ROUND(100 * SUM(is_fraud) / COUNT(*), 2) AS fraud_percentage
FROM transactions;


-- 4. Top 10 fraud transactions by amount
SELECT *
FROM transactions
WHERE is_fraud = 1
ORDER BY amount DESC
LIMIT 10;


-- 5. Transactions by hour
SELECT 
    transaction_hour AS hour,
    COUNT(*) AS total_transactions
FROM transactions
GROUP BY transaction_hour
ORDER BY transaction_hour;


-- 6. Fraud vs legitimate transactions by hour
SELECT 
    transaction_hour,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    SUM(CASE WHEN is_fraud = 0 THEN 1 ELSE 0 END) AS legit_transactions
FROM transactions
GROUP BY transaction_hour
ORDER BY transaction_hour;


-- 7. Fraud percentage by hour
SELECT 
    transaction_hour,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS fraud_percentage
FROM transactions
GROUP BY transaction_hour
ORDER BY transaction_hour;


-- 8. Fraud analysis by merchant category
SELECT 
    merchant_category,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS fraud_percentage
FROM transactions
GROUP BY merchant_category
ORDER BY fraud_percentage DESC
LIMIT 10;


-- 9. Fraud analysis by device trust score
SELECT 
    device_trust_score,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS fraud_percentage
FROM transactions
GROUP BY device_trust_score
ORDER BY fraud_percentage DESC;


-- 10. Fraud analysis by age group
SELECT 
    CASE 
        WHEN cardholder_age < 25 THEN '<25'
        WHEN cardholder_age BETWEEN 25 AND 40 THEN '25-40'
        WHEN cardholder_age BETWEEN 41 AND 60 THEN '41-60'
        ELSE '>60'
    END AS age_group,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS fraud_percentage
FROM transactions
GROUP BY age_group
ORDER BY fraud_percentage DESC;


-- 11. Fraud analysis by foreign transaction
SELECT 
    foreign_category,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS fraud_percentage
FROM transactions
GROUP BY foreign_category
ORDER BY fraud_percentage DESC;


-- 12. Fraud analysis by transaction velocity
SELECT 
    velocity_last_24h,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS fraud_percentage
FROM transactions
GROUP BY velocity_last_24h
ORDER BY velocity_last_24h DESC;


-- 13. Fraud analysis by location mismatch
SELECT 
    location_mismathch,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
    ROUND(
        SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100,
        2
    ) AS fraud_percentage
FROM transactions
GROUP BY location_mismathch
ORDER BY fraud_percentage DESC;
