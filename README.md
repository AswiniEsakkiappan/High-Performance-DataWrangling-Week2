# High-Performance In-Memory Data Wrangling on Terabyte-Scale Arrays via data.table and Pointer-Level References

## Project Overview

This project demonstrates high-performance data wrangling using the data.table package in R to process and analyze large-scale transactional datasets with minimal memory consumption. The implementation leverages data.table's reference semantics (pointer-level references) for in-place data manipulation, significantly improving execution speed and memory efficiency.

## Dataset Generated

Generated a synthetic enterprise sales transaction dataset containing 500,000 records.

| Column | Description |
|--------|-------------|
| TransactionID | Unique transaction identifier |
| CustomerID | Customer identifier |
| CustomerName | Customer name |
| Gender | Male/Female |
| Age | Customer age |
| ProductID | Product identifier |
| ProductName | Product purchased |
| Category | Product category |
| Quantity | Number of products purchased |
| UnitPrice | Price per unit |
| Discount | Discount percentage |
| GST | GST percentage |
| PaymentMethod | Cash/Card/UPI/Net Banking |
| City | Customer city |
| State | Customer state |
| OrderDate | Date of purchase |
| SalesPerson | Sales executive |

## Tasks Completed

### Task 1: Generate Dataset
Generated 500,000 synthetic transaction records and saved as sales_transactions.csv. Displayed dataset dimensions: 500,000 rows × 17 columns.

### Task 2: Load and Explore Dataset
Imported dataset using fread() and performed exploratory analysis. Found 0 missing values, 0 duplicate records, 10,000 unique customers, 50 unique products, and 20 unique cities.

### Task 3: Data Cleaning and Preparation
Removed duplicate records, renamed columns for consistency, reordered columns, and converted columns to appropriate data types.

### Task 4: High-Speed Data Manipulation
Selected single and multiple columns, filtered rows with conditions, sorted data in ascending and descending order, identified Top 20 expensive products and Top 20 highest quantity transactions.

### Task 5: In-Place Column Updates (:=)
Created new columns using := operator: Revenue = Quantity × UnitPrice, DiscountAmount = Revenue × Discount / 100, GSTAmount = Revenue × GST / 100, NetRevenue = Revenue - DiscountAmount + GSTAmount.

### Task 6: Index Keying (setkey())
Created indexes on CustomerID and ProductID. Achieved 15x faster search performance with indexing.

### Task 7: Grouping and Aggregation
Generated Customer-wise Summary, Product-wise Summary, City-wise Summary, and Category-wise Summary.

### Task 8: Business Analysis
Answered 8 business questions about revenue, sales, customers, payment methods, and categories.

### Task 9: Export Reports
Exported customer_summary.csv, product_summary.csv, city_summary.csv, and category_summary.csv.

### Task 10: Visualization
Generated Transactions by City (Bar Chart), Revenue by Product Category (Bar Chart), Top 20 Customers (Bar Chart), and Payment Method Distribution (Pie Chart).

## Repository Structure
High-Performance-DataWrangling-Week2/
│
├── README.md
├── Week2_Report.pdf
├── sales_transactions.csv.zip
├── high_performance_data_wrangling.R
│
└── Output/
├── customer_summary.csv
├── product_summary.csv
├── city_summary.csv
├── category_summary.csv
├── city_transactions.png
├── category_revenue.png
├── top_customers.png
└── payment_distribution.png


## Steps to Run the Program

```r
# Install required package
install.packages("data.table")

# Set working directory
setwd("D:/High-Performance-DataWrangling-Week2")

# Run the script
source("high_performance_data_wrangling.R")
```

## Results

### Customer-wise Summary (Top 10)

| CustomerID | Total Orders | Total Revenue | Avg Revenue |
|------------|--------------|---------------|-------------|
| C00001 | 40 | 109,349.65 | 2,733.74 |
| C00002 | 40 | 100,636.31 | 2,515.91 |
| C00003 | 48 | 133,030.39 | 2,771.47 |
| C00004 | 42 | 143,071.11 | 3,406.46 |
| C00005 | 41 | 112,316.10 | 2,739.42 |
| C00006 | 57 | 118,785.40 | 2,083.95 |
| C00007 | 57 | 160,204.66 | 2,810.61 |
| C00008 | 46 | 88,942.00 | 1,933.52 |
| C00009 | 64 | 155,712.09 | 2,433.00 |
| C00010 | 56 | 88,163.51 | 1,574.35 |

### Product-wise Summary (Top 10)

| ProductID | Total Quantity Sold | Total Revenue |
|-----------|---------------------|---------------|
| P0005 | 54,437 | 80,771,220 |
| P0004 | 55,003 | 77,896,880 |
| P0008 | 54,512 | 77,647,190 |
| P0002 | 55,661 | 72,132,636 |
| P0009 | 53,667 | 53,735,134 |
| P0003 | 55,004 | 45,230,854 |
| P0001 | 55,525 | 37,288,798 |
| P0011 | 55,986 | 11,173,119 |
| P0016 | 55,854 | 10,566,795 |
| P0015 | 54,979 | 2,207,793 |

### City-wise Summary (Top 10)

| City | Number of Transactions | Total Revenue |
|------|----------------------|---------------|
| Delhi | 26,914 | 61,019,443 |
| Chandigarh | 26,926 | 60,927,556 |
| Chennai | 26,839 | 60,598,491 |
| Indore | 26,296 | 59,467,393 |
| Hyderabad | 25,572 | 58,138,862 |
| Nagpur | 25,354 | 57,786,409 |
| Coimbatore | 25,473 | 57,856,345 |
| Mumbai | 25,794 | 58,404,311 |
| Visakhapatnam | 25,427 | 56,885,325 |
| Ahmedabad | 25,145 | 56,654,012 |

### Category-wise Summary

| Category | Total Revenue | Avg Revenue |
|----------|---------------|-------------|
| Electronics | 567,126,089 | 5,673.19 |
| Appliances | 303,740,862 | 3,035.34 |
| Networking | 136,432,838 | 1,361.73 |
| Accessories | 65,289,122 | 654.94 |
| Smart Home | 60,484,757 | 604.32 |

## Business Questions Answered

**Q1: Which city generated the highest revenue?**
Delhi with $61,019,443

**Q2: Which product generated maximum sales?**
P0005 (Monitor) with $80,771,220

**Q3: Which customer placed the highest number of orders?**
Customer C00009 with 64 orders

**Q4: Which payment method is used most frequently?**
Card payments

**Q5: What is the average transaction value?**
Calculated during runtime

**Q6: Which category generated maximum revenue?**
Electronics with $567,126,089

**Q7: Top 20 customers by revenue**
See Output/top_customers.png

**Q8: Top 20 products by quantity sold**
See Output/product_summary.csv

## Visualizations Generated

**Transactions by City**
Bar chart showing transaction distribution across 20 cities. Delhi and Chandigarh have the highest transaction volumes.

**Revenue by Product Category**
Bar chart showing revenue breakdown by product categories. Electronics generates 56.7% of total revenue.

**Top 20 Customers by Revenue**
Bar chart showing top revenue-generating customers. Customer C00007 leads with $160,204.66 in revenue.

**Payment Method Distribution**
Pie chart showing distribution of payment methods. Card payments are the most frequently used method.

## Performance Achievements

| Operation | Performance |
|-----------|-------------|
| Data Generation | 2-3 minutes |
| Data Import (fread) | < 1 second |
| Data Cleaning | < 1 second |
| Column Updates (:=) | < 1 second |
| Indexing (setkey) | < 1 second |
| Search (with index) | 15x faster |
| Grouping/Aggregation | < 2 seconds |
| Export Reports | < 1 second |

## Key Business Insights

- Electronics dominates with 56.7% of total revenue
- Appliances second with 30.4% of total revenue
- Delhi is the top-performing city
- Card payments are most preferred payment method
- Monitors and Desktops are top revenue generators

## Learning Outcomes

- Understanding of data.table package and its high-performance capabilities
- Knowledge of pointer-level references and in-place updates using := operator
- Experience with large-scale data manipulation (500,000+ records)
- Understanding of indexing for efficient searching using setkey()
- Ability to generate business reports and visualizations from large datasets
- Practical experience with data.table's reference semantics

## Files Generated

**Main Files:**
- sales_transactions.csv.zip - Main dataset (500,000 records compressed)

**Output Folder:**
- customer_summary.csv - Customer-wise summary
- product_summary.csv - Product-wise summary
- city_summary.csv - City-wise summary
- category_summary.csv - Category-wise summary
- city_transactions.png - Transactions by city visualization
- category_revenue.png - Revenue by category visualization
- top_customers.png - Top 20 customers visualization
- payment_distribution.png - Payment method distribution


## City_transactions.png - Transactions by city visualization

<img width="800" height="600" alt="city_transactions" src="https://github.com/user-attachments/assets/c8e4ad09-e09e-45d2-8830-2997d9d718fc" />

## Category_revenue.png - Revenue by category visualization

<img width="800" height="600" alt="category_revenue" src="https://github.com/user-attachments/assets/3ca65b7a-25bd-4b74-8a9b-b197ec1120e8" />

## Top_customers.png - Top 20 customers visualization

<img width="1000" height="600" alt="top_customers" src="https://github.com/user-attachments/assets/b557df8a-808a-48b6-8689-a68d48ed5ff3" />

## Payment_distribution.png - Payment method distribution

<img width="800" height="600" alt="payment_distribution" src="https://github.com/user-attachments/assets/eaa78312-4776-4e4b-83f0-a39766633cec" />


## Conclusion

This project successfully demonstrated high-performance data wrangling using the data.table package in R. The implementation handled 500,000 transaction records efficiently with minimal memory consumption using reference semantics. Key achievements include processing 500,000 records efficiently, using pointer-level references for in-place updates, achieving 15x performance improvement with indexing, generating comprehensive business reports, and creating professional visualizations.
