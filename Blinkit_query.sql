# ALL DATA:
select * from BlinkIt_data

# NO OF ITEMS:
select count(*) from BlinkIt_data

# Update Query:
UPDATE BlinkIt_data
SET Item_Fat_Content = 
CASE
WHEN Item_Fat_Content IN ('LF','low fat') THEN 'Low Fat'
WHEN Item_Fat_Content = 'reg' THEN 'Regular'
ELSE Item_Fat_Content
END

# Distinct count:
SELECT DISTINCT(Item_Fat_Content) from BlinkIt_data

# TOTAL SALES:
select sum(Total_Sales)  as TotalSales from BlinkIt_data

# TOTAL SALES In Million:
select cast(sum(Total_Sales)/1000000 AS Decimal(10,2))  as Total_Sales_Million from BlinkIt_data

# AVERAGE SALES:
select cast(AVG(Total_Sales)as INT) as Avg_Total_Sales from BlinkIt_data


select cast(sum(Total_Sales)/1000000 AS Decimal(10,2))  as Total_Sales_Million from BlinkIt_data where Outlet_Establishment_Year = 2022

select cast(AVG(Total_Sales) as Decimal (10,1)) as Avg_Total_Sales from BlinkIt_data where Outlet_Establishment_Year = 2022

select count(*) as No_of_Items from BlinkIt_data where Outlet_Establishment_Year = 2022

# AVG RATING:
select Cast(AVG(Rating) as DECIMAL(10,2)) AS Avg_Rating from BlinkIt_data

# Total Sales by Fat Content:
select Item_Fat_Content, cast(sum(Total_Sales) as DECIMAL(10,2)) AS Total_Sales
from BlinkIt_data
Group by Item_Fat_Content
order by Total_Sales DESC

select Item_Fat_Content, cast(sum(Total_Sales) as DECIMAL(10,2)) AS Total_Sales,
                         cast(AVG(Total_Sales) as Decimal (10,1)) as Avg_Total_Sales,
						 count(*) as No_of_Items
from BlinkIt_data
Group by Item_Fat_Content
order by Total_Sales DESC


select Item_Fat_Content, cast(sum(Total_Sales) as DECIMAL(10,2)) AS Total_Sales,
                         cast(AVG(Total_Sales) as Decimal (10,1)) as Avg_Total_Sales,
						 count(*) as No_of_Items
from BlinkIt_data WHERE Outlet_Establishment_Year = 2020
Group by Item_Fat_Content
order by Total_Sales DESC


select Item_Fat_Content, 
                    cast(sum(Total_Sales)/1000 as DECIMAL(10,2)) AS Total_Sales_Thousands,
                    cast(AVG(Total_Sales) as Decimal (10,1)) as Avg_Total_Sales,
				    count(*) as No_of_Items,
					Cast(AVG(Rating) as DECIMAL(10,2)) AS Avg_Rating
from BlinkIt_data 
Group by Item_Fat_Content


select Item_Type,
                    cast(sum(Total_Sales)/1000 as DECIMAL(10,2)) AS Total_Sales,
                    cast(AVG(Total_Sales) as Decimal (10,1)) as Avg_Total_Sales,
				    count(*) as No_of_Items,
					Cast(AVG(Rating) as DECIMAL(10,2)) AS Avg_Rating
from BlinkIt_data 
Group by Item_Type
Order by Total_Sales DESC

# Top 5 Item Sells:
select TOP 5 Item_Type,
                    cast(sum(Total_Sales)/1000 as DECIMAL(10,2)) AS Total_Sales,
                    cast(AVG(Total_Sales) as Decimal (10,1)) as Avg_Total_Sales,
				    count(*) as No_of_Items,
					Cast(AVG(Rating) as DECIMAL(10,2)) AS Avg_Rating
from BlinkIt_data 
Group by Item_Type
Order by Total_Sales DESC


# Sales by Outlet Location & Item Fat Content:
select Outlet_Location_Type, Item_Fat_Content,
                    cast(sum(Total_Sales)/1000 as DECIMAL(10,2)) AS Total_Sales,
                    cast(AVG(Total_Sales) as Decimal (10,1)) as Avg_Total_Sales,
				    count(*) as No_of_Items,
					Cast(AVG(Rating) as DECIMAL(10,2)) AS Avg_Rating
from BlinkIt_data 
Group by Outlet_Location_Type, Item_Fat_Content
Order by Total_Sales DESC


# Fat Content by Outlet for Total Sales:
SELECT Outlet_Location_Type,
             ISNULL([Low Fat],0) as Low_Fat,
			 ISNULL([Regular],0)as Regular
From
( 
SELECT Outlet_Location_Type, Item_Fat_Content,
        CAST(SUM(Total_Sales) AS Decimal(10,2)) AS Total_Sales
		FROM BlinkIt_data
		Group by Outlet_Location_Type, Item_Fat_Content
) AS SourceTable
PIVOT
(
   SUM(Total_Sales)
   FOR Item_Fat_Content IN ([Low Fat],[Regular])
) AS PivotTable
ORDER BY Outlet_Location_Type;


# Total Sales by Outlet Establishment:
select Outlet_Establishment_Year,
                    cast(sum(Total_Sales)/1000 as DECIMAL(10,2)) AS Total_Sales,
                    cast(AVG(Total_Sales) as Decimal (10,2)) as Avg_Total_Sales,
				    count(*) as No_of_Items,
					Cast(AVG(Rating) as DECIMAL(10,2)) AS Avg_Rating
from BlinkIt_data 
Group by Outlet_Establishment_Year
Order by Outlet_Establishment_Year 


# Percentage of Sales by Outlet Size:
SELECT 
    Outlet_Size, 
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM BlinkIt_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;


# Sales by Outlet Location:
SELECT 
    Outlet_Location_Type, 
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
	count(*) as No_of_Items,
	cast(AVG(Total_Sales) as Decimal (10,2)) as Avg_Total_Sales,
    CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM BlinkIt_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;


# All Metrics by Outlet Type:
SELECT 
    Outlet_Type, 
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
	count(*) as No_of_Items,
	cast(AVG(Total_Sales) as Decimal (10,2)) as Avg_Total_Sales,
    CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM BlinkIt_data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;
  


