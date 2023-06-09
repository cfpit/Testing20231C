-- Testing de Base de Datos
    create database testingBD;
    
    use testingBD;
    
/*
	1 - Verificación de restricciones de integridad: MySQL permite definir restricciones 
    de integridad, como claves primarias, claves foráneas y restricciones únicas. Podemos 
    realizar pruebas para verificar que estas restricciones se estén aplicando 
    correctamente en la base de datos. Tambien es posible ejecutar consultas para comprobar 
    que no existan valores duplicados en una columna con restricción única.
*/

-- a) Ejemplo que cumple 
CREATE TABLE usuarios_cumple (
  id INT PRIMARY KEY,
  email VARCHAR(50) UNIQUE,
  nombre VARCHAR(50)
);

INSERT INTO usuarios_cumple (id, email, nombre)
VALUES
  (1, 'usuario1@example.com', 'Usuario 1'),
  (2, 'usuario2@example.com', 'Usuario 2');

-- En esta tabla, la columna email tiene la restricción UNIQUE, lo que garantiza que no 
-- haya valores duplicados.

-- b) Ejemplo que no cumple
CREATE TABLE usuarios_no_cumple (
  id INT PRIMARY KEY,
  email VARCHAR(50),
  nombre VARCHAR(50)
);

INSERT INTO usuarios_no_cumple (id, email, nombre)
VALUES
  (1, 'usuario1@example.com', 'Usuario 1'),
  (2, 'usuario1@example.com', 'Usuario 2');

-- En esta tabla, la columna email no tiene la restricción UNIQUE y se insertan valores 
-- duplicados ('usuario1@example.com').

-- Verificacion tabla "usuarios_cumple"
SELECT email, COUNT(*) FROM usuarios_cumple GROUP BY email HAVING COUNT(*) > 1;

-- Verificacion tabla "usuarios_no_cumple"
SELECT email, COUNT(*) FROM usuarios_no_cumple GROUP BY email HAVING COUNT(*) > 1;

-- En la tabla "usuarios_cumple", la consulta no devolverá ningún resultado, lo que indica 
-- que no hay valores duplicados en la columna email y la restricción UNIQUE se está 
-- cumpliendo.

-- En la tabla "usuarios_no_cumple", la consulta devolverá un resultado con el valor 
-- 'usuario1@example.com' y una cuenta de 2, lo que indica que hay valores duplicados en la 
-- columna email y la restricción UNIQUE no se está cumpliendo.


/*
	2- Pruebas de relaciones entre tablas: Si la base de datos utiliza claves foráneas para 
    establecer relaciones entre tablas, es importante verificar que estas relaciones se 
    cumplan. Podemos realizar pruebas ejecutando consultas que involucren múltiples tablas 
    y verificando que los registros relacionados existan y sean coherentes.
*/

-- a) Tabla "ordenes_cumple" y "productos_cumple":

CREATE TABLE productos_cumple (
  id INT PRIMARY KEY,
  nombre VARCHAR(50),
  precio DECIMAL(10, 2)
);

CREATE TABLE ordenes_cumple (
  id INT PRIMARY KEY,
  producto_id INT,
  cantidad INT,
  FOREIGN KEY (producto_id) REFERENCES productos_cumple(id)
);

INSERT INTO productos_cumple (id, nombre, precio)
VALUES
  (1, 'Producto 1', 10.00),
  (2, 'Producto 2', 20.00);

INSERT INTO ordenes_cumple (id, producto_id, cantidad)
VALUES
  (1, 1, 5),
  (2, 2, 3);


-- La tabla "ordenes_cumple" tiene una columna "producto_id" que hace referencia a la 
-- columna "id" de la tabla "productos_cumple". Se han insertado órdenes que están 
-- correctamente relacionadas con productos existentes.

-- b) Tabla "ordenes_no_cumple" y "productos_no_cumple":

CREATE TABLE productos_no_cumple (
  id INT PRIMARY KEY,
  nombre VARCHAR(50),
  precio DECIMAL(10, 2)
);

CREATE TABLE ordenes_no_cumple (
  id INT PRIMARY KEY,
  producto_id INT,
  cantidad INT,
  FOREIGN KEY (producto_id) REFERENCES productos_no_cumple(id)
);

INSERT INTO productos_no_cumple (id, nombre, precio)
VALUES
  (1, 'Producto 1', 10.00),
  (2, 'Producto 2', 20.00);

INSERT INTO ordenes_no_cumple (id, producto_id, cantidad)
VALUES
  (1, 1, 5),
  (2, 3, 3);

-- La tabla "ordenes_no_cumple" también tiene una columna "producto_id" que hace 
-- referencia a la columna "id" de la tabla "productos_no_cumple". Sin embargo, en 
-- la segunda inserción se intenta relacionar una orden con un producto que no existe 
-- en la tabla "productos_no_cumple".


-- Verificamos tabla "ordenes_cumple"
SELECT 		o.id 
FROM 		ordenes_cumple o 
LEFT JOIN 	productos_cumple p ON o.producto_id = p.id 
WHERE 		p.id IS NULL;

-- Verificamos tabla "ordenes_no_cumple"
SELECT 		o.id 
FROM 		ordenes_no_cumple o 
LEFT JOIN 	productos_no_cumple p ON o.producto_id = p.id 
WHERE 		p.id IS NULL;


/*
	3- Verificación de integridad referencial: MySQL permite definir restricciones de 
    integridad referencial para mantener la coherencia de los datos relacionados. Es posible 
    realizar pruebas para asegurarse que estas restricciones se estén aplicando 
    correctamente. Podemos intentar eliminar un registro principal y verificar que se 
    produzca un error si existen registros secundarios relacionados.
*/

-- a) Tabla "departamentos_cumple" y "empleados_cumple":

CREATE TABLE departamentos_cumple (
  id INT PRIMARY KEY,
  nombre VARCHAR(50)
);

CREATE TABLE empleados_cumple (
  id INT PRIMARY KEY,
  nombre VARCHAR(50),
  departamento_id INT,
  FOREIGN KEY (departamento_id) REFERENCES departamentos_cumple(id)
);

INSERT INTO departamentos_cumple (id, nombre)
VALUES
  (1, 'Departamento 1'),
  (2, 'Departamento 2');

INSERT INTO empleados_cumple (id, nombre, departamento_id)
VALUES
  (1, 'Empleado 1', 1),
  (2, 'Empleado 2', 2);

-- La tabla "empleados_cumple" tiene una columna "departamento_id" que hace referencia a la 
-- columna "id" de la tabla "departamentos_cumple". Se han insertado empleados que están 
-- correctamente relacionados con departamentos existentes.

-- b) Tabla "departamentos_no_cumple" y "empleados_no_cumple":

CREATE TABLE departamentos_no_cumple (
  id INT PRIMARY KEY,
  nombre VARCHAR(50)
);

CREATE TABLE empleados_no_cumple (
  id INT PRIMARY KEY,
  nombre VARCHAR(50),
  departamento_id INT,
  FOREIGN KEY (departamento_id) REFERENCES departamentos_no_cumple(id)
);

INSERT INTO departamentos_no_cumple (id, nombre)
VALUES
  (1, 'Departamento 1'),
  (2, 'Departamento 2');

INSERT INTO empleados_no_cumple (id, nombre, departamento_id)
VALUES
  (1, 'Empleado 1', 1),
  (2, 'Empleado 2', 3);

-- La tabla "empleados_no_cumple" también tiene una columna "departamento_id" que hace 
-- referencia a la columna "id" de la tabla "departamentos_no_cumple". Sin embargo, en la 
-- segunda inserción se intenta relacionar un empleado con un departamento que no existe 
-- en la tabla "departamentos_no_cumple".

-- Verificamos la integridad referencial:

-- En la tabla "empleados_cumple"
DELETE FROM departamentos_cumple WHERE id = 1;

-- En la tabla "empleados_no_cumple"
DELETE FROM departamentos_no_cumple WHERE id = 1;

-- En la tabla "empleados_cumple", si intentamos eliminar el departamento con ID 1, se 
-- producirá un error indicando que la operación viola la restricción de integridad 
-- referencial, lo cual demuestra que la integridad referencial se cumple.

-- En la tabla "empleados_no_cumple", si intentamos eliminar el departamento con ID 1, 
-- la operación se realizará sin errores, lo que indica que la integridad referencial 
-- no se cumple y no se está aplicando correctamente la restricción de integridad 
-- referencial.


/*
	4- Pruebas de validación de datos: Si tenemos reglas de validación definidas en nuestra 
    base de datos, como formatos de fecha, rangos de valores, restricciones de longitud, 
    etc., podemos realizar pruebas para asegurarnos que estas reglas se estén aplicando. 
    Insertemos datos que no cumplan con las reglas de validación y verifiquemos que se 
    produzcan errores o excepciones.
*/

-- La tabla "clientes" con la columna "fecha_nacimiento" que debe estar en el formato 
-- "AAAA-MM-DD" en dos escenarios diferentes, uno donde se cumple la validación de datos y 
-- otro donde no se cumple:

-- a) Tabla "clientes_cumple":

CREATE TABLE clientes_cumple (
  id INT PRIMARY KEY,
  nombre VARCHAR(50),
  fecha_nacimiento DATE CHECK (fecha_nacimiento REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$')
);

INSERT INTO clientes_cumple (id, nombre, fecha_nacimiento)
VALUES
  (1, 'Cliente 1', '1990-05-15'),
  (2, 'Cliente 2', '1985-11-30');

-- La tabla "clientes_cumple" con la columna "fecha_nacimiento" de tipo DATE y se aplica 
-- una validación de datos utilizando la cláusula CHECK y una expresión regular para 
-- asegurarse de que la fecha esté en el formato correcto ("AAAA-MM-DD"). Se han insertado 
-- clientes con fechas de nacimiento que cumplen con el formato establecido.

-- b) Tabla "clientes_no_cumple":

CREATE TABLE clientes_no_cumple (
  id INT PRIMARY KEY,
  nombre VARCHAR(50),
  fecha_nacimiento DATE CHECK (fecha_nacimiento REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$')
);

INSERT INTO clientes_no_cumple (id, nombre, fecha_nacimiento)
VALUES
  (1, 'Cliente 1', '15-05-1990'),
  (2, 'Cliente 2', '1985-11-30');

-- Creamos la tabla "clientes_no_cumple" con la misma validación  de datos en la columna 
-- "fecha_nacimiento". Sin embargo, en la primera inserción se utiliza una fecha con formato 
-- incorrecto ("15-05-1990") que no cumple con la expresión regular establecida.

-- Verificamos tabla "clientes_cumple"
SELECT 	* 
FROM 	clientes_cumple;


-- En la tabla "clientes_cumple", la consulta no devolverá ningún resultado, lo que indica 
-- que todas las fechas de nacimiento están en el formato correcto ("AAAA-MM-DD") y la 
-- validación de datos se cumple.

-- En la tabla "clientes_no_cumple", la consulta devolverá un resultado con el valor 
-- '1990/05/15' en la columna "fecha_nacimiento", lo que indica que hay una fecha de 
-- nacimiento en un formato incorrecto y la validación de datos no se cumple.


/*
	5- Verificación de cálculos y agregaciones: Si nuestra base de datos realiza cálculos 
    o agregaciones de datos, podemos realizar pruebas para asegurarnos que los resultados 
    son los esperados. Ejecutemos consultas y comparemos los resultados esperados con los 
    obtenidos.
*/

-- En este ejemplo creamos la tabla "ventas" con la columna "monto" que registra el monto 
-- de cada venta en dos escenarios diferentes, uno donde se cumple la verificación de 
-- cálculos y agregaciones y otro donde no se cumple:

-- a) Tabla "ventas_cumple":

CREATE TABLE ventas_cumple (
  id INT PRIMARY KEY,
  monto DECIMAL(10, 2) check(monto >= 1000),
  fecha DATE
);

INSERT INTO ventas_cumple (id, monto, fecha)
VALUES
  (1, 1550.00, '2023-05-15'),
  (2, 1700.00, '2023-05-20');

-- Se crea la tabla "ventas_cumple" con la columna "monto" de tipo DECIMAL(10, 2), que 
-- permite almacenar valores monetarios con dos decimales. Se han insertado ventas con 
-- montos válidos y coherentes.

-- b) Tabla "ventas_no_cumple":

CREATE TABLE ventas_no_cumple (
  id INT PRIMARY KEY,
  monto DECIMAL(10, 2) check(monto >= 1000),
  fecha DATE
);

INSERT INTO ventas_no_cumple (id, monto, fecha)
VALUES
  (1, 500.00, '2023-05-15'),
  (2, 1200.00, '2023-05-20');


-- También se crea la tabla "ventas_no_cumple" con la columna "monto" de tipo DECIMAL(10, 2), 
-- pero se insertan valores de monto que no cumplen con las restricciones o no son coherentes.

-- Verificamos tabla "ventas_cumple"
SELECT SUM(monto) AS total_ventas FROM ventas_cumple;

-- Verificamos tabla "ventas_no_cumple"
SELECT SUM(monto) AS total_ventas FROM ventas_no_cumple;

-- En la tabla "ventas_cumple", la consulta devolverá el total de ventas correctamente 
-- calculado a partir de la suma de los montos registrados.

-- En la tabla "ventas_no_cumple", la consulta también devolverá el total de ventas, pero 
-- puede haber problemas si los montos no cumplen con las restricciones o no son coherentes. 
-- Por ejemplo, un monto negativo o un monto excesivamente alto pueden afectar los cálculos 
-- y agregaciones.

-- Es importante asegurarse de que los valores de monto sean válidos y coherentes para 
-- garantizar que los cálculos y agregaciones sean correctos.


/*	
	6- Pruebas de actualizaciones y transacciones: Si nuestra aplicación realiza operaciones 
    de actualización en la base de datos, es importante probar la integridad de los datos 
    en situaciones de actualizaciones concurrentes o en el contexto de transacciones. Podemos
    crear escenarios de prueba simulando múltiples usuarios o aplicaciones realizando 
    operaciones simultáneas y verifiquemos que los datos se mantengan consistentes.
*/

-- En este ejemplo creamos la tabla "inventario" que registra la cantidad de productos 
-- disponibles en dos escenarios diferentes, uno donde se cumple la prueba de actualizaciones 
-- y transacciones y otro donde no se cumple:

-- a) Tabla "inventario_cumple":

CREATE TABLE inventario_cumple (
  id INT PRIMARY KEY,
  producto VARCHAR(50),
  cantidad INT check (cantidad between 0 and 150)
);

INSERT INTO inventario_cumple (id, producto, cantidad)
VALUES
  (1, 'Producto 1', 50),
  (2, 'Producto 2', 100);

-- Se crea la tabla "inventario_cumple" con la columna "cantidad" que registra la 
-- cantidad de productos disponibles. Se han insertado registros con cantidades válidas.

-- b) Tabla "inventario_no_cumple":

CREATE TABLE inventario_no_cumple (
  id INT PRIMARY KEY,
  producto VARCHAR(50),
  cantidad INT check (cantidad between 0 and 150)
);

INSERT INTO inventario_no_cumple (id, producto, cantidad)
VALUES
  (1, 'Producto 1', -10),
  (2, 'Producto 2', 200);

-- También se crea la tabla "inventario_no_cumple", pero se insertan valores de cantidad que 
-- no cumplen con las restricciones o no son coherentes. Por ejemplo, una cantidad negativa 
-- o una cantidad excesivamente alta pueden afectar la integridad de los datos.

-- Para realizar pruebas de actualizaciones y transacciones, puedes ejecutar consultas que 
-- modifiquen los registros del inventario. Por ejemplo:

-- Escenario "inventario_cumple"
START TRANSACTION;
UPDATE inventario_cumple SET cantidad = cantidad - 10 WHERE id = 1;
UPDATE inventario_cumple SET cantidad = cantidad + 5 WHERE id = 2;
COMMIT;

-- En el escenario "inventario_cumple", las actualizaciones se realizarán correctamente, y 
-- la cantidad de productos se modificará en función de las operaciones especificadas.



