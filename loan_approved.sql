create database bank_loan;
use bank_loan;

select * from l_approved;

alter table l_approved drop myunknowncolumn;

-- View the first 10 records from the table.
select * from l_approved limit 10;

-- Count the total number of loan applications.
select count(*) as total_applicatants from l_approved;

-- List all unique property areas.
select distinct(property_area) from l_approved;

-- Show all applicants who are self-employed and have an income above 5000.
select * from l_approved where self_employed = "yes" and applicantincome > 5000;
select count(*) from l_approved where self_employed = "yes" and applicantincome > 5000;

-- Find the total number of approved loans.
select count(*) as loan_approved from l_approved where loan_status = 'y';

-- Find average loan amount by education level.
select education, round(avg(loanamount),2) from l_approved group by education;

-- Find average total income (Applicant + Coapplicant) by marital status.
select married, round(avg(applicantincome+coapplicantincome),2) as Total_income
from l_approved group by married;

-- Show average loan amount by credit history.
select credit_history, round(avg(loanamount),2) from l_approved group by credit_history;

-- Find total applications and approval rate by gender
select * from l_approved;
select gender, 
	   count(*) as total_applicants,
	   sum(case when loan_status = 'Y' then 1 else 0 end) as approved,
	   round(sum(case when loan_status = 'Y' then 1 else 0 end)/count(*)*100,2) as approved_rate
from l_approved group by gender;

-- Approval rate by property area

-- Show applicants who are graduates, not self-employed, and have loan amount greater than 150.
select * from l_approved where education = 'graduate' and Self_Employed="no" and 
LoanAmount>150;

-- Display approved loans from urban area with good credit history.
select * from l_approved where Property_Area='Urban' and Credit_History= 1 and Loan_Status = 'Y';

-- List top 5 applicants with highest total income.
select *, (ApplicantIncome+CoapplicantIncome) as Total_income
from l_approved order by Total_income desc limit 5;


-- Create column for total income each applicant.
select *, (ApplicantIncome+CoapplicantIncome) as Total_income from l_approved;

-- Classify applicants into income groups (Low, Medium, High) based on applicant income.
select ApplicantIncome from l_approved order by ApplicantIncome desc;

select Loan_ID,
	   ApplicantIncome,
	   case
           when ApplicantIncome<3000 then 'Low income'
           when ApplicantIncome between 3000 and 6000 then 'Medium income'
           else 'High income'
	   end as income_group
from l_approved;

-- Find average loan amount for each income group.
select
	   case
           when ApplicantIncome<3000 then 'Low income'
           when ApplicantIncome between 3000 and 6000 then 'Medium income'
           else 'High income'
	   end as income_group,
       round(avg(LoanAmount),2) as avg_loan
from l_approved group by income_group;

-- Find applicants whose loan amount is greater than the overall average loan amount.
select * from l_approved
where loanAmount  > (select avg(loanAmount) from l_approved);

-- Identify the property area with the highest average total income.
select property_area, avg(applicantincome+coapplicantincome) as avg_income from l_approved  
group by property_area  order by avg_income desc limit 1;

-- List all applicants whose income is above the average income of their education category.

-- Rank applicants based on total income (highest income rank = 1).
select Loan_ID,
	   ApplicantIncome+CoapplicantIncome as Total_income,
	   rank() over (order by (ApplicantIncome+CoapplicantIncome) desc) as Rank_number
from l_approved;

-- Show average loan amount per property area using a window function.

-- Calculate approval rate by education using window function.

-- Compare approval rate by credit history and education level to find which combination performs best.






