
--obièen insert
insert into MyEmployees values (287 , 'Janez' , 'Novak' , 'Šef' , 16 , null )

--insert s specifiènimi vnosi
insert into MyEmployees (EmployeeID, FirstName, LastName, Title, DeptID) 
values (288 , 'Tine' , 'Slokar' , 'Èistilec' , 16 , null)

--posebnosti: privzete vrednosti, izraèunane vrednosti, avtomatske vrednosti, identitete
 create table T1 (
 st1 as 'Izraèunana vrednost' + st2,
 st2 varchar(30)
	constraint privzeto default('privzeta vrednost'),
 st3 rowversion,
 st4 varchar(40) null
 )

 insert into T1 (st4)
 values ('Eksplicitna vrednost')

 select * from T1
 insert into T1 (st2, st4)
 values ('Eksplicitna vrednost', 'Eksplicitna')

 insert into t1 (st2)
 values ('ena druga')

 insert into T1 default values

 drop table T1
 --èe vstaviš vrstice 1-5, nato izbrišeš nekaj vmesnih (npr. 2-3), bo identiteta šla naprej (6, 7...). 
 --Ne bo zapolnila manjkajoèih vrednosti
 create table T1(
  st1 int identity(1,1), 
  st2 varchar(30)
 )

 insert into T1 
 values ('Prva vrednost')

 select * from T1

 set identity_insert T1 on --Nastavi polnjenje manjkajoèih vrednosti
 insert into T1 (st1,st2)
 values (-99, 'id')

 create table T2 (
  st1 int identity,
  st2 uniqueidentifier
  )

  insert into T2 (st2)
  values (newid())
  select * from T2

  insert into T2 default values
  -------------------------------------------------
  use AdventureWorks2012

  select * from Person.Address

  update Person.Address
  set ModifiedDate = GETDATE()

  select * from Sales.SalesPerson
  update Sales.SalesPerson
  set Bonus = 6500, CommissionPct = 0.15, SalesQuota = 100

  update Production.Product
  set color = 'Metallic Color'
  where name like 'Road-150%' and color = 'Red'

  --Spreminjanje podatkov s pomoèjo CTE
  --Posodobi Product z vsemi sestavnimi deli
  select * from Production.BillOfMaterials
  where ProductAssemblyID = 800
  select * from Production.BillOfMaterials
  where ProductAssemblyID = 518
  select * from Production.BillOfMaterials
  where ProductAssemblyID = 497

  with Deli (ProductAssemblyID, ComponentID, perAssemblyQty, EndDate, clevel) as
  (
	select ProductAssemblyID, ComponentID, PerAssemblyQty, EndDate, 0 as clevel 
	from Production.BillOfMaterials as b
	where b.ProductAssemblyID = 800 and EndDate is null
	union all
		select bom.ProductAssemblyID, bom.ComponentID, bom.PerAssemblyQty, bom.EndDate, clevel+1
		from Production.BillOfMaterials bom
		join Deli d on d.ComponentID = bom.ProductAssemblyID
		where bom.EndDate is null
  )
  select * from Deli

  update Production.BillOfMaterials
  set PerAssemblyQty= c.PerAssemblyQty*2
  from Production.BillOfMaterials as c
  join Deli as d on c.ProductAssemblyID=d.AssemblyID
  where d.clevel = 1