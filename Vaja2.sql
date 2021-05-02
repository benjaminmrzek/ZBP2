select color from SalesLT.Product;

select distinct color from SalesLT.Product;

select top 10 color from SalesLT.Product;

select top 10 percent color from SalesLT.Product;

select name, ListPrice from SalesLT.Product;

select name, ListPrice from SalesLT.Product
order by ProductNumber offset 0 rows
fetch next 10 rows only;

select name, ListPrice from SalesLT.Product
order by ProductNumber offset 50 rows
fetch next 10 rows only;

--selekcija
-- where pogoj: =, <, >, <=, >=, <>, !=, and, or, not, like, between, in
-- % nadomešča karkoli (%FR%)
-- _ nadomešča natanko en znak (FR_)
-- [a-z]
-- [0-9]
-- ⌃R
select ProductNumber from SalesLT.Product
where ProductNumber like 'FR%';

-- št. produkta naj se začne na FR, nato naj sledi - , potem karkoli, potem dve števki,
-- spet karkoli, - na koncu dve števki
select ProductNumber from SalesLT.Product
where ProductNumber like 'FR-_[0-9][0-9]_-[0-9][0-9]';

--št. produkta naj se začne na BK-, naslednji znak naj ne bo R, sledi lahko več poljubnih znakov,
-- konča se na dve števki
select ProductNumber from SalesLT.Product
where ProductNumber like 'FR-[^R]%-[0-9][0-9]';

select ProductNumber from SalesLT.Product
where ProductNumber like 'FR-R%-[0-9][0-9]';

--operator in
select * from SalesLT.Product
where ProductCategoryID in (5,6,7);

select * from SalesLT.Product
where color in ('Black','Red');

-- 1. Iz tabele Address izberi vsa mesta in province, odstrani duplikate. (atributi City, Province)
select distinct City, StateProvince
from SalesLT.Address;

-- 2. Iz tabele Product izberi 10% najtežjih produktov (izpiši atribut Name, teža je v atributu Weight)
select top 10 percent Weight, Name
from SalesLT.Product
order by Weight desc;

-- 3. Iz tabele Product izberi najtežjih 100 produktov, izpusti prvih 10 najtežjih.
select Weight
from SalesLT.Product
order by Weight desc offset 10 rows
fetch next 100 rows only;

-- 4. Poišči ime, barvo in velikost produkta, kjer ima model produkta ID 1. (atributi Name, Color, Size in ProductModelID)
select Name, Color, Size
from SalesLT.Product
where ProductModelID = 1;

-- 5. Poišči številko produkta in ime vseh izdelkov, ki imajo barvo 'black', 'red' ali 'white' in velikost 'S' ali 'M'.
-- (Izpiši ProductNumber, primerjaj Color in Size)
select ProductNumber, Name
from SalesLT.Product
where Color in ('Black','Red','White')
and Size in ('S','M');

-- 6. Poišči številko produktov, ime in ceno produktov, katerih številka se začne na BK-.
-- (atributi ProductNumber, Name, ListPrice, primerjaj ProductNumer)
select ProductNumber, Name, ListPrice
from SalesLT.Product
where ProductNumber like 'BK-%';

-- 7. Spremeni prejšnjo poizvedbo tako, da boš iskal produkte, ki se začnejo na 'BK-' sledi
-- katerikoli znak razen R in se končajo na »–dve števki«. (atributi ProductNumber, Name, ListPrice, primerjaj ProductNumer, primer: BK-F1234J-11)
select ProductNumber, Name, ListPrice
from SalesLT.Product
where ProductNumber like 'BK-[^R]%-[0-9][0-9]';