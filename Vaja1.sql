select convert(decimal(10,3),122.34) --convert(tip,vrednost);
select convert(nvarchar,getdate(),104);

--1. Poišèi vse stranke iz tabele Customers
select * from SalesLT.Customer;

--2. Izdelaj seznam strank, ki vsebuje ime kontakta, naziv, ime, srednje ime (èe ga kontakt ima),
--priimek in dodatek (èe ga kontakt ima) za vse stranke.
select Title,FirstName,MiddleName,LastName,Suffix from SalesLT.Customer;

select SalesPerson,Title+' '+LastName as Stranka from SalesLT.Customer;

--izpiši companyname in customerid iz Customer
select cast(CustomerID as nvarchar)+' '+CompanyName as Stranka from SalesLT.Customer;
select convert(nvarchar, CustomerID)+' '+CompanyName as Stranka from SalesLT.Customer;


select * from SalesLT.Product;

select color from SalesLT.Product;
select isnull(color,'Black') from SalesLT.Product;
select nullif(color,'Black') from SalesLT.Product;
select name, color, size, coalesce(color, size) as test from SalesLT.Product;

--izpiši produkte, ki so še na razpolago
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

--4. Izpiši seznam vseh strank v obliki <Customer ID> : <Company Name> na primer 78: Preferred Bikes.
select cast(CustomerID as nvarchar)+' : '+CompanyName
from SalesLT.Customer;

--5. Iz tabele SalesOrderHeader (vsebuje podatke o naroèilih) izpiši podatke
--a. Številka naroèila v obliki <Order Number> (<Revision>) –na primer SO71774 (2).
select convert(nvarchar,SalesOrderNumber)+' (<'+convert(nvarchar,RevisionNumber)+'>) '
from SalesLT.SalesOrderHeader;
--b. Datum naroèila spremenjen v ANSI standarden format (yyyy.mm.dd – na primer 2015.01.31)select convert(nvarchar,OrderDate,102)from SalesLT.SalesOrderHeader;--6. Ponovno je treba izpisati vse podatke o kontaktih, èe kontakt nima srednjega imena v obliki
--<first name> <last name>, èe ga pa ima <first name> <middle name> <last name> (na primer
--Keith Harris, Jane M. Gates)
select CustomerID, NameStyle, Title, FirstName +' ' +isnull(MiddleName+'','') +' '+ LastName as CustomerName, Suffix, CompanyName, SalesPerson, EmailAddress, Phone, PasswordHash, PasswordSalt, rowguid, ModifiedDate
from SalesLT.Customer;

--7. Stranka nam je posredovala e-mail nalov, telefon ali oboje. Èe je dostopen e-mail, ga
--uporabimo za primarni kontakt, sicer uporabimo telefonsko številko. Napiši poizvedbo, ki
--vrne CustomerID in stolpec »PrimarniKontakt«, ki vsebuje e-mail ali telefonsko številko. (v
--podatkovni bazi imajo vsi podatki e-mail. Èe hoèeš preveriti ali poizvedba deluje pravilno
--najprej izvedi stavek
--UPDATE SalesLT.Customer
--SET EmailAddress = NULL
--WHERE CustomerID % 7 = 1;
select CustomerID, isnull(EmailAddress,Phone) as PrimarniKontakt
from SalesLT.Customer;

--8. Izdelaj poizvedbo, ki vraèa seznam naroèil (order ID), njihove datume in stolpec
--»StatusDobave«, ki vsebuje besedo »Dobavljeno« za vsa naroèila, ki imajo znan datum
--dobave in »Èaka« za vsa naroèila brez datuma dobave. V bazi imajo vsa naroèila datum
--dobave. Èe želiš preveriti, ali poizvedba deluje pravilno, predhodno izvedi stavek
--UPDATE SalesLT.SalesOrderHeader
--SET ShipDate = NULL
--WHERE SalesOrderID > 71899; 
select SalesOrderID, OrderDate,
	case
		when ShipDate is not null then 'Dobavljeno'
		else 'Èaka'
		end as StatusDobave
from SalesLT.SalesOrderHeader;