-- WHERE
-- 1. Mostrar el nombre, precio y color de los accesorios para asientos de las bicicletas
--    cuyo precio sea mayor a 100 pesos.
--    Tablas: Production.Product
--    Campos: Name, ListPrice, Color

SELECT Name, ListPrice, Color
FROM product
WHERE ProductSubcategoryID = 15
AND ListPrice > 100;

-- COMENTARIO: No hay accesiruis oara asientos de bicicletas que salgan más de 100.

-- OPERADORES & JOINS
-- 1. Mostrar los empleados que tienen más de 90 horas de vacaciones.
-- Tablas: Employee
-- Campos: VacationHours, BusinessEntityID

SELECT VacationHours, CONCAT(EmployeeID, "(ID)", ", ", ContactID, "(ContactID)") AS BusinessEntityID
FROM employee
WHERE VacationHours > 90;

-- 2. Mostrar el nombre, precio y precio con iva de los productos con precio distinto de
--    cero.
-- Tablas: Product
-- Campos: Name, ListPrice

SELECT Name, ListPrice, ROUND((ListPrice + (ListPrice / 100)*21), 2) AS ListPricePlusIVA
FROM product
WHERE ListPrice != 0;

-- 3. Mostrar precio y nombre de los productos 776, 777, 778.
-- Tablas: Product
-- Campos: ProductID, Name, ListPrice

SELECT ProductID, Name, ListPrice
FROM Product
WHERE ProductID IN (776, 777, 778);

-- COMENTARIO: En este caso es más conveniente utilizar un IN en lugar de un EXISTS
--             ya que no es una subconsulta muy extensa o que arroje una gran cant-
--             idad de datos.

-- ORDER BY
-- 1. Mostrar las personas ordenadas primero por su apellido y luego por su nombre.
-- Tablas: Contact
-- Campos: Firstname, Lastname

SELECT DISTINCT FirstName, LastName
FROM contact
ORDER BY LastName, FirstName;

-- FUNCIONES DE AGREGACIÓN 
-- 1. Mostrar la cantidad y el total vendido por productos.
--    Tablas: SalesOrderDetail
--    Campos: LineTotal

SELECT ProductID, COUNT(ProductID) AS TotalProducts, ROUND(SUM(LineTotal), 2) AS LineTotalAmount
FROM SalesOrderDetail
GROUP BY ProductID;

-- GROUP BY
-- 1. Mostrar el código de subcategoría y el precio del producto más barato de cada una
--    de ellas.
-- Tablas: Product
-- Campos: ProductSubcategoryID, ListPrice

SELECT ProductSubcategoryID, MIN(ListPrice)
FROM Product
GROUP BY ProductSubcategoryID;

-- HAVING
-- 1. Mostrar todas las facturas realizadas y el total facturado de cada una de ellas
--    ordenado por número de factura pero sólo de aquellas órdenes superen un total de
--    $10.000.
-- Tablas: SalesOrderDetail
-- Campos: SalesOrderID, LineTotal

SELECT SalesOrderID, ROUND(SUM(LineTotal), 2) AS LineTotalAmount
FROM SalesOrderDetail
GROUP BY SalesOrderID
HAVING LineTotalAmount > 10000;

-- JOINS
-- 1. Mostrar los empleados que también son vendedores
-- Tablas: Employee, SalesPerson
-- Campos: BusinessEntityID

SELECT e.EmployeeID, e.ContactID
FROM Employee e
INNER JOIN SalesPerson sp ON e.EmployeeID = sp.SalesPersonID;

-- 2. Mostrar los empleados ordenados alfabéticamente por apellido y por nombre
-- Tablas: Employee, Contact
-- Campos: BusinessEntityID, LastName, FirstName

SELECT e.EmployeeID, c.FirstName, c.LastName
FROM employee e
INNER JOIN contact c ON e.EmployeeID = c.ContactID
ORDER BY c.LastName, c.FirstName;

