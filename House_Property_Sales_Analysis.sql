-- Databricks notebook source
-- MAGIC %md
-- MAGIC #House Propery Sales Analysis Using Spark SQL

-- COMMAND ----------

-- MAGIC %md
-- MAGIC  ![test_image](/files/tables/house_property.jpg)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC The data contains sales prices for houses and units with 1,2,3,4,5 bedrooms and accumulated property sales data for the 2007-2019 period for one specific region. The dataset was gotten from kaggle.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC **Take a look at the first few lines of the data.**

-- COMMAND ----------

SELECT *
FROM raw_sales_csv
LIMIT 10

-- COMMAND ----------

-- MAGIC %md
-- MAGIC **Descriptive Statistics, Find Mean, Standard Deviation and Mode**
-- MAGIC * Mean is the average of the given data set calculated by dividing the total sum by the number of values in data set.
-- MAGIC * Standard deviation is the average amount of variability in your dataset. 
-- MAGIC * Mode of a data set is the value that appears most frequently in a series of data.

-- COMMAND ----------

SELECT Avg(Price) AS Mean
FROM raw_sales_csv

-- COMMAND ----------

SELECT Price AS Mode
FROM   raw_sales_csv
GROUP  BY Price
ORDER  BY COUNT(*) DESC

-- COMMAND ----------

SELECT  STDDEV(Price) as Price_StandardDeviation  
FROM raw_sales_csv;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC The correlation is a statistical measure that shows how closely related are two sets of values.
-- MAGIC Pearson’s Formula looks like this:
-- MAGIC  ![test_image](/files/tables/pearson_coefficient.png)

-- COMMAND ----------

SELECT CORR (Price , Postcode)
FROM raw_sales_csv 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #Ask and Answer Questions about the dataset

-- COMMAND ----------

-- MAGIC %md
-- MAGIC **Which date corresponds to the highest number of sales?**
-- MAGIC Lets view by top 10

-- COMMAND ----------

SELECT datesold AS date, COUNT(*) AS number_of_sales
FROM raw_sales_csv
GROUP BY datesold
ORDER BY number_of_sales DESC
LIMIT 10

-- COMMAND ----------

-- MAGIC %md
-- MAGIC **Find out the postcode with the highest average price per sale?**

-- COMMAND ----------

SELECT Postcode, AVG(Price) AS avg_price
FROM raw_sales_csv
GROUP BY postcode
ORDER BY AVG(price) DESC
LIMIT 10

-- COMMAND ----------

-- MAGIC %md
-- MAGIC **Which year witnessed the lowest number of sales?**

-- COMMAND ----------

SELECT  YEAR(datesold) AS year, COUNT(*) AS number_of_sales
FROM raw_sales_csv
GROUP BY YEAR(datesold)
ORDER BY number_of_sales ASC


-- COMMAND ----------



-- COMMAND ----------

-- MAGIC %md
-- MAGIC **Use the window function to deduce the top six postcodes by year's price.**

-- COMMAND ----------

SELECT
  postcode,
  price,
  extract(YEAR FROM datesold) year,
  first_value(postcode) over (partition by extract(YEAR FROM datesold) order by price desc) as TOP_POSTCODE
FROM raw_sales_csv
ORDER BY extract(Year FROM datesold);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #Inferences and Conclusions
-- MAGIC My analysis of House property sales concludes with the following points:
-- MAGIC 1. The highest number of sales was made october 28, 2018 at 50 sales.
-- MAGIC 2. The postcode with the highest average price per sales is 2618 with average price of over 1 million.
-- MAGIC 3. The year 2007 witnesed the lowest sales at 147 sales.
