-- 1. Izdelaj poizvedbo, ki bo vsebovala Id produkta, ime produkta in povzetek produkta (Summary) iz
-- SalesLT.Product tabele in SalesLT.vProductModelCatalogDescription pogleda.
select p.ProductID, p.Name, pmcd.Summary
from SalesLT.Product p
inner join SalesLT.vProductModelCatalogDescription as pmcd
on pmcd.ProductModelID = p.ProductModelID;

-- 2. Izdelaj tabelarièno spremenljivko in jo napolni s seznamom razliènih barv iz tabele SalesLT.Product.
-- Nato uporabi spremenljivko kot filter poizvedbe, ki vraèa ID produkta, ime, barvo iz tabele
-- SalesLT.Product in samo tiste izdelke, ki imajo barvo v zgoraj definirani zaèasni tabeli (rezultat vsebuje 245 vrstic)
declare @seznamRazlicnihBarv as table (Barva nvarchar(30));

insert into @seznamRazlicnihBarv
select distinct Color from SalesLT.Product;

select ProductID, Name, Color
from SalesLT.Product
where Color in (select Barva from @seznamRazlicnihBarv);

-- 3. Podatkovna baza AdventureWorksLT vsebuje funkcijo dbo.ufnGetAllCategories, ki vraèa tabelo
-- kategorij produktov (na primer 'Road Bikes') in roditeljske kategorije (na primer 'Bikes'). Napiši
-- poizvedbo, ki uporablja to funkcijo in vraèa seznam izdelkov, skupaj s kategorijo in roditeljsko kategorijo.
select p.ProductID, p.Name, c.ParentProductCategoryName, c.ProductCategoryName
from SalesLT.Product p
inner join dbo.ufnGetAllCategories() c
on c.ProductCategoryID = p.ProductCategoryID;

--  4. Poišèi seznam strank v obliki Company (Contact Name), skupni prihodki za vsako stranko. Uporabi
--  izpeljano tabelo, da poišèeš naroèila, nato pa naredi poizvedbo po izpeljani tabeli, da agregiraš in sumiraš podatke.
select podjetje, sum(dolg) as znesek from 
(select c.CompanyName+'('+c.FirstName+' '+c.LastName+')', soh.TotalDue 
from SalesLT.SalesOrderHeader soh
join SalesLT.Customer c
on c.CustomerID = soh.CustomerID) as mojaTabela(podjetje, dolg)
group by podjetje
order by znesek desc;

--  5. Ista naloga kot prej, le da namesto izpeljane tabele uporabiš CTE
with nova(podjetje, dolg)
as
(select c.CompanyName+'('+c.FirstName+' '+c.LastName+')', soh.TotalDue 
from SalesLT.SalesOrderHeader soh
join SalesLT.Customer c on c.CustomerID = soh.CustomerID)
select podjetje, sum(dolg) as znesek from nova
group by podjetje
order by znesek desc;