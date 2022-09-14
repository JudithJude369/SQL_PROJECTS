Create database project

#Data overview
Select *
From project.`companies`

#Remove delimiters and leading currencies 
UPDATE companies
SET revenues_percent_change=replace(revenues_percent_change,'%','');

UPDATE companies
SET profits_percent_change=replace(profits_percent_change,'%','');

#Remove delimiters and leading currencies from revenues 
UPDATE companies
SET revenues=replace(revenues,'$','');

UPDATE companies
SET revenues=replace(revenues,',','');

#Convert revenues column to Decimal
 ALTER TABLE companies MODIFY revenues DECIMAL(10, 2);
 
#Remove delimiters and leading currencies from profits
UPDATE companies
SET profits=replace(profits,'$','');

UPDATE companies
SET profits=replace(profits,',','');

#Convert profits column to Decimal
 ALTER TABLE companies MODIFY profits DECIMAL(10, 2);

#Remove delimiters and leading currencies from assets 
UPDATE companies
SET assets=replace(assets,'$','');

UPDATE companies
SET assets=replace(assets,',','');

#Convert assets column to Decimal
 ALTER TABLE companies MODIFY assets DECIMAL(10, 2);

#Remove delimiters and leading currencies from market_value 
UPDATE companies
SET market_value=replace(market_value,'$','');

UPDATE companies
SET market_value=replace(market_value,',','');

#Convert market_value column to Decimal
 ALTER TABLE companies MODIFY market_value DECIMAL(10, 2);

#Remove delimiters and leading currencies from market_value 
UPDATE companies
SET employees=replace(employees,',','');

#Rename column names

ALTER TABLE companies   
RENAME COLUMN name TO Name,  
RENAME COLUMN revenues TO Revenue,  
RENAME COLUMN profits TO Profit,  
RENAME COLUMN assets TO Asset, 
RENAME COLUMN market_value TO Market_Value, 
RENAME COLUMN employees TO Employee;  

#Find the Company that made the highest profit 
SELECT DISTINCT Name, MAX(Profit) AS max_profit
FROM  project.`companies`
ORDER BY Name, Profit

#Find the Company that made the lowest profit 
SELECT DISTINCT Name, Profit
FROM project.`companies`
WHERE Profit =  ( SELECT MIN(Profit) 
FROM  project.`companies` )
ORDER BY Name, Profit

#Relationship Between Profit and Revenue
Select Profit, Revenue
From project.`companies`

#Ask and Answer Questions about the Data
1. What are the companies that made the highest  profits?
We will be looking at the top 10 companies

SELECT DISTINCT Name, Profit 
FROM project.`companies`  
ORDER BY Profit DESC
LIMIT 0, 10

2. What is the distribution of market value per company?

SELECT DISTINCT Name, Market_Value
FROM project.`companies`  
ORDER BY Market_Value DESC
LIMIT 0, 10

3. What are the companies with highest asset?

SELECT DISTINCT Name, Asset
FROM project.`companies`  
ORDER BY Asset DESC
LIMIT 0, 10

4. Which of the companies has the highest number of employees??

SELECT DISTINCT Name, Employee
FROM project.`companies`  
ORDER BY Employee DESC
LIMIT 0, 10
