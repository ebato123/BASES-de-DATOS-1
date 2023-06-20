-- REPORTES PARTE 1
-- 1. Obtener el nombre y apellido de los primeros 5 actores disponibles. Utilizar
--    alias para mostrar los nombres de las columnas en español.

SELECT first_name AS "Nombre", last_name AS "Apellido"
FROM actor LIMIT 5;

-- 2. Obtener un listado que incluya nombre, apellido y correo electrónico de los
--    clientes (customers) inactivos. Utilizar alias para mostrar los nombres de las
--    columnas en español.

SELECT first_name AS "Nombre", last_name AS "Apellido", email AS "Correo"
FROM customer
WHERE active = 0;

-- 3. Obtener un listado de films incluyendo título, año y descripción de los films
-- que tienen un rental_duration mayor a cinco. Ordenar por rental_duration de
-- mayor a menor. Utilizar alias para mostrar los nombres de las columnas en
-- español.

SELECT title AS "Título", release_year AS "Año de Estreno", description AS "Descripción"
FROM film
WHERE rental_duration > 5
ORDER BY rental_duration DESC;

-- 4. Obtener un listado de alquileres (rentals) que se hicieron durante el mes de
--    mayo de 2005, incluir en el resultado todas las columnas disponibles.

SELECT * FROM rental
WHERE rental_date LIKE "%-05-%";

-- REPORTES PARTE 2
-- 1. Obtener la cantidad TOTAL de alquileres (rentals). Utilizar un alias para
--    mostrarlo en una columna llamada “cantidad”.

SELECT COUNT(*) AS "cantidad" FROM rental;

-- 2. Obtener la suma TOTAL de todos los pagos (payments). Utilizar un alias para
--    mostrarlo en una columna llamada “total”, junto a una columna con la
--    cantidad de alquileres con el alias “Cantidad” y una columna que indique el
--    “Importe promedio” por alquiler.

SELECT SUM(amount) AS "total", COUNT(*) AS "Cantidad", AVG(amount) AS "Importe promedio"
FROM payment;

-- 3. Generar un reporte que responda la pregunta: ¿cuáles son los diez clientes
--    que más dinero gastan y en cuántos alquileres lo hacen?

SELECT SUM(amount) AS "Dinero Gastado", customer_id AS "ID del Cliente", COUNT(rental_id) AS "Cantidad de Rentas"
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 10;

-- 4. Generar un reporte que indique: ID de cliente, cantidad de alquileres y monto
--    total para todos los clientes que hayan gastado más de 150 dólares en
--    alquileres.

SELECT r.customer_id AS "ID de Cliente", COUNT(r.rental_id) AS "Cantidad de Alquileres", SUM(p.amount) AS "Total Gastado"
FROM rental r
INNER JOIN payment p ON r.rental_id = p.rental_id 
GROUP BY r.customer_id
HAVING SUM(p.amount) > 150;

-- 5. Generar un reporte que muestre por mes de alquiler (rental_date de tabla
--    rental), la cantidad de alquileres y la suma total pagada (amount de tabla
--    payment) para el año de alquiler 2005 (rental_date de tabla rental).

SELECT EXTRACT(MONTH FROM r.rental_date) AS "Mes de Alquiler", COUNT(r.rental_id) AS "Cantidad de Alquileres", SUM(p.amount) AS "Suma Total Pagada"
FROM rental r
INNER JOIN payment p ON r.customer_id = p.customer_id
WHERE EXTRACT(YEAR FROM p.payment_date) LIKE "2005"
GROUP BY EXTRACT(MONTH FROM r.rental_date)
ORDER BY "Mes de Alquiler" DESC;

-- 6. Generar un reporte que responda a la pregunta: ¿cuáles son los 5
--    inventarios más alquilados? (columna inventory_id en la tabla rental). Para
--    cada una de ellas indicar la cantidad de alquileres.

SELECT inventory_id AS "ID de Inventario", COUNT(rental_id) AS "Cantidad de Alquileres"
FROM rental
GROUP BY inventory_id
ORDER BY COUNT(rental_id) DESC
LIMIT 5; 