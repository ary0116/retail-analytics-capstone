# Retail Analytics: Customer Behavior & Campaign Optimization

**[View the interactive dashboard on Tableau Public](https://public.tableau.com/views/CapstoneProject_17821032751470/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)**

## The Question
The goal of this capstone project is to develop a comprehensive understanding of 
customer behavior and preferences based on retail transaction data. 
The aim is to analyze customers' demographic information, purchasing patterns, 
and interactions with marketing campaigns to identify key insights.

## The Data
- Source: [Raw Data/martketing_campaign.csv]
- Size: [ID, Year_Birth, Education, Marital_Status, Income, Kidhome, Teenhome, Dt_Customer, Recency, MntWines, MntFruits, MntMeatProducts, MntFishProducts, MntSweetProducts, MntGoldProds, NumDealsPurchases, NumDealsPurchases, NumWebPurchases, NumCatalogPurchases, NumStorePurchases, NumWebVisitsMonth, AcceptedCmp1, AcceptedCmp2, AcceptedCmp3, AcceptedCmp4, AcceptedCmp5, Response, Complain, Z_CostContact, Z_Revenue, Response_Total]

## Process & Tools
| Stage | Tool | What I Did |
|-------|------|-----------|
| Cleaning & exploration | Excel | removed duplicates, handled missing values, initial pivots |
| Loading & processing | MySQL | built schema, joined transaction/customer tables, aggregation queries |
| Analysis | Python (Jupyter) | segmentation, response-rate analysis, visualizations |
| Visualization | Tableau | Interactive dashboard for campaign insights |

## Key Findings
1. Average spending decreasing through the 3 years period — from 2012 -> 2013 -> 2014
2. Comparing the different purchase methods, catalog being the least used method with the most count in the "never" and "once" category, with store visits peaking at 3 times but still have returning customers for up to 13 times and web visits with less than 5 times
3. Campaign 2 participation rate being the least, Campaign 1 being second to last, and Campaign 3, 4, and 5 being around the same

## Recommendation
1. 2012 was the peak year for both spending and visits. Further investigation into that year's pricing, product mix, and marketing initiatives could reveal repeatable success factors worth reintroducing.
2. Catalog purchases are declining as consumer behavior shifts to digital channels. The company should redirect catalog budget toward its website and consider developing a mobile app to engage customers where they already shop.
3. Campaign performance varied significantly. Campaign 2 failed to generate a positive return and should be excluded from future planning. Campaigns 3, 4, and 5 produced similar engagement levels, making their shared characteristics a strong template for future campaign design.

## Repository Contents
- `/CapstoneProject.sql` — database schema and analysis queries
- `/CapstoneProject.ipynb` — Jupyter notebook with full analysis
- `/CapstoneProject.xlsx` — data cleaning workbook
- `/CapstoneProject.pdf` — dashboard previews
