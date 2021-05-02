insert into SalesLT.Product (Name,ProductNumber,StandardCost,ListPrice,ProductCategoryID,SellStartDate)
values ('LED Lights 1','LT-L127',2.56,12.99,37,getdate());

select SCOPE_IDENTITY()

insert into SalesLT.ProductCategory (ParentProductCategoryID,Name)
values(4,'Bells and Horns');

insert into SalesLT.Product (Name,ProductNumber,StandardCost,ListPrice,ProductCategoryID,SellStartDate)
values('Bicycle Bell 1','LB-Rinn',2.47,4.99,IDENT_CURRENT('SalesLT.ProductCategory'),GETDATE());

select * from SalesLT.Product where ProductCategoryID = IDENT_CURRENT('SalesLT.ProductCategory');