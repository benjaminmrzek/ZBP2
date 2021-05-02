-- ansi 89
select a.Name, b.Name from SalesLT.Product as a, SalesLT.ProductCategory as b
where a.ProductCategoryID = b.ProductCategoryID;

-- ansi 92
select a.Name, b.Name from SalesLT.Product as a
join SalesLT.ProductCategory as b
on a.ProductCategoryID = b.ProductCategoryID;

SELECT SalesLT.Product.Name AS [Ime priimek], 
	   SalesLT.Product.Name AS [Ime kategorije]
FROM   SalesLT.Product INNER JOIN
       SalesLT.ProductCategory ON SalesLT.Product.ProductCategoryID = SalesLT.ProductCategory.ProductCategoryID

-- left outer join, right outer join, full outer join
-- imena vseh strank in njihova naroèila, tudi stranke brez naroèil
select c.FirstName, c.LastName, oh.SalesOrderNumber from SalesLT.Customer as c
left outer join SalesLT.SalesOrderHeader oh on c.CustomerID = oh.CustomerID
where SalesOrderNumber is null;

--izpiši vsa naroèila, tudi tista, ki nimajo strank
select c.FirstName, c.LastName, oh.SalesOrderNumber from SalesLT.Customer as c
right outer join SalesLT.SalesOrderHeader oh on c.CustomerID = oh.CustomerID

--izpiši stranke, naroèila, tudi stranke, ki niso niè naroèile in številke naroèil, ki jim nismo dodelili stranke
select c.FirstName, c.LastName, oh.SalesOrderNumber from SalesLT.Customer as c
cross join SalesLT.SalesOrderHeader oh;