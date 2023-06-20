-- 1. Utilizando la base de datos de movies, queremos conocer, por un lado, los
--    títulos y el nombre del género de todas las series de la base de datos.

SELECT s.title AS "Serie", g.name AS "Género"
FROM series s
LEFT JOIN genres g ON  s.genre_id = g.id;

-- 2. Por otro, necesitamos listar los títulos de los episodios junto con el nombre y
--    apellido de los actores que trabajan en cada uno de ellos.

SELECT e.title AS "Capítulos", CONCAT(a.first_name, " ", a.last_name) AS "Actor"
FROM episodes e
INNER JOIN actor_episode ae ON ae.episode_id = e.id
INNER JOIN actors a ON a.id = ae.actor_id
ORDER BY e.title;

-- 3. Para nuestro próximo desafío, necesitamos obtener a todos los actores o
-- actrices (mostrar nombre y apellido) que han trabajado en cualquier película
-- de la saga de La Guerra de las galaxias.

SELECT m.title AS "Películas", CONCAT(a.first_name, " ", a.last_name) AS "Actor"
FROM movies m
INNER JOIN actor_movie am ON am.movie_id = m.id
INNER JOIN actors a ON a.id = am.actor_id
HAVING Películas LIKE "La Guerra de las galaxias:%"
ORDER BY m.title;

-- 4. Crear un listado a partir de la tabla de películas, mostrar un reporte de la
--    cantidad de películas por nombre de género.

SELECT COUNT(m.title) AS "Cantidad", g.name AS "Género"
FROM movies m
LEFT JOIN genres g ON m.genre_id = g.id
WHERE m.genre_id = g.id
GROUP BY g.name;


