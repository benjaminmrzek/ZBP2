--hiearhièno grupiranje
CREATE TABLE Sales ( Country varchar(50), Region varchar(50), Sales int );
INSERT INTO sales VALUES (N'Canada', N'Alberta', 100);
INSERT INTO sales VALUES (N'Canada', N'British Columbia', 200);
INSERT INTO sales VALUES (N'Canada', N'British Columbia', 300);
INSERT INTO sales VALUES (N'United States', N'Montana', 100);select country, region, sum(sales)from salesgroup by country, regionselect country, region, sum(sales) from salesgroup by rollup(country, region);--group by rollup(col1,col2,col3,col4)--col1,col2,col3,col4--col1,col2,col3,null--col1,col2,null,null--col1,null,null,null--null,null,null,nullselect country, region, sum(sales) from salesgroup by cube(country, region);--cube (a,b)--a,b--null,b--a,null--null,nullselect country, sum(sales)from salesgroup by grouping sets (Country,());select country, region, sum(sales) as skupaj, GROUPING_ID(country) as IDc, GROUPING_ID(region) as IDrfrom salesgroup by rollup(country, region);select iif(GROUPING_ID(country) = 1 and GROUPING_ID(region) = 1, 'Vse skupaj',iif(GROUPING_ID(region) = 1,'Skupaj '+country, region)) as Opis,sum(Sales) as Znesekfrom Salesgroup by rollup(country,region);