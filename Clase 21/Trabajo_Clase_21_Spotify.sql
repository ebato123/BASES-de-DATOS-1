-- 1. ¿Cuál es la diferencia entre LEFT y RIGHT JOIN

-- La diferencia radica principalmente en que LEFT funciona para seleccionar TODOS LOS REGISTROS
-- de la tabla a la izquierda del ON, al contrario de RIGHT que funciona para seleccionar TODOS 
-- LOS REGISTROS de la tabla a la derecha del ON.

-- 2. ¿Cuál es el orden en el que se procesan las queries SELECT, FROM, WHERE,
--    GROUP BY, HAVING y ORDER BY?

-- FROM
-- WHERE
-- GROUP BY
-- HAVING
-- SELECT
-- ORDER BY

-- 3. ¿Qué función podríamos utilizar si quisiéramos traer el promedio de likes de
--    todas las canciones?

SELECT AVG(cantlikes)
FROM cancion;

-- 4. Si tenemos una query que trae un listado ordenado por el ID de usuarios la cual
--    cuenta con un LIMIT 20 OFFSET 27, ¿cuál sería el primer ID de los registros y cuál
--    el último?

-- El primer ID sería le 28 y el último sería el 48;

-- 5. ¿Por qué no se recomienda utilizar en exceso DISTINCT, ORDER BY y GROUP BY?

-- Es una cuestión de optimización y buena práctica. Se ejecutan menos procesos
-- por ende se consumen menos recursos para ejecutar la Query.

-- RERALIZAR LOS SIGUIENTES INFORMES:

-- 1. Mostrar la cantidad de canciones que pertenecen a ambos géneros pop y rock
--    cuyo nombre contiene la letra “m”.

SELECT COUNT(c.idCancion) AS cantCanciones
FROM cancion c
INNER JOIN generoxcancion gxc ON gxc.idCancion = c.idCancion
INNER JOIN genero g ON g.idGenero = gxc.idGenero
WHERE g.Genero IN ("Pop", "Rock")
AND c.titulo LIKE '%m%';

-- FORMA con EXISTS en lugar de IN, y LOCATE en lugar de comodines:

SELECT COUNT(c.idCancion) AS cantCanciones
FROM cancion c
WHERE EXISTS (
  SELECT 1
  FROM generoxcancion gxc
  INNER JOIN genero g ON g.idGenero = gxc.idGenero
  WHERE gxc.idCancion = c.idCancion
    AND g.Genero = 'Pop'
)
AND EXISTS (
  SELECT 1
  FROM generoxcancion gxc
  INNER JOIN genero g ON g.idGenero = gxc.idGenero
  WHERE gxc.idCancion = c.idCancion
    AND g.Genero = 'Rock'
)
AND LOCATE('m', c.titulo) > 0;

-- 2. Listar todas las canciones que pertenezcan a más de una playlist. Incluir en el
--    listado el nombre de la canción, el código y a cuántas playlists pertenecen.

SELECT c.titulo, c.idCancion, COUNT(pxc.idPlaylist) as cantPlaylists
FROM cancion c
INNER JOIN playlistxcancion pxc ON pxc.idCancion = c.idCancion
GROUP BY c.idCancion
HAVING cantPlaylists > 1;

-- 3. Generar un reporte con el nombre del artista y el nombre de la canción que no
--    pertenecen a ninguna lista, ordenados alfabéticamente por el nombre del
--    artista.

SELECT a.Nombre, c.titulo
FROM cancion c
LEFT JOIN album al ON c.IdAlbum = al.idAlbum
INNER JOIN artista a ON a.idArtista = al.idArtista
LEFT JOIN playlistxcancion pxc ON pxc.Idcancion = c.idCancion
WHERE pxc.IdPlaylist IS NULL
ORDER BY a.Nombre ASC;

-- 4. Modificar el país de todos los usuarios con el código postal “7600” a “Argentina”.

SELECT idUsuario, nombreusuario, CP, CASE
	WHEN CP = 7600 THEN 1
    ELSE Pais_idPais
END AS Pais_idPais
FROM usuario;

-- 5. Listar todos los álbumes que tengan alguna canción que posea más de un
--    género.

SELECT DISTINCT a.idAlbum, a.titulo, COUNT(gxc.IdGenero) AS cantGeneros
FROM album a
LEFT JOIN cancion c ON c.IdAlbum = a.idAlbum
INNER JOIN generoxcancion gxc ON gxc.IdCancion = c.idCancion
GROUP BY gxc.idCancion
HAVING cantGeneros > 1;

-- 6. Crear un índice agrupado para las canciones cuyo identificador sea el ID.

CREATE INDEX indice_canciones
ON cancion (idCancion);

ANALYZE TABLE cancion;

-- CREATE CLUSTERED INDEX NO FUNCIONA EN MySQL WORKBENCH.