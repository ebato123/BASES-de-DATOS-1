-- Parte 1:
-- ¡Estos reportes ya los conoces! Pero te pedimos que en este caso no utilices los
-- identificadores, sino que los reemplaces por su correspondiente descripción. Para
-- esto, vas a tener que realizar JOINS.
-- Por ejemplo, si quiero mostrar un reporte de películas más alquiladas, en lugar de
-- mostrar el ID de película, debemos mostrar el título.

-- Manos a la obra:

-- 1. Generar un reporte que responda la pregunta: ¿cuáles son los diez clientes
--    que más dinero gastan y en cuantos alquileres lo hacen?

SELECT CONCAT(cu.first_name, " ", cu.last_name) AS client, COUNT(p.customer_id) rentals
FROM customer cu
INNER JOIN payment p ON p.customer_id = cu.customer_id
GROUP BY cu.customer_id
ORDER BY SUM(p.amount) DESC
LIMIT 10;

-- 2. Generar un reporte que indique: el id del cliente, la cantidad de alquileres y
--    el monto total para todos los clientes que hayan gastado más de 150 dólares
--    en alquileres.

SELECT cu.customer_id, COUNT(p.customer_id) AS rentals, SUM(p.amount) AS total_amount
FROM customer cu
INNER JOIN payment p ON cu.customer_id = p.customer_id
GROUP BY cu.customer_id
HAVING total_amount > 150;

-- 3. Generar un reporte que responda a la pregunta: ¿cómo se distribuyen la
--    cantidad y el monto total de alquileres en los meses pertenecientes al año
--    2005? (tabla payment).

SELECT COUNT(customer_id) AS customers, SUM(amount) AS total_amount, MONTH(payment_date) AS month
FROM payment 
WHERE YEAR(payment_date) = 2005
GROUP BY MONTH(payment_date);

-- 4. Generar un reporte que responda a la pregunta: ¿cuáles son los 5 inventarios
--    más alquilados? (columna inventory_id en la tabla rental) Para cada una de
--    ellas, indicar la cantidad de alquileres.

SELECT inventory_id, COUNT(customer_id) AS rental_count
FROM rental
GROUP BY inventory_id
ORDER BY rental_count DESC
LIMIT 5;

-- COMENTARIO: No puse un criterio de desempate, me guié en la cantidad de clientes
--             que alquilaron el mismo inventario para saber cuáles fueron los más
--             alquilados, y lo limité a 5 registros de forma DESCENDENTE (+ a -).

-- Parte 2:
-- 1. Generar un reporte que responda a la pregunta: Para cada tienda
--    (store), ¿cuál es la cantidad de alquileres y el monto total del dinero
--    recaudado por mes?

SELECT sto.store_id, COUNT(r.rental_id) AS rentals, SUM(p.amount) AS total_amount, MONTH(payment_date) as month
FROM store sto
INNER JOIN inventory i ON i.store_id = sto.store_id
INNER JOIN rental r ON r.inventory_id = i.inventory_id
INNER JOIN payment p ON p.rental_id = r.rental_id
GROUP BY sto.store_id, MONTH(payment_date)
ORDER BY sto.store_id, month;

-- 2. Generar un reporte que responda a la pregunta: ¿cuáles son las 10 películas
--    que generan más ingresos? ¿ Y cuáles son las que generan menos ingresos?
--    Para cada una de ellas indicar la cantidad de alquileres.

SELECT f.title, COUNT(r.rental_id) AS rentals
FROM payment p
INNER JOIN rental r ON r.rental_id = p.rental_id
INNER JOIN inventory i ON i.inventory_id = r.inventory_id
INNER JOIN film f ON f.film_id = i.film_id
GROUP BY f.film_id
ORDER BY SUM(p.amount) DESC
LIMIT 10;

-- Para saber cuáles son las películas que generan menos ingresos:
-- En el ORDER BY cambiamos el DESC por ASC.

-- 3. ¿Existen clientes que no hayan alquilado películas?

SELECT cu.customer_id, COUNT(r.rental_id) AS rentals
FROM customer cu
LEFT JOIN rental r ON r.customer_id = cu.customer_id
GROUP BY cu.customer_id
HAVING rentals IS NULL;

-- RESPUESTA: NO, todos los clientes han alquilado películas.
--            El cliente que menos películas ha alquilado 
--            tiene al menos 12 alquileres.

-- 4. Nivel avanzado: El jefe de stock quiere discontinuar las películas (film) con
--    menos alquileres (rental). ¿Qué películas serían candidatas a discontinuar?
--    Recordemos que pueden haber películas con 0 (Cero) alquileres.

SELECT f.title, COUNT(r.customer_id) AS rentals
FROM film f
LEFT JOIN inventory i ON i.film_id = f.film_id
LEFT JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY f.film_id
ORDER BY rentals ASC;




