create database insurace;
use insurace;
select * from brokerage;
select * from fees;
select * from invoice;
select * from meeting;
select * from opportunity;
select * from individual budgets;

-- 1.No of Invoice by Accnt Exec
SELECT 'Account Executive', COUNT(invoice_number) AS number_of_invoices
FROM invoice
GROUP BY 'Account Executive';

-- 2.Yearly Meeting Count
SELECT YEAR(meeting_date) AS year, COUNT(*) AS meeting_count
FROM meeting
GROUP BY YEAR(meeting_date)
ORDER BY year;

-- 3.1.1Cross Sell--Target,Achive,new
-- 3.2 New-Target,Achive,new
-- 3.3Renewal-Target, Achive,new

SELECT * FROM brokerage;
SELECT * FROM invoice;
SELECT * FROM fees;

SELECT distinct income_class, round(sum(amount),2) FROM brokerage GROUP BY 1;
SELECT distinct income_class, sum(amount) FROM invoice GROUP BY 1;
SELECT distinct income_class, sum(amount) FROM fees GROUP BY 1;

CREATE TABLE Budget (income_class VARCHAR(50), budget DECIMAL(18, 2));
INSERT INTO Budget (income_class,budget) VALUES ("New",19673793),("Cross sell", 20083111),("Renewal", 12319455);
SELECT * FROM budget;

## ACHIEVEMENT
CREATE TABLE achievement (
    income_class VARCHAR(50),
    sum_of_amount DECIMAL(20,2)
);

INSERT INTO achievement (income_class, sum_of_amount)
SELECT income_class, ROUND(SUM(amount), 2) AS total_amount
FROM (
    SELECT income_class, amount FROM brokerage
    UNION ALL
    SELECT income_class, amount FROM fees
) combined
GROUP BY income_class;

SELECT * FROM achievement;

-- Placed Achievement Percentage
SELECT 
	a.income_class, a.sum_of_amount AS achievement, 
    b.budget AS budget,
	CONCAT(ROUND((a.sum_of_amount / b.budget) * 100, 2),"%") AS placed_achievement_percentage
FROM achievement a
JOIN budget b
ON a.income_class = b.income_class;

-- Invoice Achievement Percentage
SELECT 
    a.income_class,
    SUM(a.amount) AS invoice,
    b.budget AS budget,
    CONCAT(ROUND((SUM(a.amount) / b.budget) * 100, 2), "%") AS invoice_achievement_percentage
FROM invoice a
JOIN budget b ON a.income_class = b.income_class
GROUP BY a.income_class, b.budget;


-- 4.Stage Funnel by Revenue
Select stage ,SUM(revenue_amount) AS total_revenue FROM opportunity GROUP BY stage ORDER BY stage;
-- or
Select stage ,SUM(revenue_amount) AS total_revenue FROM opportunity GROUP BY stage ORDER by field(stage,'Qualify Opportunity','Negotiate','Propose');                            
select * from opportunity;


-- 5.No of meeting By Account Exe

SELECT 'account executive', COUNT(meeting_date) AS num_meetings
FROM meeting
GROUP BY 'accountexecutive'
ORDER BY num_meetings DESC;


-- 6.Top Open Opportunity
select distinct * from opportunity limit 10;


## Placed Achievement Percentage
SELECT 
	a.income_class, a.sum_of_amount AS achievement, 
    b.budget AS budget,
	CONCAT(ROUND((a.sum_of_amount / b.budget) * 100, 2),"%") AS placed_achievement_percentage
FROM achievement a
JOIN budget b
ON a.income_class = b.income_class;

## Invoice Achievement Percentage
SELECT 
    a.income_class,
    SUM(a.amount) AS invoice,
    b.budget AS budget,
    CONCAT(ROUND((SUM(a.amount) / b.budget) * 100, 2), "%") AS invoice_achievement_percentage
FROM invoice a
JOIN budget b ON a.income_class = b.income_class
GROUP BY a.income_class, b.budget;
