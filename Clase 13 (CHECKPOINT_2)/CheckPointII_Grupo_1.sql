-- Código Camada: 0523TDBD1N1C03LAED0223PT
-- Mesa 1
-- INTEGRANTES: Elián Moisés, Enzo Carossi, Santiago Gonzalez, Elton Armelini, Toto Camiña
-- BASE de DATOS: Chekpoint II

-- (1) Listar todos los clientes cuyo nombre comience con la letra "A". 
-- Se debe mostrar id como "Número de cliente", apellido y nombre

SELECT id as "Número de cliente", apellido, nombre FROM cliente
WHERE nombre LIKE "A%";

-- Cantidad de Registros: 5 

-- (2) Mostrar el número de la sucursal con domicilio "Ramón Freire Serrano 7410"

SELECT numero FROM sucursal
WHERE domicilio = "Ramón Freire Serrano 7410";

-- Cantidad de Registros: 1 

-- (3) Se requiere saber cuál es el mayor importe prestado

SELECT MAX(importe) FROM prestamo;

-- Cantidad de Registros: 1

-- (4) Listar los pagos realizados con números 10, 14, 27, 45

SELECT importe FROM pago
WHERE id IN(10, 14, 27, 45);

-- Cantidad de Registros: 4

-- (5) Calcular el total de los pagos realizados para el préstamo número cuarenta. El
-- reporte debe tener dos columnas denominadas "Número de préstamo" y el
-- "Total pagado".

SELECT id AS "Número de préstamo", importe AS "Total Pagado" FROM prestamo
WHERE id = 40;

-- Cantidad de Registros: 1

-- (6) Listar los empleados que no pertenezcan a la sucursal dos y que la fecha de alta
-- del contrato sea mayor que 5/09/21 o igual a 25/06/21. Ordenar por alta de
-- contrato.

SELECT * FROM empleado
WHERE sucursal_numero != 2 AND alta_contrato_laboral > "2021-09-05" OR alta_contrato_laboral = "2021-06-25"
ORDER BY alta_contrato_laboral DESC;

-- Cantidad de Registros: 3

-- (7) Listar los pagos realizados con importe entre $1030,25 a $1666,66 
-- (ordenarlos por el importe pagado de mayor a menor).

SELECT * FROM pago
WHERE importe BETWEEN 1030.25 AND 1666.66
ORDER BY importe DESC;

-- Cantidad de Registros: 14

-- (8) Mostrar el quinto pago realizado con menor importe.

SELECT * FROM pago
WHERE importe 
ORDER BY importe DESC
LIMIT 4,1;
-- Cantidad de Registros: 1

-- (9)   Mostrar el préstamo con mayor importe. Este reporte debe contener el número
-- del préstamo, la fecha de otorgamiento y el importe.
SELECT id as 'Numero de Prestamo',fecha_otorgado AS 'fecha de otorgamiento',importe FROM prestamo
ORDER BY  importe DESC
LIMIT 1; 
-- Cantidad de Registros: 1


-- (10) 
-- Mostrar las diez cuentas bancarias con menor saldo. Este reporte debe contener
-- el número de cuenta, saldo y el código del tipo de cuenta.
SELECT numero AS 'Numero de Cuenta', saldo, cuenta_tipo_id as 'Codigo del tipo de cuenta' 
FROM cuenta 
ORDER BY saldo ASC
LIMIT 10; 
-- Cantidad de Registros: 10


-- (11) 
-- Listar los préstamos otorgados entre 10/07/21 al 10/08/21 (ordenarlos por fecha
-- de otorgamiento)
SELECT * FROM prestamo 
WHERE fecha_otorgado BETWEEN
'2021-07-10' AND
'2021-08-10';
-- Cantidad de Registros: 10


-- (12) 
-- Listar en forma ordenada las cuentas bancarias que tengan un descubierto
-- otorgado superior o igual a $8999,80.
SELECT * FROM cuenta
WHERE descubierto_otorgado >= 8999.80
ORDER BY descubierto_otorgado;
-- Cantidad de Registros: 10

-- (13) 
-- Listar todos los empleados cuyo apellido termine con los caracteres "do". Se
-- debe mostrar el legajo, apellido, nombre y email.
SELECT legajo, apellido, nombre, email FROM empleado
WHERE apellido 
LIKE "%do";
-- Cantidad de Registros: 4


-- (14) 
-- Se desea conocer cuál es el promedio de los saldos de las cajas de ahorro
SELECT AVG(cuenta.saldo) FROM cuenta,cuenta_tipo
WHERE cuenta_tipo.tipo = "CAJA DE AHORRO"; 
-- Cantidad de Registros: 1


-- (15) 
SELECT * FROM prestamo
ORDER BY importe DESC
LIMIT 2,1;
-- Cantidad de Registros: 1


-- (16) 
-- Calcular la cantidad de cuentas que tiene la sucursal número cinco. El reporte
-- debe tener dos columnas denominadas "Sucursal" y el "Cantidad de Cuentas".
SELECT sucursal_numero AS 'Sucursal',COUNT(*) AS 'Cantidad de Cuentas'
FROM cuenta
GROUP BY sucursal_numero  
HAVING sucursal_numero = 5;
-- Cantidad de Registros: 1


-- (17) 
-- Mostrar todas las ciudades que contengan una palabra de cinco caracteres, pero
-- el tercer carácter debe ser igual a "n".
SELECT * 
FROM el_descubierto.ciudad
WHERE nombre
LIKE '__n%';
-- Cantidad de Registros: 16


-- (18)
-- Modificar el tipo de cuenta bancaria "Cuenta Corriente" a "Cuenta Especial"
UPDATE cuenta_tipo
SET tipo = 'CUENTA ESPECIAL'
WHERE id = 2; -- Se decidio poner el id en lugar del string(tipo) porque nos de devulve excepcion de unsafe query
-- Cantidad de Registros Afectados: 1
 

-- (19) 
-- En la fecha de hoy, agregar en la sucursal número nueve al empleado Quinteros
-- Arias Raúl Alejandro con domicilio en Av. 25 de mayo 7410 - Pilar - Buenos Aires,
-- mail: quiteros2021bs@gmail.com, teléfono móvil: '+5491154000745'.
INSERT INTO empleado
VALUES (DEFAULT,9,'Quinteros Arias', 'Raúl Alejandro','Av. 25 de mayo 7410',14,'quiteros2021bs@gmail.com','+5491154000745',CURDATE());
-- Cantidad de Registros Insertados: 1


-- (20)
DELETE FROM prestamo 
WHERE id = 45;
-- Cantidad de Registros Afectados: 1


-- (21) 
-- Mostrar el importe total prestado por el banco a sus clientes.
SELECT SUM(importe) AS 'Total prestado por el Banco' FROM prestamo;
-- Cantidad de Registros: 1


-- (23) 
-- Mostrar la cantidad total de cuentas activas que están registradas en el banco.
SELECT COUNT(*) AS 'Cuentas Activas' 
FROM cuenta
WHERE activa = 1;
-- Cantidad de Registros: 58

-- (23)
-- Mostrar el apellido y la cantidad de clientes que poseen el mismo apellido.
SELECT apellido,COUNT(*),idpais AS 'CANTIDAD'
FROM cliente
GROUP BY apellido
HAVING COUNT(apellido) > 1;
-- Cantidad de Registros: 3


-- (24) 
-- Mostrar el id del país y la cantidad de ciudades que posee cada uno de ellos.
SELECT  pais_id, COUNT(*) AS 'Cantidad de Ciudades'
FROM ciudad
GROUP BY pais_id;
-- Cantidad de Registros: 5


-- (25) 
-- Necesitamos saber la cantidad de préstamos por sucursal y día otorgado. ¿Hay
-- sucursales que hayan realizado más de un préstamo el mismo día?
SELECT sucursal_numero AS 'Numero de Sucursal',fecha_otorgado AS 'Fecha',COUNT(*) AS 'Cantidad de Prestamos otorgados'
FROM prestamo
GROUP BY sucursal_numero,fecha_otorgado;
