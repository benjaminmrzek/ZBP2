SELECT SalesLT.Product.Name, SalesLT.ProductCategory.Name AS Kategorija, SalesLT.SalesOrderDetail.OrderQty
FROM SalesLT.Product 
INNER JOIN SalesLT.ProductCategory 
ON SalesLT.Product.ProductCategoryID = SalesLT.ProductCategory.ProductCategoryID 
INNER JOIN SalesLT.SalesOrderDetail 
ON SalesLT.Product.ProductID = SalesLT.SalesOrderDetail.ProductID
ORDER BY Kategorija, OrderQty desc;