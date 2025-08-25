
# 🏦 Banking SQL Project: Customer Transactions & Regulatory Reporting

This project simulates a **Banking Data Analysis & Regulatory Reporting System** using SQL.  
It is designed to showcase SQL skills (DDL, DML, Joins, Window Functions, Views, Aggregations) in the **Banking + Compliance domain**, which is highly relevant for roles like *Data Analyst (SQL) at Barclays*.

---

## 📌 Project Overview
- Designed **database schema** for Customers, Accounts, Transactions, and Loans.
- Inserted **sample banking data**.
- Implemented **SQL queries & reports** for regulatory and compliance needs:
  - Daily Customer Transaction Summaries
  - High-Value Transaction Reports (AML)
  - Loan Repayment Schedules
  - Monthly Compliance Reports
  - Suspicious Transaction Ranking (Window Functions)
- Automated reports using **Views**.

---

## 📂 Database Schema

**Tables:**  
- Customers(`customer_id`, `name`, `dob`, `address`, `join_date`)  
- Accounts(`account_id`, `customer_id`, `account_type`, `balance`, `open_date`)  
- Transactions(`txn_id`, `account_id`, `txn_date`, `txn_type`, `amount`)  
- Loans(`loan_id`, `customer_id`, `loan_amount`, `loan_type`, `start_date`, `end_date`, `interest_rate`)  

---

## 📝 Sample Data
### Customers
| customer_id | name         | dob        | address   | join_date  |
|-------------|--------------|------------|-----------|------------|
| 1           | Amit Kumar   | 1990-03-12 | Delhi     | 2020-01-10 |
| 2           | Jyoti Sharma | 1992-07-25 | Mumbai    | 2021-05-15 |
| 3           | Rahul Mehta  | 1985-11-04 | Bangalore | 2019-07-22 |

### Transactions
| txn_id | account_id | txn_date   | txn_type   | amount   |
|--------|------------|------------|------------|----------|
| 1001   | 101        | 2023-07-01 | Deposit    | 20000.00 |
| 1002   | 101        | 2023-07-05 | Withdrawal | 15000.00 |
| 1003   | 102        | 2023-07-07 | Deposit    | 50000.00 |
| 1004   | 103        | 2023-07-08 | Deposit    | 25000.00 |
| 1005   | 104        | 2023-07-10 | Withdrawal |100000.00 |
| 1006   | 104        | 2023-07-15 | Deposit    | 5000.00  |

---

## 📊 Queries & Expected Outputs

### 1️⃣ Daily Customer Transaction Summary
```sql
SELECT * FROM daily_transaction_summary WHERE txn_date='2023-07-05';
```
| name        | account_id | txn_date   | total_deposit | total_withdrawal |
|-------------|------------|------------|---------------|------------------|
| Amit Kumar  | 101        | 2023-07-05 | 0             | 15000            |

---

### 2️⃣ High-Value Transactions (> 100000)
```sql
SELECT * FROM high_value_txns;
```
| name        | txn_id | amount   | txn_date   |
|-------------|--------|----------|------------|
| Rahul Mehta | 1005   |100000.00 | 2023-07-10 |

---

### 3️⃣ Loan Repayment Schedule
```sql
SELECT * FROM loan_repayment_schedule;
```
| loan_id | name         | loan_amount | monthly_payment |
|---------|--------------|-------------|-----------------|
| 201     | Amit Kumar   | 500000.00   | 4166.67         |
| 202     | Jyoti Sharma | 200000.00   | 3333.33         |
| 203     | Rahul Mehta  | 300000.00   | 5000.00         |

---

### 4️⃣ Monthly Regulatory Compliance Report
```sql
SELECT * FROM monthly_compliance;
```
| month      | total_deposits | total_withdrawals |
|------------|----------------|-------------------|
| 2023-07-01 | 100000         | 115000            |

---

### 5️⃣ Suspicious Transactions Ranking (Window Function)
```sql
SELECT * FROM suspicious_ranking;
```
| name        | txn_id | amount   | txn_date   | rank_txn |
|-------------|--------|----------|------------|----------|
| Amit Kumar  | 1003   | 50000.00 | 2023-07-07 | 1        |
| Amit Kumar  | 1001   | 20000.00 | 2023-07-01 | 2        |
| Amit Kumar  | 1002   | 15000.00 | 2023-07-05 | 3        |
| Jyoti Sharma| 1004   | 25000.00 | 2023-07-08 | 1        |
| Rahul Mehta | 1005   |100000.00 | 2023-07-10 | 1        |
| Rahul Mehta | 1006   |  5000.00 | 2023-07-15 | 2        |

---

## 🚀 How to Run
1. Download the SQL script: `Banking_SQL_Project.sql`
2. Run it on your preferred database (PostgreSQL/MySQL).
3. Explore the `Views` created:
   - `daily_transaction_summary`
   - `high_value_txns`
   - `loan_repayment_schedule`
   - `monthly_compliance`
   - `suspicious_ranking`

---

## 🎯 Key Learnings
- Hands-on SQL practice for **Banking & Compliance** scenarios.
- Use of **Joins, Aggregations, Window Functions, Views**.
- Practical project to showcase in **resume/GitHub** for Data Analyst interviews.

---
