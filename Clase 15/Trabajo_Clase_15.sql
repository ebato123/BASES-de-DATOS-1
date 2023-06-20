-- 1. Listar las canciones cuya duración sea mayor a 2 minutos.

SELECT * FROM canciones
WHERE milisegundos > 120000;

-- 2. Listar las canciones cuyo nombre comience con una vocal.

SELECT * FROM canciones
WHERE nombre LIKE "A%"
OR nombre LIKE "E%"
OR nombre LIKE "I%"
OR nombre LIKE "O%"
OR nombre LIKE "U%";

-- 3. Listar las canciones ordenadas por compositor en forma descendente.
--    Luego, por nombre en forma ascendente. Incluir únicamente aquellas
--    canciones que tengan compositor.

SELECT * FROM canciones
WHERE compositor IS NOT NULL
ORDER BY compositor DESC, nombre ASC;

-- 4. a) Listar la cantidad de canciones de cada compositor.
--    b) Modificar la consulta para incluir únicamente los compositores que
--       tengan más de 10 canciones.

SELECT COUNT(*), compositor
FROM canciones
GROUP BY compositor
HAVING COUNT(*) > 10;

-- 5. a) Listar el total facturado agrupado por ciudad.
--    b) Modificar el listado del punto (a) mostrando únicamente las ciudades
--    de Canadá.
--    c) Modificar el listado del punto (a) mostrando únicamente las ciudades
--    con una facturación mayor a 38.
--    d) Modificar el listado del punto (a) agrupando la facturación por país, y
--    luego por ciudad.

SELECT SUM(total), pais_de_facturacion ,ciudad_de_facturacion
FROM facturas
WHERE pais_de_facturacion LIKE "Canada"
GROUP BY pais_de_facturacion, ciudad_de_facturacion
HAVING SUM(total) > 38;

-- 6. a) Listar la duración mínima, máxima y promedio de las canciones.
--    b) Modificar el punto (a) mostrando la información agrupada por género.

SELECT id_genero, MIN(milisegundos), MAX(milisegundos), AVG(milisegundos)
FROM canciones
GROUP BY id_genero;
