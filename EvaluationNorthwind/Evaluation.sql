use Northwind
;

-- 1

SELECT CompanyName,ContactName,ContactTitle,Phone
FROM Customers
WHERE Country ='FRANCE'

-- 2

SELECT productName as 'Produit' ,unitprice as 'Prix'
FROM Products
Join Suppliers on Suppliers.SupplierID = Products.SupplierID
WHERE CompanyName = 'exotic liquids'

--3

SELECT CompanyName, COUNT (UnitsOnOrder) as 'Nombre produits'
FROM Suppliers
Join Products on Products.SupplierID = Suppliers.SupplierID
WHERE Country ='France'
GROUP BY CompanyName
ORDER BY [Nombre produits] DESC

--4

SELECT CompanyName, COUNT (OrderID) as 'Nbrs de commandes'
FROM Customers
JOIN Orders on Orders.CustomerID = Customers.CustomerID
WHERE Country = 'France'
GROUP BY CompanyName
HAVING COUNT (OrderID) > 10

--5

SELECT CompanyName, SUM (UnitPrice * Quantity) as CA, Country
FROM Customers
JOIN Orders on Orders.CustomerID = Customers.CustomerID
JOIN [Order Details] on [Order Details].OrderID = Orders.OrderID = 
GROUP BY CompanyName,Country
HAVING SUM (UnitPrice * Quantity) > 30000
ORDER BY CA DESC

--6

SELECT ShipCountry
FROM Orders
JOIN [Order Details] on [Order Details].OrderID = Orders.OrderID 
JOIN Products on Products.ProductID = [Order Details].ProductID
JOIN Suppliers on Suppliers.SupplierID = Products.SupplierID
WHERE Suppliers.CompanyName = 'exotic liquids'
GROUP BY ShipCountry

--7

SELECT SUM (UnitPrice*Quantity) as 'Montant des ventes'
FROM [Order Details]
JOIN Orders on orders.OrderID = [Order Details].OrderID
WHERE YEAR(OrderDate) = 1997

-- 8

SELECT MONTH(OrderDate)as MOIS, SUM (UnitPrice*Quantity) as 'Montant des ventes'
FROM [Order Details]
JOIN Orders on orders.OrderID = [Order Details].OrderID
WHERE YEAR(OrderDate) = 1997
GROUP BY MONTH(OrderDate)
ORDER BY MONTH(OrderDate) ASC

--9

SELECT MAX (OrderDate)
FROM Orders
Join Customers on Customers.CustomerID = orders.CustomerID
WHERE CompanyName = 'Du monde entier'

--10

SELECT  AVG (DATEDIFF (day, OrderDate, ShippedDate)) as 'Delais moyen de livraison en jours'
FROM Orders
;


-- Procedures stockees

-- 9

CREATE PROC derniere_date
@compagnyname varchar (100)
as
SELECT MAX (OrderDate) as 'dernière date'
FROM Orders
Join Customers on Customers.CustomerID = orders.CustomerID
WHERE CompanyName like @compagnyname
;

exec derniere_date 'Du monde entier'
;

-- 10

CREATE proc delais_moyen
as
SELECT  AVG (DATEDIFF (day, OrderDate, ShippedDate)) as 'Delais moyen de livraison en jours'
FROM Orders
go
exec delais_moyen

-- Regle de gestion des rôles

Create trigger cout_livraison
on [order details]
for insert
as
if 
(select Country from Suppliers where SupplierID=(
	select SupplierId from Products where ProductId= (
		select ProductId from inserted
	)
))
<> (...)
rollback


SELECT Orders.OrderID, Products.ProductID
FROM Products
Join Suppliers on Suppliers.SupplierID = Products.SupplierID
Join [Order Details] on [Order Details].ProductID = Products.ProductID
Join Orders on Orders.OrderID = [Order Details].OrderID
Join Customers on Customers.CustomerID = Orders.CustomerID
WHERE Suppliers.Region = Customers.Region


