-- 1. Napiši poizvedbo, ki vraèa ime, prvo vrstico naslova, mesto in nov stolpec z imenom
-- »TipNaslova« in vrednostjo »Za raèune« podjetja za vse stranke, ki imajo tip naslova v
-- CustomerAddress tabeli enak 'Main Office'.
select c.CompanyName, a.AddressLine1, a.City, 'Za raèune' as TipNaslova
from SalesLT.Customer c
inner join SalesLT.CustomerAddress ca
on ca.CustomerID = c.CustomerID
inner join SalesLT.Address a
on a.AddressID = ca.AddressID
where ca.AddressType = 'Main Office';

-- 2. Napiši podobno poizvedbo (ime, prva vrstica naslova, mesto in stolpec »Tip naslova« z
-- vrednostjo »Za dobavo«) za vse stranke, ki imajo tip naslova v CustomerAddress enak 'Shipping'
select c.CompanyName, a.AddressLine1, a.City, 'Za raèune' as TipNaslova
from SalesLT.Customer c
inner join SalesLT.CustomerAddress ca
on ca.CustomerID = c.CustomerID
inner join SalesLT.Address a
on a.AddressID = ca.AddressID
where ca.AddressType = 'Shipping';

-- 3. Kombiniraj oba rezultata v seznam, ki vrne vse naslove stranke urejene po strankah, nato po TipNaslova.
select c.CompanyName, a.AddressLine1, a.City, 'Za raèune' as TipNaslova
from SalesLT.Customer c
inner join SalesLT.CustomerAddress ca
on ca.CustomerID = c.CustomerID
inner join SalesLT.Address a
on a.AddressID = ca.AddressID
where ca.AddressType = 'Main Office'
union all
select c.CompanyName, a.AddressLine1, a.City, 'Za raèune' as TipNaslova
from SalesLT.Customer c
inner join SalesLT.CustomerAddress ca
on ca.CustomerID = c.CustomerID
inner join SalesLT.Address a
on a.AddressID = ca.AddressID
where ca.AddressType = 'Shipping'
order by c.CompanyName, TipNaslova;

-- 4. Napiši poizvedbo, ki vrne imena podjetji, ki so med podjetji z 'Main office' naslovom, a nimajo 'Shipping' naslova.
select c.CompanyName
from SalesLT.Customer c
inner join SalesLT.CustomerAddress ca
on ca.CustomerID = c.CustomerID
inner join SalesLT.Address a
on a.AddressID = ca.AddressID
where ca.AddressType = 'Main Office'
except
select c.CompanyName
from SalesLT.Customer c
inner join SalesLT.CustomerAddress ca
on ca.CustomerID = c.CustomerID
inner join SalesLT.Address a
on a.AddressID = ca.AddressID
where ca.AddressType = 'Shipping'
order by c.CompanyName;

-- 5. Napiši poizvedbo, ki vrne imena podjetji, ki so med podjetji z 'Main office' naslovomin hkrati med podjetji s 'Shipping' naslovom.
select c.CompanyName
from SalesLT.Customer c
inner join SalesLT.CustomerAddress ca
on ca.CustomerID = c.CustomerID
inner join SalesLT.Address a
on a.AddressID = ca.AddressID
where ca.AddressType = 'Main Office'
intersect
select c.CompanyName
from SalesLT.Customer c
inner join SalesLT.CustomerAddress ca
on ca.CustomerID = c.CustomerID
inner join SalesLT.Address a
on a.AddressID = ca.AddressID
where ca.AddressType = 'Shipping'
order by c.CompanyName;
