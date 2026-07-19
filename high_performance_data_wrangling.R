############################################################
# High-Performance In-Memory Data Wrangling
# Week 2 Project
#
# Student Name : John Doe
# Register Number : 2024001
############################################################

# Load required packages
library(data.table)

# Set seed for reproducibility
set.seed(123)

# Create output directory if it doesn't exist
if (!dir.exists("Output")) {
  dir.create("Output")
}

############################################################
# Part 1 : Generate Dataset
############################################################

cat("\n=== Part 1: Generating Dataset ===\n")

# Generate synthetic dataset with 500,000 records
n_records <- 500000

# Create product catalog
products <- data.table(
  ProductID = paste0("P", sprintf("%04d", 1:50)),
  ProductName = c(
    "Laptop", "Smartphone", "Tablet", "Desktop", "Monitor",
    "Keyboard", "Mouse", "Printer", "Scanner", "Webcam",
    "Headphones", "Speaker", "Microphone", "Camera", "Projector",
    "Smart Watch", "Fitness Band", "TV", "Refrigerator", "Washing Machine",
    "Microwave", "Oven", "Dishwasher", "AC", "Heater",
    "Fan", "Light", "Router", "Switch", "Cable",
    "Battery", "Charger", "Power Bank", "USB Drive", "Hard Drive",
    "SSD", "RAM", "Processor", "Motherboard", "Graphics Card",
    "Sound Card", "Network Card", "Modem", "Access Point", "Extender",
    "Smart Bulb", "Smart Plug", "Camera", "Doorbell", "Lock"
  ),
  Category = c(
    rep("Electronics", 10),
    rep("Accessories", 10),
    rep("Appliances", 10),
    rep("Networking", 10),
    rep("Smart Home", 10)
  ),
  UnitPrice = c(
    runif(10, 300, 1500),
    runif(10, 20, 200),
    runif(10, 100, 800),
    runif(10, 50, 400),
    runif(10, 30, 250)
  )
)

# Create customer base
n_customers <- 10000
customers <- data.table(
  CustomerID = paste0("C", sprintf("%05d", 1:n_customers)),
  CustomerName = paste0("Customer_", 1:n_customers),
  Gender = sample(c("Male", "Female"), n_customers, replace = TRUE),
  Age = sample(18:70, n_customers, replace = TRUE),
  City = sample(
    c("Mumbai", "Delhi", "Bangalore", "Chennai", "Hyderabad",
      "Kolkata", "Pune", "Ahmedabad", "Jaipur", "Lucknow",
      "Chandigarh", "Bhopal", "Indore", "Nagpur", "Surat",
      "Patna", "Vadodara", "Coimbatore", "Visakhapatnam", "Mysore"),
    n_customers, replace = TRUE
  ),
  State = sample(
    c("Maharashtra", "Delhi", "Karnataka", "Tamil Nadu", "Telangana",
      "West Bengal", "Maharashtra", "Gujarat", "Rajasthan", "Uttar Pradesh",
      "Punjab", "Madhya Pradesh", "Madhya Pradesh", "Maharashtra", "Gujarat",
      "Bihar", "Gujarat", "Tamil Nadu", "Andhra Pradesh", "Karnataka"),
    n_customers, replace = TRUE
  )
)

# Generate sales transactions
sales_data <- data.table(
  TransactionID = paste0("TXN", sprintf("%08d", 1:n_records)),
  CustomerID = sample(customers$CustomerID, n_records, replace = TRUE),
  ProductID = sample(products$ProductID, n_records, replace = TRUE),
  Quantity = sample(1:10, n_records, replace = TRUE),
  Discount = round(runif(n_records, 0, 20), 2),
  GST = sample(c(5, 12, 18, 28), n_records, replace = TRUE, prob = c(0.2, 0.4, 0.3, 0.1)),
  PaymentMethod = sample(
    c("Cash", "Card", "UPI", "Net Banking"),
    n_records, replace = TRUE,
    prob = c(0.15, 0.35, 0.30, 0.20)
  ),
  OrderDate = sample(
    seq(as.Date("2023-01-01"), as.Date("2023-12-31"), by = "day"),
    n_records, replace = TRUE
  ),
  SalesPerson = sample(
    paste0("SP", sprintf("%03d", 1:20)),
    n_records, replace = TRUE
  )
)

# Merge with product and customer details
sales_data <- merge(sales_data, products, by = "ProductID")
sales_data <- merge(sales_data, customers, by = "CustomerID")

# Reorder columns for better readability
setcolorder(sales_data, c(
  "TransactionID", "CustomerID", "CustomerName", "Gender", "Age",
  "ProductID", "ProductName", "Category", "Quantity", "UnitPrice",
  "Discount", "GST", "PaymentMethod", "City", "State", "OrderDate", "SalesPerson"
))

# Save dataset
fwrite(sales_data, "sales_transactions.csv")
cat("Dataset generated with", n_records, "records\n")

############################################################
# Part 2 : Import Dataset
############################################################

cat("\n=== Part 2: Import Dataset ===\n")

# Import dataset using fread()
sales_data <- fread("sales_transactions.csv")

############################################################
# Part 3 : Data Cleaning and Preparation
############################################################

cat("\n=== Part 3: Data Cleaning and Preparation ===\n")

# Remove duplicate records
sales_data <- unique(sales_data)
cat("Records after removing duplicates:", nrow(sales_data), "\n")

# Rename columns for consistency
setnames(sales_data, 
         c("Discount", "GST", "PaymentMethod"),
         c("DiscountPercent", "GSTPercent", "Payment_Method"))

# Reorder columns
setcolorder(sales_data, c(
  "TransactionID", "OrderDate", "CustomerID", "CustomerName",
  "Gender", "Age", "ProductID", "ProductName", "Category",
  "Quantity", "UnitPrice", "DiscountPercent", "GSTPercent",
  "Payment_Method", "City", "State", "SalesPerson"
))

# Convert columns to appropriate data types
sales_data[, `:=`(
  TransactionID = as.character(TransactionID),
  CustomerID = as.character(CustomerID),
  ProductID = as.character(ProductID),
  Gender = as.factor(Gender),
  Category = as.factor(Category),
  Payment_Method = as.factor(Payment_Method),
  City = as.factor(City),
  State = as.factor(State),
  OrderDate = as.Date(OrderDate),
  SalesPerson = as.factor(SalesPerson)
)]

############################################################
# Part 4 : Data Manipulation
############################################################

cat("\n=== Part 4: Data Manipulation ===\n")

# Select single column
cat("\nSingle column (CustomerID):\n")
print(sales_data[, .(CustomerID)])

# Select multiple columns
cat("\nMultiple columns (CustomerID, ProductID, Quantity):\n")
print(sales_data[, .(CustomerID, ProductID, Quantity)])

# Filter rows - single condition
cat("\nTransactions with Quantity > 5:\n")
print(sales_data[Quantity > 5])

# Filter rows - multiple conditions
cat("\nTransactions with Quantity > 5 and DiscountPercent > 10:\n")
print(sales_data[Quantity > 5 & DiscountPercent > 10])

# Sort data - ascending
cat("\nData sorted by Quantity (ascending):\n")
print(sales_data[order(Quantity)])

# Sort data - descending
cat("\nData sorted by Quantity (descending):\n")
print(sales_data[order(-Quantity)])

############################################################
# Part 5 : In-place Column Updates (:=)
############################################################

cat("\n=== Part 5: In-place Column Updates ===\n")

# Create new columns using := operator
sales_data[, `:=`(
  Revenue = Quantity * UnitPrice,
  DiscountAmount = (Quantity * UnitPrice) * (DiscountPercent / 100),
  GSTAmount = (Quantity * UnitPrice) * (GSTPercent / 100),
  NetRevenue = (Quantity * UnitPrice) - 
               ((Quantity * UnitPrice) * (DiscountPercent / 100)) + 
               ((Quantity * UnitPrice) * (GSTPercent / 100))
)]

############################################################
# Part 6 : Index Keying
############################################################

cat("\n=== Part 6: Index Keying ===\n")

# Set keys for efficient searching
setkey(sales_data, CustomerID, ProductID)
cat("\nKeys set on: CustomerID, ProductID\n")

############################################################
# Part 7 : Grouping and Aggregation
############################################################

cat("\n=== Part 7: Grouping and Aggregation ===\n")

# Customer-wise Summary
customer_summary <- sales_data[, .(
  TotalOrders = .N,
  TotalRevenue = sum(NetRevenue, na.rm = TRUE),
  AvgRevenue = mean(NetRevenue, na.rm = TRUE)
), by = CustomerID]

cat("\nCustomer-wise Summary (first 10):\n")
print(head(customer_summary, 10))

# Product-wise Summary
product_summary <- sales_data[, .(
  TotalQuantitySold = sum(Quantity, na.rm = TRUE),
  TotalRevenue = sum(NetRevenue, na.rm = TRUE)
), by = ProductID]

cat("\nProduct-wise Summary (first 10):\n")
print(head(product_summary, 10))

# City-wise Summary
city_summary <- sales_data[, .(
  NumberOfTransactions = .N,
  TotalRevenue = sum(NetRevenue, na.rm = TRUE)
), by = City]

cat("\nCity-wise Summary:\n")
print(city_summary)

# Category-wise Summary
category_summary <- sales_data[, .(
  TotalRevenue = sum(NetRevenue, na.rm = TRUE),
  AvgRevenue = mean(NetRevenue, na.rm = TRUE)
), by = Category]

cat("\nCategory-wise Summary:\n")
print(category_summary)

############################################################
# Part 8 : Export Reports
############################################################

cat("\n=== Part 8: Export Reports ===\n")

# Export all reports as CSV files
fwrite(customer_summary, "Output/customer_summary.csv")
cat("Customer summary exported to Output/customer_summary.csv\n")

fwrite(product_summary, "Output/product_summary.csv")
cat("Product summary exported to Output/product_summary.csv\n")

fwrite(city_summary, "Output/city_summary.csv")
cat("City summary exported to Output/city_summary.csv\n")

fwrite(category_summary, "Output/category_summary.csv")
cat("Category summary exported to Output/category_summary.csv\n")

############################################################
# Part 9 : Visualization
############################################################

cat("\n=== Part 9: Visualization ===\n")

# 1. Transactions by City
png("Output/city_transactions.png", width = 800, height = 600)
city_counts <- sales_data[, .N, by = City]
city_counts <- city_counts[order(-N)]
barplot(city_counts$N, 
        names.arg = city_counts$City,
        main = "Transactions by City",
        xlab = "City",
        ylab = "Number of Transactions",
        col = rainbow(nrow(city_counts)),
        las = 2,
        cex.names = 0.7)
dev.off()
cat("City transactions plot saved to Output/city_transactions.png\n")

# 2. Revenue by Product Category
png("Output/category_revenue.png", width = 800, height = 600)
category_rev <- category_summary[order(-TotalRevenue)]
barplot(category_rev$TotalRevenue / 1000000,
        names.arg = category_rev$Category,
        main = "Revenue by Product Category (in Millions)",
        xlab = "Category",
        ylab = "Total Revenue ($ Millions)",
        col = rainbow(nrow(category_rev)),
        las = 2)
dev.off()
cat("Category revenue plot saved to Output/category_revenue.png\n")

# 3. Top 20 Customers
png("Output/top_customers.png", width = 1000, height = 600)
top_cust <- customer_summary[order(-TotalRevenue)][1:20]
barplot(top_cust$TotalRevenue / 1000,
        names.arg = top_cust$CustomerID,
        main = "Top 20 Customers by Revenue",
        xlab = "Customer ID",
        ylab = "Total Revenue ($ Thousands)",
        col = rainbow(20),
        las = 2,
        cex.names = 0.7)
dev.off()
cat("Top customers plot saved to Output/top_customers.png\n")

# 4. Payment Method Distribution
png("Output/payment_distribution.png", width = 800, height = 600)
payment_counts <- sales_data[, .N, by = Payment_Method]
pie(payment_counts$N,
    labels = paste0(payment_counts$Payment_Method, "\n(", 
                   round(payment_counts$N / sum(payment_counts$N) * 100, 1), "%)"),
    main = "Payment Method Distribution",
    col = c("#FF6B6B", "#4ECDC4", "#45B7D1", "#96CEB4"),
    cex = 1.2)
dev.off()
cat("Payment distribution plot saved to Output/payment_distribution.png\n")

############################################################
# End of Program
############################################################

cat("\n=== Project Completed Successfully ===\n")
cat("All outputs saved to the 'Output' folder.\n")