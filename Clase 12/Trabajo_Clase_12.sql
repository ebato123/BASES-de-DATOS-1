-- 1) Listar las canciones que poseen la letra “z” en su título.

SELECT * FROM cancion 
WHERE titulo LIKE "%z%";

-- 2) Listar las canciones que poseen como segundo carácter la letra “a” 
--    y como último, la letra “s”.

SELECT * FROM cancion
WHERE titulo LIKE "_a%s";

-- 3) Mostrar la playlist que tiene más canciones, renombrando las columnas 
--    poniendo mayúsculas en la primera letra, los tildes correspondientes y 
--    agregar los espacios entre palabras.

SELECT idPlaylist AS "Id Playlist", idusuario AS "Id Usuario", titulo AS "Título", cantcanciones AS "Cantidad Canciones", idestado AS "Id Estado", Fechacreacion AS "Fecha Creación", Fechaeliminada AS "Fecha Eliminada" FROM playlist
ORDER BY cantcanciones DESC
LIMIT 1; 

-- 4) En otro momento se obtuvo un listado con los 5 usuarios más jóvenes, 
--       obtener un listado de los 10 siguientes. 

SELECT * FROM usuario 
ORDER BY fecha_nac DESC
LIMIT 10
OFFSET 5;

-- 5) Listar las 5 canciones con más reproducciones, ordenadas descendentemente.

SELECT * FROM cancion 
ORDER BY cantreproduccion DESC
LIMIT 5;

-- 6) Generar un reporte de todos los álbumes ordenados alfabéticamente.

SELECT * FROM album
ORDER BY titulo;

-- 7) Listar todos los álbumes que no tengan imagen, ordenados alfabéticamente.

SELECT * FROM album
WHERE imagenportada IS NULL;

-- 8) Insertar un usuario nuevo con los siguientes datos (tener en cuenta las relaciones):

INSERT INTO proyecto_spotify.usuario ()
VALUES (20, "nuevousuariodespotify@gmail.com", "ELMER GOMEZ", "1991-11-15", "M", "B4129ATF", "S4321m", 2, 3, NULL);

-- QUISE PONER DEFAULT EN EL PRIMERO VALOR, PERO NO LA BASE DE DATOS NO ME DEJÓ.

-- 9) Eliminar todas las canciones de género “pop”.

DELETE FROM cancion
WHERE idCancion IN (6, 7, 8, 9, 11, 12, 13, 14, 15, 18, 19, 
                   20, 21, 22, 23, 24, 25, 79, 85, 130, 133);

-- 10) 

UPDATE artista
SET imagen =  "Imagen faltante"
WHERE imagen IS NULL;
