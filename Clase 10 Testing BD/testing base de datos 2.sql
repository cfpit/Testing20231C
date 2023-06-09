-- Testing de Base de Datos Parte 2

create database testingBD;
    
use testingBD;

-- Prueba de carga. Esta prueba consiste en simular una carga de 
-- trabajo típica o esperada en la base de datos y evaluar cómo 
-- responde ante esa carga. Se pueden generar consultas concurrentes, 
-- inserciones masivas de datos o actualizaciones intensivas para medir 
-- el rendimiento y la capacidad de respuesta de la base de datos.
-- Verificar el tiempo que insume la carga de 10000 registros

CREATE TABLE usuarios (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50),
  edad INT,
  email VARCHAR(100)
);

  
DELIMITER //

CREATE PROCEDURE cargar_registros()
BEGIN
  DECLARE contador INT DEFAULT 0;
  DECLARE limite INT DEFAULT 10000;
  DECLARE nombre VARCHAR(50);
  DECLARE edad INT;
  DECLARE email VARCHAR(100);
  
  WHILE contador < limite DO
    -- Generar valores para los campos
    SET nombre = CONCAT('Usuario', contador);
    SET edad = FLOOR(RAND() * 80) + 18;
    SET email = CONCAT('usuario', contador, '@example.com');
  
    -- Insertar registro en la tabla
    INSERT INTO usuarios (nombre, edad, email) VALUES (nombre, edad, email);
  
    -- Incrementar contador
    SET contador = contador + 1;
  END WHILE;
END //

DELIMITER ;

-- Ejecutar el procedimiento almacenado para cargar los registros
CALL cargar_registros();


select * from usuarios limit 10000;





