# 🛍️ Retail Sales Data Cleaning & Analysis using SQL

A real-world project demonstrating how to clean and analyze raw retail sales data using **structured SQL queries**. This project extracts actionable business insights and prepares the dataset for further analytics or dashboarding.

---

## 🧩 Problem Statement

Retail sales data is often messy — with inconsistencies, duplicate records, incorrect formats, and missing values — making it unreliable for analysis. This project tackles these issues by:

- Cleaning the dataset to make it analysis-ready.
- Running SQL queries to derive meaningful insights.
  
---

## 🎯 Objectives

✅ Clean the raw retail transaction data  
✅ Standardize and correct inconsistent data  
✅ Perform exploratory data analysis (EDA)  
✅ Generate insights on customer behavior, product sales, and trends

---

## 🗃️ Dataset Overview

**Table Name:** `sales`  
**Sample Columns:**
- `transaction_id`
- `customer_id`, `customer_name`, `customer_age`, `gender`
- `product_id`, `product_name`, `product_category`
- `quantity`, `price`
- `payment_mode`
- `time_of_purchase`, `purchase_date`
- `status` (delivered / cancelled / returned)

---

## 🧼 Data Cleaning Performed

- 🔁 Removed duplicate transactions
- 🛠️ Renamed misspelled columns (`quantiy` → `quantity`, `prce` → `price`)
- 🗓️ Converted date strings to `DATE` format
- 🔍 Checked for and handled missing or null values
- 👤 Updated missing customer IDs
- 🧾 Standardized categorical values (`F` → `Female`, `CC` → `Credit Card`)

> All cleaning was done via SQL queries — no external tools or scripting used.

---

## 📊 Exploratory Data Analysis (EDA)

### 🔝 Top Insights Extracted:

| Question | Insight |
|---------|---------|
| 🏆 Which are the top-selling products? | Based on total quantity sold |
| ❌ Which products are most frequently cancelled? | Sorted by cancellation count |
| ⏰ What time of day sees the most purchases? | Morning / Afternoon / Evening trends |
| 💸 Who are the top 5 customers by spending? | Based on total price × quantity |
| 📈 Which product categories drive the most revenue? | Highest grossing categories |
| 🔁 Return & cancellation rates | Percentage by category |
| 💳 Most used payment methods | Count of each type |
| 👥 Age group behavior | Spending across different age brackets |
| 📆 Monthly sales trends | Sales volume over months |
| 🚻 Gender preference by category | Category purchases split by gender |

---

## 📁 Repository Structure

---

## 🛠️ Tools Used

- **MySQL / PostgreSQL**
- SQL functions: `CASE`, `GROUP BY`, `JOIN`, `DATE_FORMAT`, `ROW_NUMBER()`, CTEs
- Clean code formatting and comment-based structure

---


---

## 👨‍💻 Author

**[Syed Rayyan Hussain]**  
Passionate about data transformation, analysis, and solving real-world business problems using SQL and Python.



---

## ✅ How to Use

1. Import the dataset into your SQL database
2. Open `cleaning_and_analysis.sql` in any SQL editor
3. Run the queries section by section (cleaning → analysis)
4. Optionally export output into Excel or Power BI for visualization

---

## 📌 Future Enhancements

- Export cleaned data to CSV or dashboard tools
- Create visual reports using Tableau / Power BI
- Extend analysis with Python or R



