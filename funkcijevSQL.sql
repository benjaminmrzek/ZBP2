-- funkcije v SQL-u
-- 1. skalarne
-- datumske: year(datuma), month(datum), day(datum), datname(mm,datum), datname(dw,datum)
-- datediff(yy,datum1,datum2)
select day(GETDATE());
select datename(dw,GETDATE());
select datediff(dd,GETDATE(),'12.31.2021');

-- za delo z nizi
-- upper(niz), concat(niz1,niz2), left(niz,2), substring(niz, zaèetek, dolžina),
-- len(niz), reverse(niz), right(niz,2)
select ProductID, 
	   UPPER(name) as Ime, -- ime v velike èrke
	   round(Weight,0) as teza, -- zaokroži na cele
	   year(SellStartDate) as [Leto zacetka prodaje],
	   datename(m,SellStartDate) as [Mesec zacetka],
	   left(ProductNumber,2) as [Tip produkta]
from SalesLT.Product;

-- 2. logiène funckije
-- isnumeric('101.23')
-- iif(listprice>60,'visoka','nizka')
select ProductID,
	   UPPER(name) as Ime,
	   iif(productcategoryid in (5,6,7),'Kolesa','Ostalo') as Kategorija
from SalesLT.Product;
--isto s case
select ProductID,
	   UPPER(name) as Ime,
	   case when ProductCategoryID in (5,6,7) then 'Kolesa'
	   else 'Ostalo'
	   end as Kategorija
from SalesLT.Product;

-- choose(atribut,'Kolesa','Komponente','Drugo')
select productcategoryID, choose(ProductcategoryID,'Kolesa','Komponente','Drugo') as Kategorija
from SalesLT.ProductCategory;

-- koliko mesecev je bil posamezen produkt v prodaji, to me zanima
-- samo za produkte, ki niso veè v prodaji, izpiši id in ime produkta
select ProductId, name,
iif(sellenddate is not null,datediff(mm,SellStartDate,SellEndDate),0) as [mesecev prodaje]
from SalesLT.Product;

-- 3. okenske funkcije rank()
select productid, name, listprice,
	   rank() over (order by listprice desc) as rang
from SalesLT.Product;

select productid, name, listprice,
	   rank() over (partition by productcategoryid order by listprice desc) as rang
from SalesLT.Product;

select productid, name, listprice,
	   dense_rank() over (order by listprice desc) as rang
from SalesLT.Product;

select productid, name, listprice,
	   row_number() over (order by listprice desc) as rang
from SalesLT.Product;

select productid, name, listprice,
	   ntile(4) over (order by listprice desc) as rang
from SalesLT.Product; -- 4 kvartili, 10-decili

-- 4. agregati : count, sum, avg, min, max
select count(*) as število, count(distinct productcategoryid) as kategorije,
avg(listprice) from SalesLT.Product;

select count(*) from SalesLT.Product;

select count(ProductID) from SalesLT.Product;
select count(distinct size) from SalesLT.Product;

select pc.name as ime, count(*)
from SalesLT.Product p
join SalesLT.ProductCategory pc
on p.ProductCategoryID = pc.ProductCategoryID
group by pc.Name
order by ime;