-- Consignas PARTE 1
-- Clientes
-- 1) ¿Cuántos clientes existen?

SELECT COUNT(*) AS "Cantidad de Clientes" FROM clientes;

-- 2) ¿Cuántos clientes hay por ciudad?

SELECT COUNT(*) AS "Cantidad de Clientes", Ciudad
FROM clientes 
GROUP BY Ciudad;

-- Facturas
-- 1) ¿Cuál es el total de transporte?

SELECT ROUND((SUM(transporte)), 2) AS "Total de Transporte"
FROM facturas;

-- 2) ¿Cuál es el total de transporte por EnvioVia (empresa de envío)?

SELECT ROUND((SUM(transporte)), 2) AS "Total de Transporte", EnvioVia AS "Empresa de Envío ID"
FROM facturas
GROUP BY EnvioVia;

-- 3) Calcular la cantidad de facturas por cliente. Ordenar descendentemente por
--    cantidad de facturas

SELECT COUNT(*) AS "Cantidad de Facturas", ClienteID
FROM facturas
GROUP BY ClienteID
ORDER BY COUNT(*) DESC;

-- 4) Obtener el Top 5 de clientes de acuerdo a su cantidad de facturas.

SELECT COUNT(*) AS "Cantidad de Facturas", ClienteID
FROM facturas
GROUP BY ClienteID
ORDER BY COUNT(*) DESC
LIMIT 5;

-- 5) ¿Cuál es el país de envío menos frecuente de acuerdo a la cantidad de facturas? 

SELECT COUNT(*), PaisEnvio
FROM facturas
GROUP BY PaisEnvio
ORDER BY COUNT(*)
LIMIT 1;

-- 6) Se quiere otorgar un bono al empleado con más ventas. ¿Qué ID de empleado
--    realizó más operaciones de ventas?

SELECT COUNT(*), EmpleadoID
FROM facturas
GROUP BY EmpleadoID
ORDER BY COUNT(*) DESC
LIMIT 1;

-- Factura Detalle
-- 1) ¿Cuál es el producto que aparece en más líneas de la tabla Factura Detalle?

SELECT COUNT(*) AS "Cantidad de Facturas", ProductoID AS "ID del Producto"
FROM facturadetalle
GROUP BY ProductoID
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 2) ¿Cuál es el total facturado? Considerar que el total facturado es la suma de
--    cantidad por precio unitario.
 
SELECT SUM(Cantidad * PrecioUnitario) AS "Total Facturado"
FROM facturadetalle;

-- 3) ¿Cuál es el total facturado para los productos ID entre 30 y 50?

SELECT ROUND((SUM(Cantidad * PrecioUnitario)), 2) AS "Total Facturado"
FROM facturadetalle
WHERE ProductoID BETWEEN 30 AND 50;

-- 4) ¿Cuál es el precio unitario promedio de cada producto?

SELECT ROUND(AVG(PrecioUnitario), 2), ProductoID
FROM facturadetalle
GROUP BY ProductoID;

-- 5) ¿Cuál es el precio unitario máximo?

SELECT MAX(PrecioUnitario) AS "P.U.M"
FROM facturadetalle;

-- Consignas PARTE 2
-- 1) Generar un listado de todas las facturas del empleado 'Buchanan'.

SELECT f.*, e.EmpleadoID, e.Apellido
FROM facturas f
INNER JOIN empleados e ON f.EmpleadoID = e.EmpleadoID
WHERE e.Apellido LIKE "Buchanan";

-- 2) Generar un listado con todos los campos de las facturas del correo 'Speedy
--    Express'.

SELECT f.*, c.Compania
FROM facturas f
INNER JOIN correos c ON f.EnvioVia = c.CorreoID
WHERE c.Compania = "Speedy Express"
;

-- 3) Generar un listado de todas las facturas con el nombre y apellido de los
--    empleados.

SELECT f.*, CONCAT(e.Nombre, " ", e.Apellido) AS "Nombre y Apellido" 
FROM facturas f
INNER JOIN empleados e ON f.EmpleadoID = e.EmpleadoID;

-- 4) Mostrar un listado de las facturas de todos los clientes “Owner” y país de envío “USA”.

SELECT f.*, c.Titulo AS "Tipo de Cliente"
FROM facturas f
INNER JOIN clientes c ON f.ClienteID = c.ClienteID
WHERE c.Titulo LIKE "Owner%"
AND f.PaisEnvio LIKE "USA";

-- 5) Mostrar todos los campos de las facturas del empleado cuyo apellido sea
--    “Leverling” o que incluyan el producto id = “42”.

SELECT f.*, e.Apellido, p.ProductoID
FROM facturas f
INNER JOIN empleados e ON f.EmpleadoID = e.EmpleadoID
INNER JOIN facturadetalle fd ON  f.FacturaID = fd.FacturaID
INNER JOIN productos p ON fd.ProductoID = p.ProductoID
WHERE e.Apellido LIKE "Leverling"
OR p.ProductoID LIKE "42";

-- 6) Mostrar todos los campos de las facturas del empleado cuyo apellido sea
--    “Leverling” y que incluya los producto id = “80” o ”42”.

SELECT f.*, e.Apellido, p.ProductoID
FROM facturas f
INNER JOIN empleados e ON f.EmpleadoID = e.EmpleadoID
INNER JOIN facturadetalle fd ON  f.FacturaID = fd.FacturaID
INNER JOIN productos p ON fd.ProductoID = p.ProductoID
WHERE e.Apellido LIKE "Leverling"
AND (p.ProductoID LIKE "80" OR p.ProductoID LIKE "42");

-- 7) Generar un listado con los cinco mejores clientes, según sus importes de
--    compras total (PrecioUnitario * Cantidad).

SELECT ROUND((SUM(fd.PrecioUnitario * fd.Cantidad)), 2) AS "Importes de Compras TOTAL", c.ClienteID
FROM clientes c
INNER JOIN facturas f ON f.ClienteID = c.ClienteID
INNER JOIN facturadetalle fd ON  f.FacturaID = fd.FacturaID
GROUP BY c.ClienteID
ORDER BY SUM(fd.PrecioUnitario * fd.Cantidad) DESC
LIMIT 5;

-- 8) Generar un listado de facturas, con los campos id, nombre y apellido del cliente,
-- fecha de factura, país de envío, Total, ordenado de manera descendente por
-- fecha de factura y limitado a 10 filas.
 
SELECT f.FacturaID, c.Contacto, f.FechaFactura, f.PaisEnvio, ROUND(SUM(fd.PrecioUnitario * fd.Cantidad), 2) AS "Total"
FROM facturas f
INNER JOIN clientes c ON f.ClienteID = c.ClienteID
INNER JOIN facturadetalle fd ON  f.FacturaID = fd.FacturaID
GROUP BY f.FacturaID
ORDER BY f.FechaFactura DESC
LIMIT 10;