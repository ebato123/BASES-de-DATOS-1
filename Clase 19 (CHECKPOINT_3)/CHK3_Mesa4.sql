-- CÓDIGO DE CAMADA:  0523TDBD1N1C03LAED0223PT
-- INTEGRANTES: Virginia Balducci, Moro Hernandez, Lucas Machaca, Lucas Melanio, Camila Goñi, Elián Moisés
-- MESA 4

-- DISPOSICIÓN DE CONSULTAS
-- 1-4 Vir
-- 5-8 Cami
-- 9-12 Machaca 
-- 13-17 Moro
-- 18-21 Melanio 
-- 22-25 Elián

-- 1. Listar todos los clientes que tengan tres o más cuentas bancarias. Mostrar el número de cliente, apellido y nombre separado por un espacio dentro de una misma columna denominada "Cliente" y, la cantidad de cuentas que posee.

SELECT CONCAT(cliente.id, ' ', cliente.apellido, ' ', cliente.nombre) AS Cliente, COUNT(cliente_x_cuenta.cuenta_numero) AS Cantidad_Cuentas
FROM cliente
INNER JOIN cliente_x_cuenta ON cliente.id = cliente_x_cuenta.cliente_id
INNER JOIN cuenta ON cliente_x_cuenta.cuenta_numero = cuenta.numero
GROUP BY cliente.id, cliente.apellido, cliente.nombre
HAVING COUNT(cliente_x_cuenta.cuenta_numero) >= 3;
-- Registros: 6

-- 2. Listar todos los clientes que no tengan una cuenta bancaria. Mostrar el número de cliente, apellido y nombre en mayúsculas dentro de una misma columna denominada "Cliente sin cuenta bancaria".
SELECT CONCAT(UPPER(cliente.id), ' ', UPPER(cliente.apellido), ' ', UPPER(cliente.nombre)) AS "Cliente sin cuenta bancaria"
FROM cliente
WHERE cliente.id NOT IN (SELECT cliente_x_cuenta.cliente_id FROM cliente_x_cuenta);
-- Registros: 8

-- 3. Listar todos los clientes que tengan al menos un préstamo que corresponda a la
--    sucursal de la ciudad de "Pilar - Buenos Aires". Se debe mostrar el número de
--    cliente, apellido, nombre, número de préstamo, número de sucursal, nombre de
--    la ciudad y país de dicha sucursal.

SELECT c.id, c.apellido, c.nombre, p.id, s.numero, ci.nombre, pa.nombre
FROM cliente c
INNER JOIN cliente_x_prestamo cp ON c.id = cp.cliente_id
INNER JOIN prestamo p ON cp.prestamo_id = p.id
INNER JOIN sucursal s ON p.sucursal_numero = s.numero
INNER JOIN ciudad ci ON s.ciudad_id = ci.id
INNER JOIN pais pa ON ci.pais_id = pa.id
WHERE ci.nombre = 'Pilar - Buenos Aires'
GROUP BY c.id, c.apellido, c.nombre, p.id, s.numero, ci.nombre, pa.nombre
HAVING COUNT(p.id) >= 1;
-- Registros: 3

-- 4. Listar los clientes que tengan una o más cajas de ahorro y que en la segunda
--    letra de su apellido contenga una "e".

SELECT c.id, c.apellido, c.nombre
FROM cliente c
INNER JOIN cliente_x_cuenta cc ON c.id = cliente_id
INNER JOIN cuenta cu ON cc.cuenta_numero = cu.numero
INNER JOIN cuenta_tipo ct ON cu.cuenta_tipo_id = ct.id
WHERE ct.id = 1 AND SUBSTRING(c.apellido, 2, 1) = 'e';
-- Registros: 5

-- 5. Listar absolutamente todos los países y la cantidad de clientes que tengan.

SELECT cliente.id AS id_cliente, cliente.apellido, cliente.nombre, ciudad.nombre, COUNT(*) AS cantidad_clientes
FROM cliente 
INNER JOIN ciudad ON cliente.ciudad_id = ciudad.id
GROUP BY cliente.id, cliente.apellido, cliente.nombre, ciudad.nombre;
-- Registros: 45

-- 6. Calcular el importe total y la cantidad de préstamos otorgados en el mes de
--    agosto por cada cliente. Mostrar el número de cliente, importe total y cantidad
--    de préstamos.

SELECT cliente.id, SUM(prestamo.importe) AS importe_total, COUNT(prestamo.id) AS cantidad_prestamos
FROM cliente 
INNER JOIN cliente_x_prestamo cxp ON cliente.id = cxp.cliente_id
INNER JOIN prestamo ON cxp.prestamo_id = prestamo.id
WHERE MONTH(prestamo.fecha_otorgado) = 8
GROUP BY cliente.id;
-- Registros: 9

-- 7. Calcular el importe total y la cantidad de cuotas pagadas para el préstamo
--    número cuarenta.

SELECT
prestamo.importe,
COUNT(*) AS cantidad_cuotas_pagadas
FROM
prestamo 
INNER JOIN pago ON prestamo.id = pago.prestamo_id
WHERE
prestamo.id = 40;
-- Registro: 1

-- 8. Determinar el importe restante que falta por pagar para el préstamo número 45.

SELECT
prestamo.importe - SUM(pago.importe) AS importe_restante
FROM
prestamo 
LEFT JOIN pago ON prestamo.id = pago.prestamo_id
WHERE
prestamo.id = 45;
-- Registro: 1

-- 9. Listar los préstamos de la sucursal número cuatro. Mostrar el número de cliente,
-- apellido, nombre y el número de préstamo.

select cliente.id, cliente.nombre, cliente.apellido, prestamo.sucursal_numero
from prestamo 
inner join cliente on prestamo.id = cliente.id
where sucursal_numero = 4;
-- Registros: 4

-- 10. Reportar el número del préstamo y la cantidad de cuotas pagadas por cada uno
-- préstamo. Se debe formatear el dato de la cantidad de cuotas pagadas, por
-- ejemplo, si se ha pagado una cuota, sería "1 cuota paga"; si se han pagado dos o
-- más cuotas, sería en plural "2 cuotas pagas" y "Ninguna cuota paga" para los
-- préstamos que aún no han recibido un pago.

select id,
case
when cantidad_cuota = 0 then 'Ninguna cuota paga'
when cantidad_cuota = 1 then CONCAT(cantidad_cuota, ' cuota paga')
else CONCAT(cantidad_cuota, ' cuotas pagas')
end as estado_cuotas
from
  prestamo;
-- Registros: 47

-- 11. Listar absolutamente todos los empleados y las cuentas bancarias que tengan
-- asociada. Mostrar en una sola columna el apellido y la letra inicial del nombre del
-- empleado (Ej. Tello Aguilera C.), en otra columna, el número de cuenta y el tipo
-- (Ej. 10560 - CAJA DE AHORRO). Los campos nulos deben figurar con la leyenda
-- "Sin asignación".

select CONCAT(apellido, ' ', LEFT(nombre, 1)) as Apellido, cuenta.numero, cuenta_tipo.id, cuenta_tipo.tipo
from empleado
inner join cuenta on empleado.legajo = ejecutivo_cuenta
inner join cuenta_tipo on ejecutivo_cuenta = cuenta_tipo.id;
-- Registros: 3

-- 12. Reportar todos los datos de los clientes y los números de cuenta que tienen.

select *
from cliente
inner join cuenta on cliente.id = cuenta_tipo_id;
-- Registros: 61

-- 13. Listar los clientes con residencia en las ciudades de "Las Heras - Mendoza", "Viña
--     del Mar - Valparaíso", "Córdoba - Córdoba" y "Monroe - Buenos Aires". Se debe
--     mostrar el apellido, nombre del cliente y todos los datos referidos a la ciudad

SELECT c.apellido, c.nombre, ci.*
FROM cliente c
INNER JOIN ciudad ci ON c.ciudad_id = ci.id
WHERE ci.nombre IN ('Las Heras - Mendoza', 'Viña del Mar - Valparaíso', 'Córdoba - Córdoba', 'Monroe - Buenos Aires');
-- Registros: 6

-- 14. Listar los clientes que tienen préstamos otorgados entre 15/08/21 al 5/09/21
--     (ordenarlos por fecha de otorgamiento). Mostrar sólo el email del cliente,
--     teléfono móvil y todos los datos referidos al préstamo.

SELECT c.email, c.telefono_movil, p.*
FROM cliente c
INNER JOIN cliente_x_prestamo cxp ON c.id = cxp.cliente_id
INNER JOIN prestamo p ON cxp.prestamo_id = p.id
WHERE p.fecha_otorgado BETWEEN '2021-08-15' AND '2021-09-05'
ORDER BY p.fecha_otorgado;
-- Registros: 4

-- 15. Listar de manera ordenada, los empleados que no pertenezcan a la sucursal de
--     la ciudad "Monroe - Buenos Aires" y que la fecha de alta del contrato se halle
--     dentro del rango 2016 al 2018. Mostrar el email del empleado, número de
--     sucursal y el nombre de la ciudad 

SELECT e.email, s.numero, c.nombre 
FROM Empleado e
INNER JOIN sucursal s ON e.sucursal_numero = s.numero
INNER JOIN ciudad c ON s.ciudad_id = c.id
WHERE c.nombre != 'Monroe - Buenos Aires' AND YEAR(e.alta_contrato_laboral) BETWEEN 2016 AND 2018
ORDER BY e.email;
-- Registros: 21

-- 16. Listar las cuentas bancarias que tienen dos titulares. Mostrar sólo el número de
--     cuenta y la cantidad de titulares

SELECT cxp.cuenta_numero, COUNT(cxp.cliente_id)
FROM cliente_x_cuenta cxp
GROUP BY cxp.cuenta_numero
HAVING COUNT(cxp.cliente_id) = 2;
-- Registros: 3

-- 17. Se desea conocer el segundo pago con mayor importe efectuado en las
--     sucursales de Chile. Mostrar el número y hora de pago, importe pagado y el
--     nombre del país.

SELECT p.id
FROM pago p
INNER JOIN prestamo pr ON p.prestamo_id = pr.id
INNER JOIN sucursal s ON pr.sucursal_numero = s.numero
INNER JOIN ciudad c ON s.ciudad_id = c.id
INNER JOIN pais ON c.pais_id = pais.id
WHERE pais.nombre = 'Chile'
ORDER BY p.importe DESC
LIMIT 1, 1;
-- Registros: 1

-- 18. Listar los clientes que no tienen préstamos. Mostrar el apellido, nombre y email
--     del cliente.

SELECT apellido, nombre, email
FROM cliente 
LEFT JOIN prestamo ON cliente.id = prestamo.id
WHERE prestamo.id IS NULL;
-- Resultados: 20.

-- 19. Se desea conocer el mes y año en que se terminaría de pagar el préstamo
--     número treinta a partir de la fecha de otorgamiento. Se debe mostrar el email
--     del cliente, número de préstamo, fecha de otorgamiento, importe prestado, mes
--     y año que correspondería a la última cuota (Ej. "agosto de 2021").

SELECT
  c.email,
  p.id AS numero_prestamo,
  p.fecha_otorgado,
  p.importe,
  CONCAT(DATE_FORMAT(ADDDATE(p.fecha_otorgado, INTERVAL p.cantidad_cuota MONTH), '%M'), ' de ', DATE_FORMAT(ADDDATE(p.fecha_otorgado, INTERVAL p.cantidad_cuota MONTH), '%Y')) AS mes_anio_ultima_cuota
FROM
  prestamo p
  INNER JOIN cliente_x_prestamo cp ON p.id = cp.prestamo_id
  INNER JOIN cliente c ON cp.cliente_id = c.id
WHERE
  p.id = 30;
-- Registro: 1

-- 20. Listar las ciudades (sin repetir) que tengan entre dos a cuatro cuentas bancarias.
--     Se debe mostrar el país, ciudad y la cantidad de cuentas. Además, se debe
--     ordenar por país y ciudad.

SELECT
  pa.nombre AS nombre_pais,
  ci.nombre AS nombre_ciudad,
  COUNT(*) AS cantidad_cuentas
FROM
  ciudad ci
  INNER JOIN sucursal s ON ci.id = s.ciudad_id
  INNER JOIN cuenta c ON s.numero = c.sucursal_numero
  INNER JOIN pais pa ON ci.pais_id = pa.id
GROUP BY
  pa.nombre,
  ci.nombre
HAVING
  cantidad_cuentas BETWEEN 2 AND 4
ORDER BY
  pa.nombre,
  ci.nombre;
-- Registros: 15

-- 21. Mostrar el nombre, apellido, número de cuenta de todos los clientes que poseen
--     una cuenta tipo "CAJA DE AHORRO", cuyo saldo es mayor que $ 15000

SELECT cliente.nombre, cliente.apellido, cuenta.numero FROM cliente
INNER JOIN cliente_x_cuenta ON cliente.id = cliente_x_cuenta.cliente_id
INNER JOIN cuenta ON cuenta.numero = cliente_x_cuenta.cuenta_numero
INNER JOIN cuenta_tipo ON cuenta.cuenta_tipo_id = cuenta_tipo.id
WHERE cuenta_tipo.tipo = "CAJA DE AHORRO" AND cuenta.saldo > 15000;
-- Resultados: 9.

-- 22. Por cada sucursal, contar la cantidad de clientes y el saldo promedio de sus
--     cuentas.

SELECT s.numero AS "Número de Sucursal", COUNT(c.id) AS "Cantidad de Clientes", AVG(cu.saldo) AS "Saldo Promedio"
FROM cliente c
INNER JOIN cliente_x_cuenta cxc ON c.id = cxc.cliente_id
INNER JOIN cuenta cu ON cxc.cuenta_numero = cu.numero
INNER JOIN sucursal s ON cu.sucursal_numero = s.numero
GROUP BY s.numero;
-- Registros: 21

-- 23. Listar todos aquellos clientes que teniendo un saldo negativo en la cuenta,
--     tengan un descubierto otorgado mayor a cero. Mostrar el apellido, nombre,
--     saldo y descubierto otorgado.

SELECT c.apellido, c.nombre, cu.saldo, cu.descubierto_otorgado
FROM cliente c
INNER JOIN cliente_x_cuenta cxc ON c.id = cxc.cliente_id
INNER JOIN cuenta cu ON cxc.cuenta_numero = cu.numero
WHERE cu.saldo < 0
AND cu.descubierto_otorgado > 0;
-- Registros: 7

-- 24. Se desea conocer el último acceso de cada cliente al sistema. Mostrar el nombre,
--     apellido y última fecha de acceso.

SELECT c.nombre, c.apellido, ha.acceso
FROM cliente c
INNER JOIN historial_acceso ha ON c.id = ha.cliente_id
ORDER BY c.nombre, c.apellido, ha.acceso DESC;
-- Registros: 236

-- 25. Listar el apellido y nombre de todos los empleados del banco. Si poseen cuentas
--     a cargo, mostrar cuántas. Ordenar por apellido y nombre.

SELECT e.apellido, e.nombre, COUNT(c.numero)
FROM empleado e
LEFT JOIN cuenta c ON e.legajo = c.ejecutivo_cuenta
GROUP BY e.legajo
ORDER BY e.apellido, e.nombre;
-- Registros: 50






