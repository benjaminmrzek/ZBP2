-- Narejeno za AdventureWorks2017 (navaden)

create procedure M1
as
select * from [HumanResources.Shift]

exec M1

-- parametri
create procedure M2
@p varchar(50) = 'Night'
as
select * from [HumanResources.Shift] where name = @p

exec M2 @p = 'Day'

create procedure M21
@p varchar(50)
as
select * from [HumanResources.Shift] where name = @p
exec M21 @p = 'Day'

create procedure M3
@p varchar(50), @s time
as
select * from [HumanResources.Shift] where name = @p and StartTime > @s

exec M3 @p = 'Day', @s = '06:00:00'

create procedure M4
@vrh nvarchar(50) output
as
select top 1 name from [HumanResources.Shift]

--klic
declare @a nvarchar(50)
exec M4 @a output
print @a

-- AdventureWorksLT2012
create procedure Moja
 @id int = null
 as
 declare @priimek nvarchar(25)
while @id<=5
 begin
	select @priimek = lastname from SalesLT.Customer
	where CustomerID = @id
	print @priimek
	set @id += 1
 end