
-- Productos

-- 1. Obtener el listado de todos los productos ordenados
--    descendentemente por precio unitario.

SELECT * FROM productos 
ORDER BY PrecioUnitario DESC;

-- 2. Obtener el listado de top 5 de productos cuyo precio unitario es
--    el más caro.

SELECT * FROM productos
ORDER BY PrecioUnitario DESC
LIMIT 5;

-- 3. Obtener un top 10 de los productos con más unidades en stocK

SELECT * FROM productos 
ORDER BY UnidadesStock DESC
LIMIT 10;

-- FacturaDetalle

-- 1. Obtener un listado de FacturaID, Producto, Cantidad.

SELECT FacturaID, ProductoID, Cantidad
FROM facturadetalle;

-- 2. Ordenar el listado anterior por cantidad descendentemente.

SELECT FacturaID, ProductoID, Cantidad
FROM facturadetalle
ORDER BY Cantidad DESC;

-- 3. Filtrar el listado solo para aquellos productos donde la cantidad
--    se encuentre entre 50 y 100.

SELECT * FROM facturadetalle
WHERE Cantidad BETWEEN 50 AND 100;

-- 4. En otro listado nuevo, obtener un listado con los siguientes
--    nombres de columnas: NroFactura (FacturaID), Producto
--    (ProductoID), Total (PrecioUnitario*Cantidad).

SELECT FacturaID AS NroFactura, ProductoID AS Producto, (PrecioUnitario*Cantidad) AS Total
FROM facturadetalle;

-- ¡EXTRAS!

-- 1. Obtener un listado de todos los clientes que viven en “Brazil" o “Mexico”,
--    o que tengan un título que empiece con “Sales”.

SELECT * FROM clientes
WHERE Pais LIKE "Brazil" 
OR Pais LIKE "Mexico"
OR Titulo LIKE "Sales%";

-- 2. Obtener un listado de todos los clientes que pertenecen a una compañía
--    que empiece con la letra "A".

SELECT * FROM clientes
WHERE Compania LIKE "A%";

-- 3. Obtener un listado con los datos: Ciudad, Contacto y renombrarlo
--    como Apellido y Nombre, Titulo y renombrarlo como Puesto, de todos
--    los clientes que sean de la ciudad "Madrid".

SELECT Ciudad, Contacto AS "Apellido y Nombre", Titulo AS Puesto
FROM clientes WHERE Ciudad LIKE "Madrid";

-- 4. Obtener un listado de todas las facturas con ID entre 10000 y 1050

SELECT * FROM facturas
WHERE FacturaID BETWEEN 10000 AND 10500;

-- 5. Obtener un listado de todas las facturas con ID entre 10000 y 10500 o de
--    los clientes con ID que empiecen con la letra “B”.

SELECT * FROM facturas
WHERE FacturaID BETWEEN 10000 AND 10500
OR ClienteID LIKE "B%";

-- 6. ¿Existen facturas que la ciudad de envío sea “Vancouver” o que
--    utilicen el correo 3?

SELECT * FROM facturas
WHERE CiudadEnvio LIKE "Vancouver"
OR EnvioVia = 3;

-- 7. ¿Cuál es el ID de empleado de “Buchanan”?

SELECT EmpleadoID FROM empleados
WHERE Apellido LIKE "Buchanan";

-- 8. ¿Existen facturas con EmpleadoID del empleado del ejercicio anterior?

SELECT * FROM facturas
WHERE EmpleadoID = 5;