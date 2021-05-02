Select color as barva
into #Barva2
from SalesLT.Product
where 1=2;

Select * from tempdb.sys.columns where object_id=OBJECT_ID('temp.db')
select * from #Barva2
insert into #Barva2 select distinct color from SalesLt.Product
select * from SalesLT.Product
where color in (select barva from #Barva2)

