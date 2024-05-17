-- DROP KEYSPACE Clientes;
CREATE KEYSPACE Clientes WITH REPLICATION ={'class': 'SimpleStrategy', 'replication_factor':1};

-- Paso 1: Modela las tablas necesarias para resolver las consultas.

-- Q1: Devolver los datos de los clientes que tengan menos de 25 años de una zona dada
CREATE TABLE Clientes.edad_zona (
                                    nombre text,
                                    apellidos text,
                                    email text,
                                    edad int,
                                    zona text,
                                    PRIMARY KEY ((edad,zona), nombre)
                                );

-- Q2: Devolver todos los datos de un cliente a partir de su e-mail
CREATE TABLE Clientes.email (
                                nombre text,
                                apellidos text,
                                email text,
                                edad int,
                                zona text,
                                PRIMARY KEY ((email), nombre)
                            );

-- Q3: Devolver el número de clientes que hay en una zona dada
-- Q4: Devolver todos los datos del cliente de mayor edad de una zona dada
-- Q5: Calcular la media de edad de los clientes de una zona dada
CREATE TABLE Clientes.zona(
                              nombre text,
                              apellidos text,
                              email text,
                              edad int,
                              zona text,
                              PRIMARY KEY ((zona), nombre));

/*
    Q6: Devolver los datos de los clientes de una zona dada cuyo nombre coincida con un
    determinado valor, ordenados alfabéticamente por apellidos
*/
CREATE TABLE Clientes.nombre_zona(
                                     nombre text,
                                     apellidos text,
                                     email text,
                                     edad int,
                                     zona text,
                                     PRIMARY KEY ((nombre,zona),apellidos));

-- Q7: Devolver los datos de los clientes de una edad y nombre dados
CREATE TABLE Clientes.nombre_edad(
                                     nombre text,
                                     apellidos text,
                                     email text,
                                     edad int,
                                     zona text,
                                     PRIMARY KEY ((edad,nombre), apellidos)
                                 );

-- Paso 2: Inserta los datos de ejemplo proporcionados en el enunciado.

-- Q1: Devolver los datos de los clientes que tengan menos de 25 años de una zona dada
INSERT INTO Clientes.edad_zona(nombre, apellidos, email, edad, zona) VALUES ('Juan', 'Martínez', 'juan@email.com', 18, 'Norte');
INSERT INTO Clientes.edad_zona(nombre, apellidos, email, edad, zona) VALUES ('María', 'García', 'maria@email.com', 25, 'Sur');
INSERT INTO Clientes.edad_zona(nombre, apellidos, email, edad, zona) VALUES ('Domingo', ' ', 'domingo@email.com', 32, 'Norte');
INSERT INTO Clientes.edad_zona(nombre, apellidos, email, edad, zona) VALUES ('Roberto', 'Luján', 'roberto@email.com', 21, 'Norte');
INSERT INTO Clientes.edad_zona(nombre, apellidos, email, edad, zona) VALUES ('Mario', 'García', 'mario@email.com', 25, 'Sur');

-- Q2: Devolver todos los datos de un cliente a partir de su e-mail
INSERT INTO Clientes.email(nombre, apellidos, email, edad, zona) VALUES ('Juan', 'Martínez', 'juan@email.com', 18, 'Norte');
INSERT INTO Clientes.email(nombre, apellidos, email, edad, zona) VALUES ('María', 'García', 'maria@email.com', 25, 'Sur');
INSERT INTO Clientes.email(nombre, apellidos, email, edad, zona) VALUES ('Domingo', ' ', 'domingo@email.com', 32, 'Norte');
INSERT INTO Clientes.email(nombre, apellidos, email, edad, zona) VALUES ('Roberto', 'Luján', 'roberto@email.com', 21, 'Norte');
INSERT INTO Clientes.email(nombre, apellidos, email, edad, zona) VALUES ('Mario', 'García', 'mario@email.com', 25, 'Sur');


-- Q3: Devolver el número de clientes que hay en una zona dada
-- Q4: Devolver todos los datos del cliente de mayor edad de una zona dada
-- Q5: Calcular la media de edad de los clientes de una zona dada
INSERT INTO Clientes.zona(nombre, apellidos, email, edad, zona) VALUES ('Juan', 'Martínez', 'juan@email.com', 18, 'Norte');
INSERT INTO Clientes.zona(nombre, apellidos, email, edad, zona) VALUES ('María', 'García', 'maria@email.com', 25, 'Sur');
INSERT INTO Clientes.zona(nombre, apellidos, email, edad, zona) VALUES ('Domingo', ' ', 'domingo@email.com', 32, 'Norte');
INSERT INTO Clientes.zona(nombre, apellidos, email, edad, zona) VALUES ('Roberto', 'Luján', 'roberto@email.com', 21, 'Norte');
INSERT INTO Clientes.zona(nombre, apellidos, email, edad, zona) VALUES ('Mario', 'García', 'mario@email.com', 25, 'Sur');

/*
    Q6: Devolver los datos de los clientes de una zona dada cuyo nombre coincida con un
    determinado valor, ordenados alfabéticamente por apellidos
*/
INSERT INTO Clientes.nombre_zona(nombre, apellidos, email, edad, zona) VALUES ('Juan', 'Martínez', 'juan@email.com', 18, 'Norte');
INSERT INTO Clientes.nombre_zona(nombre, apellidos, email, edad, zona) VALUES ('María', 'García', 'maria@email.com', 25, 'Sur');
INSERT INTO Clientes.nombre_zona(nombre, apellidos, email, edad, zona) VALUES ('Domingo', ' ', 'domingo@email.com', 32, 'Norte');
INSERT INTO Clientes.nombre_zona(nombre, apellidos, email, edad, zona) VALUES ('Roberto', 'Luján', 'roberto@email.com', 21, 'Norte');
INSERT INTO Clientes.nombre_zona(nombre, apellidos, email, edad, zona) VALUES ('Mario', 'García', 'mario@email.com', 25, 'Sur');


-- Q7: Devolver los datos de los clientes de una edad y nombre dados
INSERT INTO Clientes.nombre_edad(nombre, apellidos, email, edad, zona) VALUES ('Juan', 'Martínez', 'juan@email.com', 18, 'Norte');
INSERT INTO Clientes.nombre_edad(nombre, apellidos, email, edad, zona) VALUES ('María', 'García', 'maria@email.com', 25, 'Sur');
INSERT INTO Clientes.nombre_edad(nombre, apellidos, email, edad, zona) VALUES ('Domingo', ' ', 'domingo@email.com', 32, 'Norte');
INSERT INTO Clientes.nombre_edad(nombre, apellidos, email, edad, zona) VALUES ('Roberto', 'Luján', 'roberto@email.com', 21, 'Norte');
INSERT INTO Clientes.nombre_edad(nombre, apellidos, email, edad, zona) VALUES ('Mario', 'García', 'mario@email.com', 25, 'Sur');

-- Paso 3: Codifica y ejecuta las consultas

-- Q1: Devolver los datos de los clientes que tengan menos de 25 años de una zona dada
SELECT * FROM Clientes.edad_zona WHERE edad < 25 AND zona = 'Norte' ALLOW FILTERING;
SELECT * FROM Clientes.edad_zona WHERE edad < 25 AND zona = 'Sur' ALLOW FILTERING;

-- Q2: Devolver todos los datos de un cliente a partir de su e-mail
SELECT * FROM Clientes.email WHERE email = 'juan@email.com';
SELECT * FROM Clientes.email WHERE email = 'maria@email.com';
SELECT * FROM Clientes.email WHERE email = 'domingo@email.com';
SELECT * FROM Clientes.email WHERE email = 'roberto@email.com';
SELECT * FROM Clientes.email WHERE email = 'mario@email.com';

-- Q3: Devolver el número de clientes que hay en una zona dada
SELECT COUNT(*) FROM Clientes.zona WHERE zona = 'Norte';
SELECT COUNT(*) FROM Clientes.zona WHERE zona = 'Sur';

-- Q4: Devolver todos los datos del cliente de mayor edad de una zona dada
SELECT MAX(edad), nombre, apellidos, email, zona FROM Clientes.zona WHERE zona = 'Norte';
SELECT MAX(edad), nombre, apellidos, email, zona FROM Clientes.zona WHERE zona = 'Sur';

-- Q5: Calcular la media de edad de los clientes de una zona dada
SELECT AVG(edad) FROM Clientes.zona WHERE zona = 'Norte';
SELECT AVG(edad) FROM Clientes.zona WHERE zona = 'Sur';

/*
    Q6: Devolver los datos de los clientes de una zona dada cuyo nombre coincida con un
    determinado valor, ordenados alfabéticamente por apellidos
*/
SELECT * FROM Clientes.nombre_zona WHERE nombre = 'Juan' AND zona = 'Norte' ORDER BY apellidos;
SELECT * FROM Clientes.nombre_zona WHERE nombre = 'María' AND zona = 'Sur' ORDER BY apellidos;
SELECT * FROM Clientes.nombre_zona WHERE nombre = 'Domingo' AND zona = 'Norte' ORDER BY apellidos;
SELECT * FROM Clientes.nombre_zona WHERE nombre = 'Roberto' AND zona = 'Norte' ORDER BY apellidos;
SELECT * FROM Clientes.nombre_zona WHERE nombre = 'Mario' AND zona = 'Sur' ORDER BY apellidos;

-- Q7: Devolver los datos de los clientes de una edad y nombre dados
SELECT * FROM Clientes.nombre_edad WHERE nombre = 'Juan' AND edad = 18;
SELECT * FROM Clientes.nombre_edad WHERE nombre = 'María' AND edad = 25;
SELECT * FROM Clientes.nombre_edad WHERE nombre = 'Domingo' AND edad = 32;
SELECT * FROM Clientes.nombre_edad WHERE nombre = 'Roberto' AND edad = 21;
SELECT * FROM Clientes.nombre_edad WHERE nombre = 'Mario' AND edad = 25;

/*
    Paso 4: Operación de actualización que cambie los apellidos a 'Alarcon' de un cliente que tenga exactamente 21 años,
    cuya zona sea 'Norte' y el email sea 'roberto@email.com'
*/
CREATE TABLE Clientes.nombre_edad_zona_email(
                                        nombre text,
                                        apellidos text,
                                        email text,
                                        edad int,
                                        zona text,
                                        PRIMARY KEY ((edad, zona, email))
                                    );

INSERT INTO Clientes.nombre_edad_zona_email(nombre, apellidos, email, edad, zona) VALUES ('Juan', 'Martínez', 'juan@email.com', 18, 'Norte');
INSERT INTO Clientes.nombre_edad_zona_email(nombre, apellidos, email, edad, zona) VALUES ('María', 'García', 'maria@email.com', 25, 'Sur');
INSERT INTO Clientes.nombre_edad_zona_email(nombre, apellidos, email, edad, zona) VALUES ('Domingo', ' ', 'domingo@email.com', 32, 'Norte');
INSERT INTO Clientes.nombre_edad_zona_email(nombre, apellidos, email, edad, zona) VALUES ('Roberto', 'Luján', 'roberto@email.com', 21, 'Norte');
INSERT INTO Clientes.nombre_edad_zona_email(nombre, apellidos, email, edad, zona) VALUES ('Mario', 'García', 'mario@email.com', 25, 'Sur');

SELECT * FROM Clientes.nombre_edad_zona_email;

UPDATE Clientes.nombre_edad_zona_email SET apellidos = 'Alarcon' WHERE edad = 21 AND zona = 'Norte' AND email = 'roberto@email.com';

SELECT * FROM Clientes.nombre_edad_zona_email;


/*
    Paso 5: Vista materializada que almacene los datos de los clientes mayores o iguales de 18 años
    y menores o iguales de 30 años.
*/
CREATE TABLE Clientes.edad(
                                      nombre text,
                                      apellidos text,
                                      email text,
                                      edad int,
                                      zona text,
                                      PRIMARY KEY (edad, nombre)
                          );

INSERT INTO Clientes.edad(nombre, apellidos, email, edad, zona) VALUES ('Juan', 'Martínez', 'juan@email.com', 18, 'Norte');
INSERT INTO Clientes.edad(nombre, apellidos, email, edad, zona) VALUES ('María', 'García', 'maria@email.com', 25, 'Sur');
INSERT INTO Clientes.edad(nombre, apellidos, email, edad, zona) VALUES ('Domingo', ' ', 'domingo@email.com', 32, 'Norte');
INSERT INTO Clientes.edad(nombre, apellidos, email, edad, zona) VALUES ('Roberto', 'Luján', 'roberto@email.com', 21, 'Norte');
INSERT INTO Clientes.edad(nombre, apellidos, email, edad, zona) VALUES ('Mario', 'García', 'mario@email.com', 25, 'Sur');

CREATE MATERIALIZED VIEW Clientes.rango_edad AS
SELECT * FROM edad
WHERE edad >= 18 AND edad <= 30 AND nombre IS NOT NULL
PRIMARY KEY (edad,nombre);

-- Paso 6: Todos los resultados de la vista materializada
SELECT * FROM Clientes.rango_edad;


-- Paso 7: Borrado de los datos del cliente que se llama 'Mario Garcia'
CREATE TABLE Clientes.nombre_apellidos(
                                                nombre text,
                                                apellidos text,
                                                email text,
                                                edad int,
                                                zona text,
                                                PRIMARY KEY ((nombre, apellidos), email)
                                      );

INSERT INTO Clientes.nombre_apellidos(nombre, apellidos, email, edad, zona) VALUES ('Juan', 'Martínez', 'juan@email.com', 18, 'Norte');
INSERT INTO Clientes.nombre_apellidos(nombre, apellidos, email, edad, zona) VALUES ('María', 'García', 'maria@email.com', 25, 'Sur');
INSERT INTO Clientes.nombre_apellidos(nombre, apellidos, email, edad, zona) VALUES ('Domingo', ' ', 'domingo@email.com', 32, 'Norte');
INSERT INTO Clientes.nombre_apellidos(nombre, apellidos, email, edad, zona) VALUES ('Roberto', 'Luján', 'roberto@email.com', 21, 'Norte');
INSERT INTO Clientes.nombre_apellidos(nombre, apellidos, email, edad, zona) VALUES ('Mario', 'García', 'mario@email.com', 25, 'Sur');

SELECT * FROM Clientes.nombre_apellidos;

DELETE FROM Clientes.nombre_apellidos WHERE nombre = 'Mario' AND apellidos = 'García';

SELECT * FROM Clientes.nombre_apellidos;

