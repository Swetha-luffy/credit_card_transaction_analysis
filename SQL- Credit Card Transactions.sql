
Use credit_card_transaction;
-- Exploratory Analysis 
-- 1. What is the total number of transaction?
	select count(*) from credit_trans;

-- 2.what is the total amount of transaction;
	select sum(amount) from credit_trans;

-- 3.what is the average transaction value;
	select avg(amount) from credit_trans;
    
-- Transaction Distribution
-- 1.How many transaction are there by city;
	select city,count(*) as cnt_transaction
	from credit_trans
	group by city;
    
-- 2.How many transaction are there by card_type;
	select card_type,count(*) as cnt_transaction
	from credit_trans 
	group by card_type;
    
-- 3.How many transaction are there by expense type;
	select exp_type,count(*) as cnt_transaction
	from credit_trans 
	group by exp_type;
    
-- 4.How many transaction are there by gender;
	select gender,count(*) as cnt_transaction
	from credit_trans 
	group by gender;
    
-- 5.How many transaction are there by year;
	select year(transaction_date) as trans_year ,count(*) as cnt_trans
    from credit_trans
    group by year(transaction_date);
    
  --   Top N Analysis

-- 1. What are the top 5 cities with the highest transaction volume?
select city,max(amount) as highest_trans
from credit_trans
group by city
order by highest_trans desc
limit 5;

-- 2. What are the top 5 card types with the highest transaction volume?
select card_type,max(amount) as highest_trans_amount
from credit_trans
group by card_type
order by highest_trans_amount desc
limit 5;

-- 3. What are the top 5 expense types with the highest transaction volume?
select exp_type,max(amount) as highest_trans_amount,count(*) as cnt
from credit_trans
group by exp_type
order by highest_trans_amount desc
limit 5;

-- Transaction Trends
-- 1. What is the daily transaction volume and value?
select dayname(transaction_date) as daily_trans,sum(amount) as trans_amount,count(*) as cnt 
from credit_trans
group by daily_trans;

-- 2. What is the weekly transaction volume and value?
select year(transaction_date) as year1 ,week(transaction_date) as weekly_trans,sum(amount) as trans_amount,count(*) as cnt 
from credit_trans
group by year(transaction_date), weekly_trans
order by year1 asc,weekly_trans asc;


-- 3. What is the monthly transaction volume and value?
select year(transaction_date) as year1 ,monthname(transaction_date) as monthly_trans,sum(amount) as trans_amount,count(*) as cnt 
from credit_trans
group by year(transaction_date), monthly_trans
order by year1 desc,monthly_trans asc;


-- Queries ----------------------------------------------------------------------------------------------------------------------------------
-- 1- write a query to print top 5 cities with highest spends and their percentage contribution of total credit card spends
With totalspend as(
select sum(amount) as total_spend from credit_trans
),
CitySpend as
( select city,sum(amount) as city_spend ,
row_number() over (order by sum(amount) desc ) as rn
 from credit_trans
 group by city )
 
 select city,city_spend,
 (city_spend/(select total_spend  from totalspend))*100 as percent_contribution
from CitySpend 
where rn<=5;

------------------------------------------------------------------------------------------------------------------------------------------
-- 2- write a query to print highest spend month for each year and amount spent in that month for each card type
with highest_spend_month as(
select card_type,year(transaction_date) as spend_year,month(transaction_date) as spend_month,
sum(amount) as total_spend
from credit_trans
GROUP BY card_type,year(transaction_date),month(transaction_date)
)
 select * from (select *, rank() over(partition by card_type order by total_spend desc) as rn
from highest_spend_month) a 
where rn=1;

---------------------------------------------------------------------------------------------------------------------------------------------
-- 3- write a query to print the transaction details(all columns from the table) for each card type when
	-- it reaches a cumulative of 1000000 total spends(We should have 4 rows in the o/p one for each card type)

with cte as (
select *,sum(amount) over (partition by card_type order by transaction_id ,transaction_date ) as total_spend
from credit_trans
order by card_type,total_spend desc)

select * from(select *, rank() over(partition by card_type order by total_spend ) as rn
from cte 
where total_spend>=1000000 )a where rn=1;

-----------------------------------------------------------------------------------------------------------------------------------------
-- 4- write a query to find city which had lowest percentage spend for gold card type
select city,
(sum(amount)/(select sum(amount) from credit_trans where card_type="Gold"))*100 as percentage_spend
from credit_trans
where card_type="Gold"
group by city
order by percentage_spend asc
limit 1;

-------------------------------------------------------------------------------------------------------------------------------------------
-- 5- write a query to print 3 columns:  city, highest_expense_type , lowest_expense_type (example format : Delhi , bills, Fuel)
WITH CityExpenses AS (
  SELECT 
    City,
    exp_type,
    sum(amount) as total_amount
    from credit_trans
    group by city,exp_type
    ),
    ranking as(
	select *,
    Rank() OVER(PARTITION BY city ORDER BY total_amount DESC) AS HighestRank,
    Rank() OVER(PARTITION BY city ORDER BY total_amount ASC) AS LowestRank
    FROM 
    CityExpenses
)
SELECT 
  City,
  MAX(CASE WHEN HighestRank = 1 THEN exp_type END) AS HighestExpenseType,
  MIN(CASE WHEN LowestRank = 1 THEN exp_type END) AS LowestExpenseType
FROM 
  ranking
GROUP BY 
  City;

---------------------------------------------------------------------------------------------------------------------------------------------
-- 6- write a query to find percentage contribution of spends by females for each expense type
select exp_type,
sum(case when gender="F" then amount else 0 end) as female_spend,
sum(amount) as total_spend,
(sum(case when gender="F" then amount else 0 end)/sum(amount))*100 as percentage_contribution
from credit_trans 
group by exp_type
order by percentage_contribution desc;

--------------------------------------------------------------------------------------------------------------------------------------------
-- 7- which card and expense type combination saw highest month over month growth in Jan-2014
with cte as
(select card_type,exp_type, year(transaction_date) as y,month(transaction_date) as m,sum(amount) as total_spend
from credit_trans
group by card_type,exp_type, year(transaction_date),month(transaction_date)),
cte2 as
(
select *,
lag(total_spend,1) over(partition by card_type,exp_type order by y,m) as prev_month_spent
from cte) 
select *,(total_spend-prev_month_spent)/prev_month_spent*100 as mom_growth
from cte2
where prev_month_spent is not null and y=2014 and m=1
order by mom_growth desc
limit 1;

---------------------------------------------------------------------------------------------------------------------------------------------
-- 8- during weekends which city has highest total spend to total no of transcations ratio 

select city,(sum(amount)/count(*))*0.1  as ratio
from credit_trans
where dayofweek(transaction_date) in (1,7) 
group by city
order by ratio desc
limit 1;


---------------------------------------------------------------------------------------------------------------------------------------------
-- 9- which city took least number of days to reach its 500th transaction after the first transaction in that city
with cte as(
SELECT 
      city,
      transaction_date,
      ROW_NUMBER() OVER(PARTITION BY city ORDER BY transaction_date) AS TransactionNumber
    FROM 
      credit_trans),
      cte2 as(
      SELECT 
  city,
  MIN(transaction_date) AS FirstTransactionDate,
  MIN(CASE WHEN TransactionNumber= 500 THEN transaction_date END) AS FiveHundredthTransactionDate,
  MIN(CASE WHEN TransactionNumber = 500 THEN transaction_date END) - MIN(transaction_date) AS DaysTaken
  from cte
  GROUP BY 
  city
ORDER BY 
  DaysTaken ASC
LIMIT 1)
select city from cte2;



