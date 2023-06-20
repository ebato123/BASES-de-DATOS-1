-- Categorías y productos:

-- 1. Queremos tener un listado de todas las categorías.

SELECT * FROM categorias;

-- 2. Como las categorías no tienen imágenes, solamente interesa obtener un
--    listado de CategoriaNombre y Descripcion.

SELECT CategoriaNombre, Descripcion
FROM categorias;

-- 3. Obtener un listado de los productos.

SELECT * FROM productos;

-- 4. ¿Existen productos discontinuados? (Discontinuado = 1).

SELECT * FROM productos
WHERE Discontinuado = 1;

-- 5. Para el viernes hay que reunirse con el Proveedor 8. ¿Qué productos son
--    los que nos provee?

SELECT * FROM proveedores
WHERE proveedorID = 8;

-- 6. Queremos conocer todos los productos cuyo precio unitario se encuentre
--    entre 10 y 22.

SELECT * FROM productos
WHERE PrecioUnitario BETWEEN 10 AND 22;

-- 7. Se define que un producto hay que solicitarlo al proveedor si sus unidades
--    en stock son menores al Nivel de Reorden. ¿Hay productos por solicitar?

SELECT * FROM productos
WHERE UnidadesStock < NivelReorden;

-- 8. Se quiere conocer todos los productos del listado anterior, pero que
--    unidades pedidas sea igual a cero.

SELECT * FROM productos
WHERE UnidadesPedidas = 0;

-- Clientes

-- 1. Obtener un listado de todos los clientes con Contacto, Compania, Título,
--    País. Ordenar el listado por País.

SELECT Contacto, Compania, Titulo, Pais FROM clientes
ORDER BY Pais;

-- 2. Ahora se requiere un listado de las facturas con el país de envío “USA” y
--    que su correo (EnvioVia) sea distinto de 3.

SELECT * FROM facturas
WHERE PaisEnvio = "USA"
AND EnvioVia != 3;

-- 3. ¿El cliente 'GOURL' realizó algún pedido?

SELECT * FROM facturas
WHERE ClienteID LIKE "GOURL";

-- Facturas: 
-- 1. Obtener un listado de todas las facturas, ordenado por fecha de factura
--    ascendente.

SELECT * FROM facturas
ORDER BY FechaFactura DESC;

-- 2. Ahora se requiere un listado de las facturas con el país de envío “USA” y
--    que su correo (EnvioVia) sea distinto de 3.

SELECT * FROM facturas
WHERE PaisEnvio LIKE "USA"
AND EnvioVia != 3;

-- 3. ¿El cliente 'GOURL' realizó algún pedido?

SELECT * FROM facturas 
WHERE ClienteID LIKE "GOURL";

-- 4. Se quiere visualizar todas las facturas de los empleados 2, 3, 5, 8 y 9.

SELECT * FROM facturas
WHERE EmpleadoID = 2 
OR EmpleadoID = 3 
OR EmpleadoID = 5 
OR EmpleadoID = 8 
OR EmpleadoID = 9;








