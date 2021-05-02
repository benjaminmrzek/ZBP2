-- 1. Poi��i ID produkta, ime in ceno produkta (list price) za vsak produkt, kjer je cena produkta
-- ve�ja od povpre�ne cene na enoto (unit price) za vse produkte, ki smo jih prodali
select ProductID, Name, ListPrice 
from SalesLT.Product
where ListPrice > (select avg(UnitPrice) from SalesLT.SalesOrderDetail);

-- 2. Poi��i ID produkta, ime in ceno produkta (list price) za vsak produkt, kjer je cena (list) 100$ ali
-- ve� in je bil produkt prodan (unit price) za manj kot 100$.
select ProductID, Name, ListPrice
from SalesLT.Product
where ProductID in (select ProductID 
					from SalesLT.SalesOrderDetail
					where UnitPrice < 100
					and ListPrice >= 100);

-- 3. Poi��i ID produkta, ime in ceno produkta (list price) in proizvodno ceno (standardcost) za vsak
-- produkt skupaj s povpre�no ceno, po kateri je bil produkt prodan.
select ProductID, Name, ListPrice, StandardCost, 
	  (select avg(UnitPrice) 
		from SalesLT.SalesOrderDetail sod 
		where p.ProductID = sod.ProductID) as [Povpre�na prodajna cena]
from SalesLT.Product p;

-- 4. Filtriraj prej�njo poizvedbo, da bo vsebovala samo produkte, kjer je cena proizvodnje (cost
-- price) ve�ja od povpre�ne prodajne cene.
select ProductID, Name, ListPrice, StandardCost, 
	(select avg(UnitPrice) 
		from SalesLT.SalesOrderDetail sod 
		where p.ProductID = sod.ProductID) as [Povpre�na prodajna cena]
from SalesLT.Product p
where StandardCost > (select avg(UnitPrice) 
		from SalesLT.SalesOrderDetail sod 
		where p.ProductID = sod.ProductID);

-- 5. Poi��i ID naro�ila, ID stranke, Ime in priimek stranke in znesek dolga za vsa naro�ila v
-- SalesLT.SalesOrderHeader s pomo�jo funkcije dbo.ufnGetCustomerInformation
select soh.SalesOrderID, soh.CustomerID, gci.FirstName, gci.LastName, soh.TotalDue
from SalesLT.SalesOrderHeader soh
cross apply dbo.ufnGetCustomerInformation(soh.CustomerID) gci;

-- 6. Poi��i ID stranke, Ime in priimek stranke, naslov in mesto iz tabele SalesLT.Address in iz
-- tabele SalesLT.CustomerAddress s pomo�jo funkcije dbo.ufnGetCustomerInformation
select ca.CustomerID, gci.FirstName, gci.LastName, a.AddressLine1, a.City
from SalesLT.Address a
inner join SalesLT.CustomerAddress ca
on ca.AddressID = a.AddressID
cross apply dbo.ufnGetCustomerInformation(ca.CustomerID) gci;