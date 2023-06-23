-- Vistas - Parte 1
-- CLIENTES
-- 1. Crear una vista con los siguientes datos de los clientes: ID, contacto, y el
--    Fax. En caso de que no tenga Fax, colocar el teléfono, pero aclarándolo. Por
--    ejemplo: “TEL: (01) 123-4567”.

CREATE VIEW vista_1 AS
SELECT c.ClienteID, c.Contacto, COALESCE(CONCAT("FAX: ", c.Fax), CONCAT("TEL: ", c.Telefono)) AS "Fax o Tel"
FROM clientes c;

SELECT * FROM vista_1;

-- 2. Se necesita listar los números de teléfono de los clientes que no tengan
--    fax. Hacerlo de dos formas distintas:
-- a. Consultando la tabla de clientes.
-- b. Consultando la vista de clientes.

SELECT Telefono FROM clientes
WHERE Fax IS NULL;

SELECT v1.* FROM vista_1 v1
INNER JOIN clientes c ON c.ClienteID = v1.ClienteID
WHERE c.Fax IS NULL;

-- PROVEEDORES
-- 1. Crear una vista con los siguientes datos de los proveedores: ID,
--    contacto, compañía y dirección. Para la dirección tomar la dirección,
--    ciudad, código postal y país.

CREATE VIEW vista_2 AS
SELECT ProveedorID, Contacto, Compania, CONCAT(Pais, ", ", Ciudad, ", ", Direccion, " (CP: ", CodigoPostal, ").") AS "Dirección"
FROM proveedores;

SELECT * FROM vista_2;

-- 2. Listar los proveedores que vivan en la calle Americanas en Brasil. Hacerlo
--    de dos formas distintas:
-- a. Consultando la tabla de proveedores.
-- b. Consultando la vista de proveedores.

SELECT * FROM proveedores
WHERE Direccion LIKE "%Americanas%"
AND Pais LIKE "Brazil";

SELECT * FROM vista_2 v2
INNER JOIN proveedores p ON p.ProveedorID = v2.ProveedorID
WHERE p.Direccion LIKE "%Americanas%"
AND p.Pais LIKE "Brazil";

-- Vistas - Parte 2
-- 1. Crear una vista de productos que se usará para control de stock. Incluir el ID
--    y nombre del producto, el precio unitario redondeado sin decimales, las
--    unidades en stock y las unidades pedidas. Incluir además una nueva
--    columna PRIORIDAD con los siguientes valores:

--       ■ BAJA: si las unidades pedidas son cero.
--       ■ MEDIA: si las unidades pedidas son menores que las unidades en stock.
--       ■ URGENTE: si las unidades pedidas no duplican el número de unidades.
--       ■ SUPER URGENTE: si las unidades pedidas duplican el número de unidades en caso contrario.

CREATE VIEW vista_3 AS
SELECT ProductoID, ProductoNombre, ROUND(PrecioUnitario) AS PrecioUnitario, UnidadesStock, UnidadesPedidas, 
CASE
	WHEN UnidadesPedidas = 0 THEN "BAJA"
    WHEN UnidadesPedidas < UnidadesStock THEN "MEDIA"
    WHEN UnidadesPedidas < (UnidadesStock * 2) THEN "URGENTE"
    WHEN UnidadesPedidas >= (UnidadesStock * 2) THEN "SUPER URGENTE"
END AS PRIORIDAD
FROM productos;

SELECT * FROM vista_3;

-- 2. Se necesita un reporte de productos para identificar problemas de stock.
--    Para cada prioridad indicar cuántos productos hay y su precio promedio.
--    No incluir las prioridades para las que haya menos de 5 productos.

SELECT v3.PRIORIDAD, SUM(p.ProductoID) AS CantidadProductos, ROUND(AVG(p.PrecioUnitario), 2) AS PrecioPromedio
FROM vista_3 v3
INNER JOIN productos p ON p.ProductoID = v3.ProductoID
GROUP BY v3.PRIORIDAD;

