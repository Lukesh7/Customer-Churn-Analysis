-- to create a database
-- CREATE DATABASE telecom_churn;
USE telecom_churn;

-- to check the imported data
SELECT * 
FROM customer_churn
LIMIT 10;

-- to check row count
SELECT COUNT(*) AS Total_Customers
FROM customer_churn;

-- Churn Count
SELECT Churn, COUNT(*) AS Customers
FROM customer_churn
GROUP BY Churn;

-- Question 1 — What is the overall churn rate?
SELECT COUNT(*) AS Total_Customers,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
	ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Churn_Rate
FROM customer_churn;

-- Question 2 — Which contract type has the highest churn?

SELECT Contract, 
	COUNT(*) AS Total_customers,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
	ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2 ) AS Churn_Rate
FROM customer_churn
GROUP BY Contract
ORDER BY Churn_Rate DESC;

-- Question 3 — Which tenure group has the highest churn?
SELECT TenureGroup,
	COUNT(*) AS Total_Customers,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 END) AS Churned_Customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2 ) AS Churn_Rate
FROM customer_churn
GROUP BY TenureGroup
ORDER BY Churn_Rate DESC;

-- Q4 — Which Internet Service has the highest churn?
SELECT InternetService,
	COUNT(*) AS Total_customers,
	SUM(CASE WHEN Churn = 'Yes'THEN 1 ELSE 0 END) AS Churned_Customers,
	ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Churn_Rate
FROM customer_churn
GROUP BY InternetService
ORDER BY Churn_Rate DESC;

-- Q5 — Which payment method has the highest churn?
SELECT PaymentMethod,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2) AS Churn_Rate
FROM customer_churn
GROUP BY PaymentMethod
ORDER BY Churn_Rate DESC;

-- Q6 — Does monthly charge level affect churn?

SELECT MonthlyChargesGroup,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Churn_Rate
FROM customer_churn
GROUP BY MonthlyChargesGroup
ORDER BY Churn_Rate DESC;

-- Q7 — Does Tech Support reduce churn?

SELECT TechSupport,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Churn_Rate
FROM customer_churn
GROUP BY TechSupport
ORDER BY Churn_Rate DESC;

-- Q8 — Identify High-Risk Customers

SELECT 
	COUNT(*) AS High_Risk_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS High_Risk_Churned,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS High_Risk_Churn_Rate
FROM customer_churn
WHERE Contract = 'Month-to-month'
  AND TenureGroup = '0-12 months'
  AND MonthlyChargesGroup = 'High'
  AND TechSupport = 'No';
    
-- Q9 - Find the Top 10 High-Value Customers Who Churned

SELECT customerID,
    Contract,
    tenure,
    MonthlyCharges,
    InternetService,
    PaymentMethod,
    Churn
FROM customer_churn
WHERE Churn = 'Yes'
ORDER BY MonthlyCharges DESC
LIMIT 10;
-- Q10 — Find the Highest-Risk Contract × Tenure Segment
SELECT 
	Contract, 
	TenureGroup,
    COUNT(*) AS Total_Customers,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Churn_Rate
FROM customer_churn
GROUP BY Contract, TenureGroup
ORDER BY Churn_rate DESC;

-- Q11 — Use a CTE - How does each contract's churn rate compare with the overall churn rate?
WITH Contract_Churn AS (
	SELECT 
		Contract,
		COUNT(*) AS Total_Customers,
		SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers
    FROM customer_churn
    GROUP BY Contract
)
 SELECT 
	Contract,
    Total_Customers,
    Churned_Customers,
    ROUND(Churned_Customers * 100.0 / Total_Customers, 2) AS Churn_rate
FROM Contract_Churn
ORDER BY Churn_Rate DESC;

-- Q12 — Rank Contract Type
SELECT 
	Contract,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) , 2) AS Churn_Rate,
    RANK() OVER (ORDER BY SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) DESC) AS Churn_Rank
FROM customer_churn
GROUP BY Contract;

-- Q13 — Build the Retention Target List
SELECT
    customerID,
    Contract,
    tenure,
    TenureGroup,
    MonthlyCharges,
    MonthlyChargesGroup,
    InternetService,
    PaymentMethod,
    TechSupport,
    OnlineSecurity,
    DeviceProtection,
    Churn
FROM customer_churn
WHERE Contract = 'Month-to-month'
  AND TenureGroup = '0-12 months'
  AND MonthlyChargesGroup = 'High'
  AND TechSupport = 'No'
  AND Churn = 'Yes'
ORDER BY MonthlyCharges DESC;

-- Q14 — Identify High-Value + High-Risk Customers
SELECT
    customerID,
    tenure,
    Contract,
    MonthlyCharges,
    InternetService,
    PaymentMethod,
    TechSupport,
    OnlineSecurity,
    DeviceProtection,
    Churn
FROM customer_churn
WHERE Contract = 'Month-to-month'
  AND TenureGroup = '0-12 months'
  AND TechSupport = 'No'
  AND MonthlyCharges > 70
ORDER BY MonthlyCharges DESC;

-- Q15 — Create a Business Risk Classification
SELECT
    customerID,
    Contract,
    tenure,
    MonthlyCharges,
    TechSupport,
    Churn,

    CASE
        WHEN Contract = 'Month-to-month'
             AND tenure <= 12
             AND MonthlyCharges > 70
             AND TechSupport = 'No'
        THEN 'High Risk'

        WHEN Contract = 'Month-to-month'
             AND tenure <= 24
        THEN 'Medium Risk'

        ELSE 'Low Risk'
    END AS Risk_Level

FROM customer_churn;














