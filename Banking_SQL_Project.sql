
-- =============================================
-- Project: Bank Customer Transactions & Regulatory Reporting (SQL)
-- =============================================

-- Drop existing tables (for rerun safety)
DROP TABLE IF EXISTS Transactions;
DROP TABLE IF EXISTS Loans;
DROP TABLE IF EXISTS Accounts;
DROP TABLE IF EXISTS Customers;

-- =============================================
-- Step 1: Schema Design
-- =============================================
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    dob DATE,
    address VARCHAR(200),
    join_date DATE
);

CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(20),   -- Savings / Current
    balance DECIMAL(15,2),
    open_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Transactions (
    txn_id INT PRIMARY KEY,
    account_id INT,
    txn_date DATE,
    txn_type VARCHAR(20),       -- Deposit / Withdrawal / Transfer
    amount DECIMAL(15,2),
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

CREATE TABLE Loans (
    loan_id INT PRIMARY KEY,
    customer_id INT,
    loan_amount DECIMAL(15,2),
    loan_type VARCHAR(50),      -- Home, Personal, Car
    start_date DATE,
    end_date DATE,
    interest_rate DECIMAL(5,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- =============================================
-- Step 2: Sample Data Inserts
-- =============================================
INSERT INTO Customers VALUES
(1, 'Amit Kumar', '1990-03-12', 'Delhi', '2020-01-10'),
(2, 'Jyoti Sharma', '1992-07-25', 'Mumbai', '2021-05-15'),
(3, 'Rahul Mehta', '1985-11-04', 'Bangalore', '2019-07-22');

INSERT INTO Accounts VALUES
(101, 1, 'Savings', 50000, '2020-01-10'),
(102, 1, 'Current', 200000, '2020-03-01'),
(103, 2, 'Savings', 75000, '2021-05-15'),
(104, 3, 'Savings', 120000, '2019-07-22');

INSERT INTO Transactions VALUES
(1001, 101, '2023-07-01', 'Deposit', 20000),
(1002, 101, '2023-07-05', 'Withdrawal', 15000),
(1003, 102, '2023-07-07', 'Deposit', 50000),
(1004, 103, '2023-07-08', 'Deposit', 25000),
(1005, 104, '2023-07-10', 'Withdrawal', 100000),
(1006, 104, '2023-07-15', 'Deposit', 5000);

INSERT INTO Loans VALUES
(201, 1, 500000, 'Home Loan', '2021-01-01', '2031-01-01', 8.5),
(202, 2, 200000, 'Car Loan', '2022-06-01', '2027-06-01', 9.0),
(203, 3, 300000, 'Personal Loan', '2020-02-01', '2025-02-01', 11.0);

-- =============================================
-- Step 3: Queries for Regulatory Reports
-- =============================================

-- 1. Daily Customer Transaction Summary
CREATE OR REPLACE VIEW daily_transaction_summary AS
SELECT c.name, a.account_id, t.txn_date,
       SUM(CASE WHEN t.txn_type='Deposit' THEN t.amount ELSE 0 END) AS total_deposit,
       SUM(CASE WHEN t.txn_type='Withdrawal' THEN t.amount ELSE 0 END) AS total_withdrawal
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
JOIN Transactions t ON a.account_id = t.account_id
GROUP BY c.name, a.account_id, t.txn_date;

-- 2. High-Value Transactions (AML Report)
CREATE OR REPLACE VIEW high_value_txns AS
SELECT c.name, t.txn_id, t.amount, t.txn_date
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
JOIN Transactions t ON a.account_id = t.account_id
WHERE t.amount > 100000;

-- 3. Loan Repayment Schedule (simplified monthly payment)
CREATE OR REPLACE VIEW loan_repayment_schedule AS
SELECT l.loan_id, c.name, l.loan_amount,
       ROUND(l.loan_amount / (EXTRACT(YEAR FROM AGE(l.end_date, l.start_date))*12), 2) AS monthly_payment
FROM Loans l
JOIN Customers c ON l.customer_id = c.customer_id;

-- 4. Monthly Regulatory Compliance Report
CREATE OR REPLACE VIEW monthly_compliance AS
SELECT DATE_TRUNC('month', t.txn_date) AS month,
       SUM(CASE WHEN t.txn_type='Deposit' THEN t.amount ELSE 0 END) AS total_deposits,
       SUM(CASE WHEN t.txn_type='Withdrawal' THEN t.amount ELSE 0 END) AS total_withdrawals
FROM Transactions t
GROUP BY DATE_TRUNC('month', t.txn_date)
ORDER BY month;

-- 5. Ranking Suspicious Transactions (Window Function)
CREATE OR REPLACE VIEW suspicious_ranking AS
SELECT c.name, t.txn_id, t.amount, t.txn_date,
       RANK() OVER (PARTITION BY c.customer_id ORDER BY t.amount DESC) AS rank_txn
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
JOIN Transactions t ON a.account_id = t.account_id;

-- =============================================
-- End of Script
-- =============================================
