-- COMENTARIO: Utilizo la base de datos desactualizada porque al intentar instalar la nueva me 
--             devolvía un error de codificación.
-- 			   Para que esto sea funcional voy amodificar algunas actividades sin cambiar el
--             objetivo principal de las mismas.

-- WHERE
-- 1.Mostrar las personas que la segunda letra de su apellido es una s.
--   Tablas: contact
--   Campos: LastName

SELECT LastName FROM contact
WHERE LastName LIKE "_s%";

-- 2. Mostrar el nombre concatenado con el apellido de las personas cuyo apellido tenga
--    terminación (ez).
--      Tablas: contact

SELECT CONCAT(FirstName, " ", LastName) AS Name
FROM contact
WHERE LastName LIKE "%ez";

-- 3. Mostrar los nombres de los productos que terminan en un número.
--      Tablas: product
--      Campos: Name

SELECT Name FROM product
WHERE Name REGEXP '[0-9]$';

-- REGEXP sirve para buscar en un rango de búsqueda especificando un patrón.
-- La wildcard $ indica que el valor debe estar al final.

-- 4. Mostrar las personas cuyo nombre tenga una "c" como primer carácter, cualquier otro como
--    segundo carácter, ni d, e, f, g como tercer carácter, cualquiera entre j y r o entre s y w como
--    cuarto carácter y el resto sin restricciones.
--      Tablas: contact
--      Campos: FirstName

SELECT FirstName
FROM contact
WHERE FirstName LIKE 'c%'
  AND SUBSTRING(FirstName, 3, 1) NOT IN ("d", "e", "f", "g")
  AND (SUBSTRING(FirstName, 4, 1) IN ("j", "k", "l", "m", "n", "ñ", "o", "p", "q", "r")
  OR SUBSTRING(FirstName, 4, 1) IN ("s", "t", "u", "v", "w"));
  
-- SUBSTRING aclara la Columna, la posicion de la substring, y la posición del string.
  
-- BETWEEN
-- 1. Mostrar todos los productos cuyo precio de lista esté entre 240 y 305.
--   Tablas: product
--   Campos: ListPrice

SELECT ListPrice FROM product
WHERE ListPrice BETWEEN 240 AND 305;

-- 2. Mostrar todos los empleados que nacieron entre 1977 y 1981.
--   Tablas: employee
--   Campos: BirthDate

SELECT BirthDate FROM employee
WHERE YEAR(BirthDate) BETWEEN 1977 AND 1981;

-- OPERADORES
-- 1. Mostrar el código, fecha de ingreso y horas de vacaciones de los empleados que ingresaron a
--    partir del año 2000.
--   Tablas: employee
--   Campos: BusinessEntityID, HireDate, VacationHours

SELECT EmployeeID, HireDate, VacationHours FROM employee
WHERE YEAR(HireDate) > 2000;


-- 2. Mostrar el nombre, número de producto, precio de lista y el precio de lista incrementado en
--    un 10% de los productos cuya fecha de fin de venta sea anterior al día de hoy.
--   Tablas: product
--   Campos: Name, ProductNumber, ListPrice, SellEndDate

SELECT Name, ProductNumber, ListPrice, ROUND(ListPrice + ((ListPrice / 100)*10), 2) AS ListPriceWithPercent, SellEndDate FROM product
WHERE SellEndDate < CURRENT_DATE();

-- CONSULTAS CON "NULL"
-- 1. Mostrar los representantes de ventas (vendedores) que no tienen definido el número de
--    territorio.
--   Tablas: salesperson
--   Campos: TerritoryID, BusinessEntityID

SELECT TerritoryID, SalesPersonID FROM salesperson
WHERE TerritoryID IS NULL;

-- 2. Mostrar el peso de todos los artículos. Si el peso no estuviese definido, reemplazar por cero.
--   Tablas: product
--   Campos: Weight

SELECT CASE
	WHEN Weight IS NULL THEN 0
    ELSE Weight
END AS Weight
FROM product;

-- FUNCIONES DE AGREGACIÓN
-- 1. Mostrar solamente la fecha de nacimiento del empleado más joven.
--   Tablas: employee
--   Campos: BirthDate

SELECT MAX(BirthDate) AS YoungerBirthDate FROM employee;

-- 2. Mostrar el promedio de la lista de precios de productos con 2 dígitos después de la coma.
--    Además, agregar el signo $.
--   Tablas: product
--   Campos: ListPrice

SELECT CONCAT("$", ROUND(AVG(ListPrice), 2)) AS ListPriceAverage FROM product;

-- GROUP BY
-- 1. Mostrar los productos y la suma total vendida de cada uno de ellos, ordenados
--    ascendentemente por el total vendido. Redondear el total para abajo.
--   Tablas: salesorderdetail
--   Campos: ProductID, LineTotal

SELECT ProductID, FLOOR(SUM(LineTotal)) AS FinalLineTotal
FROM salesorderdetail
GROUP BY ProductID
ORDER BY FinalLineTotal ASC;

-- FLOOR sirve para redondear para abajo.

-- 2. Mostrar el promedio vendido por factura.
--   Tablas: salesorderdetail
--   Campos: SalesOrderID, LineTotal

SELECT SalesOrderID, ROUND(AVG(LineTotal), 2) AS AverageLineTotal
FROM salesorderdetail
GROUP BY SalesOrderID;

-- HAVING
-- 1. Mostrar las subcategorías de los productos que tienen cuatro o más productos que cuestan
--    menos de $150.
--   Tablas: product
--   Campos: ProductSubcategoryID, ListPrice

SELECT ProductSubCategoryID, COUNT(ListPrice) AS Products
FROM product
WHERE ListPrice < 150
GROUP BY ProductSubcategoryID
HAVING Products >= 4;

-- 2. Mostrar todos los códigos de subcategorías existentes junto con la cantidad de productos
--    cuyo precio de lista sea mayor a $70 y el precio promedio sea mayor a $700.
--   Tablas: product
--   Campos: ProductSubcategoryID, ListPrice

SELECT ProductSubcategoryID, COUNT(ListPrice) AS Products
FROM product
WHERE ListPrice > 70
GROUP BY ProductSubcategoryID
HAVING AVG(ListPrice) < 700;

-- JOINS
-- 1. Mostrar los precios de venta de aquellos productos donde el precio de venta sea inferior al
--    precio de lista recomendado para ese producto ordenados por nombre de producto.
--   Tablas: salesorderdetail, product
--   Campos: ProductID, Name, ListPrice, UnitPrice

SELECT DISTINCT p.ProductId, p.Name, p.ListPrice, ROUND(sod.UnitPrice, 2) AS UnitPrice
FROM salesorderdetail sod
INNER JOIN product p ON p.ProductID = sod.ProductID
WHERE sod.UnitPrice < p.ListPrice
ORDER BY p.Name;

-- 2. Mostrar todos los productos que tengan el mismo precio (precio de venta y precio de lista) y
--    que tengan un color asignado (no nulo). Se deben mostrar de a pares, código y nombre de cada
--    uno de los dos productos y el precio de ambos.
--    Ordenar por precio de venta en forma descendente.
--   Tablas: product, salesorderdetail
--   Campos: ProductID, Name, ListPrice, UnitPrice, Color


