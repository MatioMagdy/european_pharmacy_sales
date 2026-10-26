use pharmacy_db;
/*we import data from csv files
testing that data imported correctly as no of rows is identicaly like excel files*/
select count(*) as FactSalesTotalRows from factsales
union all 
select count(*) as dimDateTotalRows from dimdate
union all 
select count(*) as dimProductTotalRows from dimproduct
union all 
select count(*) as dimpharmacyTotalRows from dimpharmacy;
#total revnue,total costs,total profit 
select round(sum(`RevenueEUR`),2) as Total_revenue,
 round(sum(`CostEUR`),2) as Total_Cost,
 round(sum(`MarginEUR`),2) as Total_profit,
round((sum(`MarginEUR`)/sum(`RevenueEUR`))*100,2) as profit_margin_precent from factsales;
#top 5 products by profit
select p.ProductName,
p.Category,
sum(f.UnitsSold) as Total_Units_sold,
round(sum(f.RevenueEUR),2) as Total_revenue,
round(sum(f.RevenueEUR-f.CostEUR),2) as Total_profit
from factsales f
join dimproduct p on f.ProductID =  p.ProductID
group by p.ProductName ,p.Category
order by Total_profit desc
limit 5;
#sales& profit by pharmacy and country
select ph.Country,ph.PharmacyName,
count(f.SalesID) as Total_Orders,
round(sum(f.RevenueEUR),2) as Total_revenue,
round(sum(f.RevenueEUR-f.CostEUR),2) as Total_profit
from factsales f
join dimpharmacy ph on f.PharmacyID = ph.PharmacyID
group by ph.Country,ph.PharmacyName
order by Total_revenue desc;
#top 12 months for total profit 
select d.Year,d.MonthName,
round(sum(f.RevenueEUR),2) as Total_revenue,
round(sum(f.RevenueEUR-f.CostEUR),2) as Total_profit
from factsales f
join dimdate d on f.DateKey = d.DateKey 
group by d.Year,d.MonthName
order by Total_profit desc
limit 12;




