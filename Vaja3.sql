-- 1. Izdelati moraš poroèilo o raèunih. V prvem koraku izdelaj poizvedbo, ki vrne ime podjetja
-- (CompanyName) iz tabele Customer , poleg tega pa še ID naroèila (salesOrderID) in skupni dolg (total due) iz tabele SalesOrderHeader.
select c.CompanyName, soh.SalesOrderID, round(soh.TotalDue,2)
from SalesLT.Customer c
inner join SalesLT.SalesOrderHeader soh
on soh.CustomerID = c.CustomerID;

-- 2. Razširi poizvedbo tako, da dodaš še naslov »Main Office« za vsakega kupca (naslov ulice,
-- mesto, državo/provinco, poštno številko in regijo). Pri tem upoštevaj, da ima vsaka stranka
-- veè naslovov v tabeli Address. Zato je naèrtovalec PB ustvaril še tabelo CustomerAddress, da
-- je rešil povezavo M:N. Poizvedba mora vsebovati obe tabeli in mora filtrirati prikljuèeno
-- tabelo CustomerAddress, tako da vzame samo naslov »Main Office«.
select c.CompanyName, a.AddressLine1, a.AddressLine2, a.City, a.StateProvince,
a.PostalCode, a.CountryRegion, soh.SalesOrderID, soh.TotalDue
from SalesLT.Customer as c
join SalesLT.SalesOrderHeader soh
on soh.CustomerID = c.CustomerID
join SalesLT.CustomerAddress ca
on ca.CustomerID = c.CustomerID
join SalesLT.Address a
on ca.AddressID = a.AddressID
where ca.AddressType = 'Main Office';

-- 3. Izdelaj seznam vseh podjetji in kontaktov (ime in priimek), ki vsebuje tudi ID naroèila
-- in skupni dolg. Seznam mora vsebovati tudi kupce, ki niso še nièesar naroèili na koncu seznama.
select c.CompanyName, c.FirstName, c.LastName, oh.SalesOrderID, oh.TotalDue
from SalesLT.Customer c
left join SalesLT.SalesOrderHeader oh
on oh.CustomerID = c.CustomerID;

-- 4. Izdelaj seznam vseh kupcev, ki nimajo podatkov o naslovu. V seznamu naj bo
-- CustomerID, ime podjetja, ime kontakta in telefonska številka vseh, ki nimajo podatkov o naslovu.
select c.CustomerID, c.CompanyName, c.FirstName, c.LastName, c.Phone
from SalesLT.Customer c
left join SalesLT.CustomerAddress ca
on ca.CustomerID = c.CustomerID
where ca.AddressID is null;

-- 5. Radi bi ugotovili katere stranke še nikoli niso naroèile in kateri produkti še nikoli niso
-- bili naroèeni. V ta namen izdelaj poizvedbo, ki vraèa CustomerID za vse stranke, ki
-- niso še nièesar naroèile in stolpec productID za vse izdelke, ki še niso bili naroèeni.
-- Vsaka vrstica z ID-jem stranke ima pri ProductID NULL, vsak ProductID vrstica ima CustomerID NULL.
select c.CustomerID, p.ProductID
from SalesLT.Customer c
full join SalesLT.SalesOrderHeader soh
on soh.CustomerID = c.CustomerID
full join SalesLT.SalesOrderDetail sod
on sod.SalesOrderID = soh.SalesOrderID
full join SalesLT.Product p
on p.ProductID = sod.ProductID
where soh.SalesOrderID is null;