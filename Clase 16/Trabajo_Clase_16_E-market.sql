-- REPORTES PARTE 1
-- Realizar una consulta de la facturación de e-market. Incluir la siguiente información:
-- ● Id de la factura
-- ● fecha de la factura
-- ● nombre de la empresa de correo
-- ● nombre del cliente
-- ● categoría del producto vendido
-- ● nombre del producto
-- ● precio unitario
-- ● cantidad

SELECT f.FacturaID, f.FechaFactura, co.Compania, c.Contacto, ca.CategoriaNombre, p.ProductoNombre, p.PrecioUnitario, p.CantidadPorUnidad
FROM facturas f
INNER JOIN clientes c ON c.ClienteID = f.ClienteID
INNER JOIN correos co ON co.CorreoID = f.EnvioVia
INNER JOIN facturadetalle fd ON fd.FacturaID = f.FacturaID
INNER JOIN productos p ON p.ProductoID = fd.ProductoID
INNER JOIN categorias ca ON ca.CategoriaID = p.CategoriaID;

-- REPORTES PARTE 2
-- 1. Listar todas las categorías junto con información de sus productos. Incluir todas
--    las categorías aunque no tengan productos.

SELECT * FROM categorias ca
LEFT JOIN productos p ON p.CategoriaID = ca.CategoriaID;

-- 2. Listar la información de contacto de los clientes que no hayan comprado nunca
--    en emarket.

SELECT c.Contacto, c.Fax, c.Telefono FROM clientes c
LEFT JOIN facturas f ON f.ClienteID = c.ClienteID
WHERE f.FacturaID IS NULL;

-- 3. Realizar un listado de productos. Para cada uno indicar su nombre, categoría, y
--    la información de contacto de su proveedor. Tener en cuenta que puede haber
--    productos para los cuales no se indicó quién es el proveedor.

SELECT p.ProductoNombre, ca.CategoriaNombre, pr.Contacto, pr.Telefono, COALESCE(pr.Fax, "Sin Fax")
FROM productos p
LEFT JOIN proveedores pr ON pr.ProveedorID = p.ProveedorID
LEFT JOIN categorias ca ON ca.CategoriaID = p.CategoriaID;

--  4. Para cada categoría listar el promedio del precio unitario de sus productos.

SELECT ca.CategoriaID, ca.CategoriaNombre, ROUND(AVG(p.PrecioUnitario), 2) AS "PromedioPrecioUnitario"
FROM categorias ca
LEFT JOIN productos p ON p.CategoriaID = ca.CategoriaID
GROUP BY ca.CategoriaID;

-- 5. Para cada cliente, indicar la última factura de compra. Incluir a los clientes que
--    nunca hayan comprado en e-market.

SELECT c.ClienteID, c.Contacto, MAX(f.FechaFactura) AS "UltimaFechaCompra"
FROM clientes c
LEFT JOIN facturas f ON c.ClienteID = f.ClienteID
GROUP BY c.ClienteID;

-- 6. Todas las facturas tienen una empresa de correo asociada (enviovia). Generar un
--    listado con todas las empresas de correo, y la cantidad de facturas
--    correspondientes. Realizar la consulta utilizando RIGHT JOIN.

SELECT co.Compania, COUNT(f.FacturaID) AS "CantidadFacturas"
FROM facturas f 
RIGHT JOIN correos co ON f.EnvioVia = co.CorreoID
GROUP BY co.CorreoID;

