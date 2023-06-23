-- Modificar la consulta para que liste todos los futbolistas, aunque
-- no pertenezcan a ningún club.

SELECT c.nombre AS club, f.nombre, f.posicion
FROM club c 
INNER JOIN futbolista f
ON c.id = f.id_club;
--
SELECT c.nombre AS club, f.nombre, f.posicion
FROM club c 
RIGHT JOIN futbolista f
ON c.id = f.id_club;

-- Modificar la consulta para que devuelva todos los productos aunque
-- no hayan generado ventas.

SELECT p.id, p.nombre, v.importe
FROM producto p 
INNER JOIN venta v
ON p.id = v.id_producto;
--
SELECT p.id, p.nombre, v.importe
FROM producto p 
LEFT JOIN venta v
ON p.id = v.id_producto;

-- Modificar la consulta para que devuelva todos los cursos aunque 
-- ningún estudiante se haya inscripto en dichos.

SELECT e.id, e.nombre, c.nombre
FROM estudiante e 
INNER JOIN curso c
ON e.id_curso = c.id;
--
SELECT e.id, e.nombre, c.nombre
FROM estudiante e 
RIGHT JOIN curso c
ON e.id_curso = c.id;

-- Modificar la consulta para que liste todas las películas que no tienen director.

SELECT p.nombre AS pelicula, d.nombre AS director
FROM pelicula p
INNER JOIN director d
ON p.director_id = d.id;
--
SELECT p.nombre AS pelicula, d.nombre AS director
FROM pelicula p
LEFT JOIN director d
ON p.director_id = d.id
WHERE p.director_id IS NULL;

-- a) Si hay algún país sin presidente, ¿Aparecería en el resultado?¿Porqué?.
-- b) Y si hay alguna persona que no es presidente de ningún país, ¿Aparecería?¿Porqué?.

SELECT pa.nombre AS pais, CONCAT(pe.apellido, " ", pe.nombre) AS presidente
FROM pais pa
LEFT JOIN persona pe
ON pa.presidente = pe.id;

-- a) Sí, porque la cláusula LEFT JOIN le indica devolver TODOS los resultados sin importar su valor.
-- b) No, porque en la cláusla ON indicamos que el valor de pa.presidente debe coinsidir con la persona en cuestión. 




