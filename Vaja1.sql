select convert(decimal(10,3),122.34) --convert(tip,vrednost);
select convert(nvarchar,getdate(),104);

--1. Poi��i vse stranke iz tabele Customers
select * from SalesLT.Customer;

--2. Izdelaj seznam strank, ki vsebuje ime kontakta, naziv, ime, srednje ime (�e ga kontakt ima),
--priimek in dodatek (�e ga kontakt ima) za vse stranke.
select Title,FirstName,MiddleName,LastName,Suffix from SalesLT.Customer;

select SalesPerson,Title+' '+LastName as Stranka from SalesLT.Customer;

--izpi�i companyname in customerid iz Customer
select cast(CustomerID as nvarchar)+' '+CompanyName as Stranka from SalesLT.Customer;
select convert(nvarchar, CustomerID)+' '+CompanyName as Stranka from SalesLT.Customer;


select * from SalesLT.Product;

select color from SalesLT.Product;
select isnull(color,'Black') from SalesLT.Product;
select nullif(color,'Black') from SalesLT.Product;
select name, color, size, coalesce(color, size) as test from SalesLT.Product;

--izpi�i produkte, ki so �e na razpolago
select name,
		case
		when SellEndDate is null then 'Na razpolago'
		else 'Razprodano'
		end as status
		from SalesLT.Product;

--spremeni oznake S, M, L v atributu size small,...
select name,
		case
			when size='S' then 'small'
			when size='M' then 'medium'
			when size='L' then 'large'
		else
			isnull(size,'enotna velikost')
		end
from SalesLT.Product;

--4. Izpi�i seznam vseh strank v obliki <Customer ID> : <Company Name> na primer 78: Preferred Bikes.
select cast(CustomerID as nvarchar)+' : '+CompanyName
from SalesLT.Customer;

--5. Iz tabele SalesOrderHeader (vsebuje podatke o naro�ilih) izpi�i podatke
--a. �tevilka naro�ila v obliki <Order Number> (<Revision>) �na primer SO71774 (2).
select convert(nvarchar,SalesOrderNumber)+' (<'+convert(nvarchar,RevisionNumber)+'>) '
from SalesLT.SalesOrderHeader;
--b. Datum naro�ila spremenjen v ANSI standarden format (yyyy.mm.dd � na primer 2015.01.31)select convert(nvarchar,OrderDate,102)from SalesLT.SalesOrderHeader;--6. Ponovno je treba izpisati vse podatke o kontaktih, �e kontakt nima srednjega imena v obliki
--<first name> <last name>, �e ga pa ima <first name> <middle name> <last name> (na primer
--Keith Harris, Jane M. Gates)
select CustomerID, NameStyle, Title, FirstName +' ' +isnull(MiddleName+'','') +' '+ LastName as CustomerName, Suffix, CompanyName, SalesPerson, EmailAddress, Phone, PasswordHash, PasswordSalt, rowguid, ModifiedDate
from SalesLT.Customer;

--7. Stranka nam je posredovala e-mail nalov, telefon ali oboje. �e je dostopen e-mail, ga
--uporabimo za primarni kontakt, sicer uporabimo telefonsko �tevilko. Napi�i poizvedbo, ki
--vrne CustomerID in stolpec �PrimarniKontakt�, ki vsebuje e-mail ali telefonsko �tevilko. (v
--podatkovni bazi imajo vsi podatki e-mail. �e ho�e� preveriti ali poizvedba deluje pravilno
--najprej izvedi stavek
--UPDATE SalesLT.Customer
--SET EmailAddress = NULL
--WHERE CustomerID % 7 = 1;
select CustomerID, isnull(EmailAddress,Phone) as PrimarniKontakt
from SalesLT.Customer;

--8. Izdelaj poizvedbo, ki vra�a seznam naro�il (order ID), njihove datume in stolpec
--�StatusDobave�, ki vsebuje besedo �Dobavljeno� za vsa naro�ila, ki imajo znan datum
--dobave in ��aka� za vsa naro�ila brez datuma dobave. V bazi imajo vsa naro�ila datum
--dobave. �e �eli� preveriti, ali poizvedba deluje pravilno, predhodno izvedi stavek
--UPDATE SalesLT.SalesOrderHeader
--SET ShipDate = NULL
--WHERE SalesOrderID > 71899; 
select SalesOrderID, OrderDate,
	case
		when ShipDate is not null then 'Dobavljeno'
		else '�aka'
		end as StatusDobave
from SalesLT.SalesOrderHeader;