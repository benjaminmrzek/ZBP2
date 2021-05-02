--in / not in, exists / not exists

-- cross apply / outer apply
	SELECT
		CustomerID,
		FirstName,
		LastName
	FROM SalesLT.Customer
	WHERE CustomerID = 1;

select * from dbo.ufnGetCustomerInformation(1);

-- izpiši podatke o raèunih, skupaj s podatki o kupcih
select soh.SalesOrderID, soh.CustomerID from SalesLT.SalesOrderHeader soh
cross apply [dbo].[ufnGetCustomerInformation](soh.CustomerID) ci;

-- izpiši id raèuna in max ceno na tem raèunu iz sod
create function SalesLT.udfMaxUnitPrice
(
@id int
)
returns table
as
return
(select salesorderid, max(unitprice) as MaxCena
from SalesLT.SalesOrderDetail
where SalesOrderID = @id
group by SalesOrderID);

-- klic funkcije
select * from [SalesLT].[udfMaxUnitPrice](71776);

select soh.SalesOrderID, soh.DueDate, m.MaxCena from SalesLT.SalesOrderHeader as soh
cross apply [SalesLT].[udfMaxUnitPrice](soh.SalesOrderID) m;

-- ustvarjanje pogleda
create view Nov as
select * from SalesLT.Address;

declare @mojŠtevec int;
declare @lastname nvarchar(30), @ime nvarchar(20), @država nchar(3)
set @ime = N'Amy' -- N uporabljamo za utf8
select LastName, FirstName from SalesLT.Customer
where FirstName = @ime

-- tabela kot spremenljivka
declare @varProdukti as table (id int, ime nvarchar(50))
select * from @varProdukti;

-- zaèasna tabela (v okviru enega query-a z enim #, z dvemi ## pa lahko tudi v drugih query-ih uporabljamo)(v eni seji)
create table #temp (id int, ime nvarchar(50))
insert into #temp
select productid, name from SalesLT.Product
select * from #temp;
-- globalna zaèasna tabela (v veè sejah)
create table ##temp1 (id int, ime nvarchar(50))
insert into ##temp1
select productid, name from SalesLT.Product
select * from ##temp1;

-- izpeljane tabele derived tables
select orderyear, count(distinct customerid) as štkupcev from
(select year(orderdate) as orderyear, customerid from SalesLT.SalesOrderHeader)
as izpeljana_tabela
group by orderyear;
-- select * from izpeljana_tabela; (ne moremo ker velja samo za tisto poizvedbo)

select orderyear, count(distinct štkupcev) from
(select year(orderdate) as orderyear, customerid from SalesLT.SalesOrderHeader)
as izpeljana_tabela(orderyear,štkupcev)
group by orderyear;

--dodaj izpeljano tabelo nova
select kupec, count(raèuni)
from (select firstname+' '+lastname+' 'companyname, [SalesOrderID]
from SalesLT.SalesOrderHeader soh
inner join SalesLT.Customer c
on c.CustomerID = soh.CustomerID) as nova(kupec,raèuni)
group by kupec;

-- CTE-ji common table expression 
-- izpeljana
select leto, count(distinct kupecid) as štKupcev
from (select year(orderdate), customerid from SalesLT.SalesOrderHeader) as
izpeljana(leto,kupecid)
group by leto;
-- ista s CTE
with nova(leto,kupecid)
as (select year(orderdate), customerid from SalesLT.SalesOrderHeader)
select leto, count(distinct kupecid) as štKupcev from nova
group by leto;
-- samo za en naslednji select, update, insert select * from nova
CREATE TABLE MyEmployees
(
EmployeeID smallint NOT NULL,
FirstName nvarchar(30) NOT NULL,
LastName nvarchar(40) NOT NULL,
Title nvarchar(50) NOT NULL,
DeptID smallint NOT NULL,
ManagerID int NULL,
CONSTRAINT PK_EmployeeID PRIMARY KEY CLUSTERED (EmployeeID ASC)
);
-- Napolni tabelo z vrednostmi. (N pred vrednostmi je da uporablja UTF8)
INSERT INTO dbo.MyEmployees VALUES
(1, N'Ken', N'Sánchez', N'Chief Executive Officer',16,NULL)
,(273, N'Brian', N'Welcker', N'Vice President of Sales',3,1)
,(274, N'Stephen', N'Jiang', N'North American Sales Manager',3,273)
,(275, N'Michael', N'Blythe', N'Sales Representative',3,274)
,(276, N'Linda', N'Mitchell', N'Sales Representative',3,274)
,(285, N'Syed', N'Abbas', N'Pacific Sales Manager',3,273)
,(286, N'Lynn', N'Tsoflias', N'Sales Representative',3,285)
,(16, N'David',N'Bradley', N'Marketing Manager', 4, 273)
,(23, N'Mary', N'Gibson', N'Marketing Specialist', 4, 16);with DirectReport (ManId,EmpId,Title, Level) as(select ManagerID, EmployeeID, Title, 0 from MyEmployeeswhere ManagerID is nullunion allselect e.ManagerID, e.EmployeeID, e.Title, d.Level+1 from MyEmployees ejoin DirectReport d on e.ManagerID = d.EmpId)select * from DirectReportorder by ManId;