-- 1. Napi�ite poizvedbo, ki vra�a ID produkta, ime produkta z velikimi tiskanimi �rkami in stolpec
-- Te�a, ki zaokro�i te�no na prvo celo �tevilo.
select ProductID, upper(Name) as [Ime produkta], ROUND(Weight,0) as [Te�a]
from SalesLT.Product;

-- 2. Raz�irite prvo poizvedbo tako, da dodate LetoZa�etkaProdaja, ki vsebuje leto atributa
-- SellStartDate in MesecZa�Prodaje, ki vsebuje mesec istega atributa. V stolpcu naj bo ime
-- meseca (na primer 'January')
select ProductID, upper(Name) as [Ime produkta], ROUND(Weight,0) as [Te�a],
	   year(SellStartDate) as [MesecZa�Prodaje], DATENAME(m,SellStartDate) as [Mesec] 
from SalesLT.Product;

-- 3. Dodajte poizvedbi �e stolpec z imenom Tip, ki vsebuje prvi dve �rki atributa ProductNumber.
select ProductID, upper(Name) as [Ime produkta], ROUND(Weight,0) as [Te�a],
	   year(SellStartDate) as [MesecZa�Prodaje], DATENAME(m,SellStartDate) as [Mesec],
	   left(ProductNumber,2) as [Tip]
from SalesLT.Product;

-- 4. Dodajte poizvedbi �e filter, tako da bodo rezultat samo tisti produkti, ki imajo pod atributom
-- Size napisano �tevilo (ne pa 'S', 'M' ali 'L').
select ProductID, upper(Name) as [Ime produkta], ROUND(Weight,0) as [Te�a],
	   year(SellStartDate) as [MesecZa�Prodaje], DATENAME(m,SellStartDate) as [Mesec],
	   left(ProductNumber,2) as [Tip]
from SalesLT.Productwhere ISNUMERIC(Size) = 1; -- 1 = true, 0 = false