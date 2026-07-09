CREATE SCHEMA IF NOT EXISTS retail_data;

USE retail_data;

DROP TABLE IF EXISTS marketing_campaign;

CREATE TABLE marketing_campaign (
    ID                  INT PRIMARY KEY,
    Year_Birth          INT,
    Education           VARCHAR(50),
    Marital_Status      VARCHAR(50),
    Income              DECIMAL(13,2),
    Kidhome             INT,
    Teenhome            INT,
    Dt_Customer         DATE,
    Recency             INT,
    MntWines            INT,
    MntFruits           INT,
    MntMeatProducts     INT,
    MntFishProducts     INT,
    MntSweetProducts    INT,
    MntGoldProds        INT,
    NumDealsPurchases   INT,
    NumWebPurchases     INT,
    NumCatalogPurchases INT,
    NumStorePurchases   INT,
    NumWebVisitsMonth   INT,
    AcceptedCmp3        TINYINT,
    AcceptedCmp4        TINYINT,
    AcceptedCmp5        TINYINT,
    AcceptedCmp1        TINYINT,
    AcceptedCmp2        TINYINT,
    Complain            TINYINT,
    Response            TINYINT
);


TRUNCATE TABLE retail_data.marketing_campaign;

LOAD DATA LOCAL INFILE '/Users/angelayuan/Downloads/marketing_campaign_cleaned.csv'
INTO TABLE retail_data.marketing_campaign
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ID, Year_Birth, Education, Marital_Status, Income, Kidhome, Teenhome,
 @Dt_Customer, Recency, MntWines, MntFruits, MntMeatProducts, MntFishProducts,
 MntSweetProducts, MntGoldProds, NumDealsPurchases, NumWebPurchases,
 NumCatalogPurchases, NumStorePurchases, NumWebVisitsMonth,
 AcceptedCmp3, AcceptedCmp4, AcceptedCmp5, AcceptedCmp1, AcceptedCmp2,
 Complain, Response)
SET Dt_Customer = STR_TO_DATE(@Dt_Customer, '%m/%d/%y');

-- customer count
SELECT COUNT(*) AS total_customer_encounters
FROM marketing_campaign;

-- top 10 most purchased
SELECT product_category, total_amount_spent
FROM (
    SELECT 'Wines' AS product_category, SUM(MntWines) AS total_amount_spent FROM marketing_campaign
    UNION ALL
    SELECT 'Fruits', SUM(MntFruits) FROM marketing_campaign
    UNION ALL
    SELECT 'Meat Products', SUM(MntMeatProducts) FROM marketing_campaign
    UNION ALL
    SELECT 'Fish Products', SUM(MntFishProducts) FROM marketing_campaign
    UNION ALL
    SELECT 'Sweet Products', SUM(MntSweetProducts) FROM marketing_campaign
    UNION ALL
    SELECT 'Gold Products', SUM(MntGoldProds) FROM marketing_campaign
) AS product_totals
ORDER BY total_amount_spent DESC
LIMIT 10;

-- response count
SELECT Response, COUNT(*) AS response_count
FROM marketing_campaign
GROUP BY Response;

-- distribution of customers based on education level and marital status
SELECT Education, Marital_Status, COUNT(*) AS customer_count
FROM marketing_campaign
GROUP BY Education, Marital_Status
ORDER BY Education, Marital_Status;

-- avg income of customers
SELECT AVG(Income) AS avg_income_participants
FROM marketing_campaign
WHERE Response = 1;

-- total number of promotions accepted by customers in each campaign
SELECT
    SUM(AcceptedCmp1) AS total_accepted_cmp1,
    SUM(AcceptedCmp2) AS total_accepted_cmp2,
    SUM(AcceptedCmp3) AS total_accepted_cmp3,
    SUM(AcceptedCmp4) AS total_accepted_cmp4,
    SUM(AcceptedCmp5) AS total_accepted_cmp5
FROM marketing_campaign;

-- distribution of customers' respnses to the last campaign
SELECT Response, COUNT(*) AS customer_count
FROM marketing_campaign
GROUP BY Response
ORDER BY Response;

-- avg number of children and teenagers in customers' households
SELECT
    AVG(Kidhome)  AS avg_children,
    AVG(Teenhome) AS avg_teenagers
FROM marketing_campaign;

-- create age column by subtracting year_birth from the current year
ALTER TABLE marketing_campaign ADD COLUMN Age INT;

USE retail_data;
UPDATE marketing_campaign
SET Age = YEAR(CURDATE()) - Year_Birth;

-- create age_group columns
ALTER TABLE marketing_campaign ADD COLUMN Age_group VARCHAR(10);

UPDATE marketing_campaign
SET Age_group = CASE
    WHEN Age BETWEEN 18 AND 25 THEN '18-25'
    WHEN Age BETWEEN 26 AND 35 THEN '26-35'
    WHEN Age BETWEEN 36 AND 45 THEN '36-45'
    WHEN Age BETWEEN 46 AND 55 THEN '46-55'
    ELSE '56+'
END;

SELECT Age_group, AVG(NumWebVisitsMonth) AS avg_monthly_visits
FROM marketing_campaign
GROUP BY Age_group
ORDER BY Age_group;
