-- Reportes - JOINS
-- 1. Obtener los artistas que han actuado en una o más películas.

SELECT CONCAT(a.nombre, " ", a.apellido) AS "Artista", COUNT(axp.pelicula_id) AS "Peliculas"
FROM artista a
INNER JOIN artista_x_pelicula axp ON a.id = axp.artista_id
INNER JOIN pelicula p ON axp.pelicula_id = p.id
GROUP BY a.id;

-- 2. Obtener las películas donde han participado más de un artista según nuestra
--    base de datos.

SELECT p.titulo
FROM pelicula p
INNER JOIN artista_x_pelicula axp ON p.id = axp.pelicula_id
GROUP BY p.id
HAVING COUNT(axp.artista_id) > 1;

-- 3. Obtener aquellos artistas que han actuado en alguna película, incluso
--    aquellos que aún no lo han hecho, según nuestra base de datos.

SELECT DISTINCT CONCAT(a.nombre, " ", a.apellido) AS "Artista"
FROM artista a 
LEFT JOIN artista_x_pelicula axp ON a.id = axp.artista_id;

-- Otra Forma

SELECT * FROM artista;

-- 4. Obtener las películas que no se le han asignado artistas en nuestra base de
--    datos.

SELECT p.*
FROM pelicula p
LEFT JOIN artista_x_pelicula axp ON p.id = axp.pelicula_id
WHERE axp.artista_id IS NULL;

-- 5. Obtener aquellos artistas que no han actuado en alguna película, según
--    nuestra base de datos.

SELECT a.*
FROM artista a
LEFT JOIN artista_x_pelicula axp ON a.id = axp.artista_id
WHERE axp.artista_id IS NULL;

-- 6. Obtener aquellos artistas que han actuado en dos o más películas según
--    nuestra base de datos.

SELECT a.*
FROM artista a
INNER JOIN artista_x_pelicula axp ON a.id = axp.artista_id
GROUP BY axp.artista_id
HAVING COUNT(axp.pelicula_id) >= 2;

-- 7. Obtener aquellas películas que tengan asignado uno o más artistas, incluso
--    aquellas que aún no le han asignado un artista en nuestra base de datos.

SELECT p.*
FROM pelicula p
INNER JOIN artista_x_pelicula axp ON p.id = axp.pelicula_id
GROUP BY axp.pelicula_id
HAVING COUNT(axp.pelicula_id) >= 1;


