-- 1. Izdelaj poizvedbo, ki bo vsebovala Id produkta, ime produkta in povzetek produkta (Summary) iz
-- SalesLT.Product tabele in SalesLT.vProductModelCatalogDescription pogleda.
select p.ProductID, p.Name, pmcd.Summary
from SalesLT.Product p
inner join SalesLT.vProductModelCatalogDescription as pmcd
on pmcd.ProductModelID = p.ProductModelID;

-- 2. Izdelaj tabelari�no spremenljivko in jo napolni s seznamom razli�nih barv iz tabele SalesLT.Product.
-- Nato uporabi spremenljivko kot filter poizvedbe, ki vra�a ID produkta, ime, barvo iz tabele
-- SalesLT.Product in samo tiste izdelke, ki imajo barvo v zgoraj definirani za�asni tabeli (rezultat vsebuje 245 vrstic)
declare @seznamRazlicnihBarv as table (Barva nvarchar(30));

insert into @seznamRazlicnihBarv
select distinct Color from SalesLT.Product;

select ProductID, Name, Color
from SalesLT.Product
where Color in (select Barva from @seznamRazlicnihBarv);

-- 3. Podatkovna baza AdventureWorksLT vsebuje funkcijo dbo.ufnGetAllCategories, ki vra�a tabelo
-- kategorij produktov (na primer 'Road Bikes') in roditeljske kategorije (na primer 'Bikes'). Napi�i
-- poizvedbo, ki uporablja to funkcijo in vra�a seznam izdelkov, skupaj s kategorijo in roditeljsko kategorijo.
select p.ProductID, p.Name, c.ParentProductCategoryName, c.ProductCategoryName
from SalesLT.Product p
inner join dbo.ufnGetAllCategories() c
on c.ProductCategoryID = p.ProductCategoryID;

--  4. Poi��i seznam strank v obliki Company (Contact Name), skupni prihodki za vsako stranko. Uporabi
--  izpeljano tabelo, da poi��e� naro�ila, nato pa naredi poizvedbo po izpeljani tabeli, da agregira� in sumira� podatke.
select podjetje, sum(dolg) as znesek from 
(select c.CompanyName+'('+c.FirstName+' '+c.LastName+')', soh.TotalDue 
from SalesLT.SalesOrderHeader soh
join SalesLT.Customer c
on c.CustomerID = soh.CustomerID) as mojaTabela(podjetje, dolg)
group by podjetje
order by znesek desc;

--  5. Ista naloga kot prej, le da namesto izpeljane tabele uporabi� CTE
with nova(podjetje, dolg)
as
(select c.CompanyName+'('+c.FirstName+' '+c.LastName+')', soh.TotalDue 
from SalesLT.SalesOrderHeader soh
join SalesLT.Customer c on c.CustomerID = soh.CustomerID)
select podjetje, sum(dolg) as znesek from nova
group by podjetje
order by znesek desc;