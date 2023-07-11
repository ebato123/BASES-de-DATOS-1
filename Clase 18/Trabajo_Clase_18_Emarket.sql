-- EJERCICIO 1
-- 1. Crear una vista para poder organizar los envíos de las facturas. Indicar número
--    de factura, fecha de la factura y fecha de envío, ambas en formato dd/mm/yyyy,
--    valor del transporte formateado con dos decimales, y la información del
--    domicilio del destino incluyendo dirección, ciudad, código postal y país, en una
--    columna llamada Destino.

CREATE VIEW vista_18_1 AS
SELECT FacturaID, DATE_FORMAT(FechaFactura, "%d/%m/%Y") AS FechaFactura, DATE_FORMAT(FechaEnvio, "%d/%m/%Y") AS FechaEnvio, ROUND(Transporte, 2) AS ValorTransporte, CONCAT(PaisEnvio, ", ", CiudadEnvio, ", ", DireccionEnvio, " (CP: ", CodigoPostalEnvio, ").") AS Destino
FROM facturas;

SELECT * FROM vista_18_1;

-- 2. Realizar una consulta con todos los correos y el detalle de las facturas que
--    usaron ese correo. Utilizar la vista creada.

SELECT co.CorreoID, co.Compania, f.*
FROM vista_18_1 v181
INNER JOIN facturas f ON f.FacturaID = v181.FacturaID
RIGHT JOIN correos co ON co.CorreoID = f.EnvioVia;

-- 3. ¿Qué dificultad o problema encontrás en esta consigna? Proponer alguna
--    alternativa o solución.

-- RESPUESTA: Sin querer agrandarme (en términos Argentinos), no tuve dificultad para hacerlo.
--            Pero esta es otra forma de realizar la misma consulta, por fuera de la vista.

SELECT co.CorreoID, co.Compania, f.*
FROM facturas f
RIGHT JOIN correos co ON co.CorreoID = f.EnvioVia;

-- EJERCICIO 2
-- 1. Crear una vista con un detalle de los productos en stock. Indicar id, nombre del
--    producto, nombre de la categoría y precio unitario.

CREATE VIEW vista_18_2 AS
SELECT p.ProductoID, p.ProductoNombre, ca.CategoriaNombre, p.PrecioUnitario
FROM productos p
INNER JOIN categorias ca ON ca.CategoriaID = p.CategoriaID
WHERE UnidadesStock > 0;

SELECT * FROM vista_18_2;

-- 2. Escribir una consulta que liste el nombre y la categoría de todos los productos
--    vendidos. Utilizar la vista creada.

SELECT DISTINCT v182.ProductoNombre, v182.CategoriaNombre
FROM vista_18_2 v182
INNER JOIN facturadetalle fd ON fd.ProductoID = v182.ProductoID
WHERE v182.ProductoID = fd.ProductoID;

-- 3. ¿Qué dificultad o problema encontrás en esta consigna? Proponer alguna
--    alternativa o solución.

-- RESPUESTA: Pienso que como la consulta se sujeta a las condiciones de la vista anterior,
--            me está mostrando todos los productos vendidos CON LA CONDICIÓN de que:
--                                         UnidadesStock > 0.
--            Por lo que pienso que en este caso habría que hacer una consulta por fuera de
--            la vista, o bien modificar esa condición, aunque desde mi punto de vista sería
--            más rebuscado en este caso.

SELECT DISTINCT p.ProductoNombre, ca.CategoriaNombre
FROM productos p
INNER JOIN facturadetalle fd ON fd.ProductoID = p.ProductoID
INNER JOIN categorias ca ON ca.CategoriaID = p.CategoriaID
WHERE p.ProductoID = fd.ProductoID;
