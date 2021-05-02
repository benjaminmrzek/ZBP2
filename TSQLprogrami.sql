-- T-SQL programi
go
declare @barva nvarchar(25) = 'Black',
		@velikost nvarchar(5) = 'L'
select * from SalesLT.Product where color = @barva and size = @velikost
go

-- prirejanje vrednosti s set
declare @barva nvarchar(25)
set @barva = 'Red'
print @barva;

-- prirejanje vrednosti v poizvedbi
declare @rezultat money
select @rezultat = max(totaldue) from SalesLT.SalesOrderHeader
print @rezultat;

-- if stavek / vejitve
declare @barva nvarchar(25)
set @barva = 'Red'
if @barva is null
 begin
	select * from SalesLT.Product
 end
else
 begin
	select * from SalesLT.Product where color = @barva
 end
print @@rowcount

-- pisanje zank
declare @id int = 1, @priimek nvarchar(25)
while @id <=5
 begin
	select @priimek = lastname from SalesLT.Customer
	where CustomerID = @id
	print @priimek
	set @id += 1
 end