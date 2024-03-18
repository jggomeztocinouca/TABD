-- Tabla Empleados (CodigoEmpleado, Nombre, Sueldo) sobre la que actuará el primer trigger.
CREATE TABLE Empleado1 (
   CodigoEmpleado NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   Nombre VARCHAR2(100),
   Sueldo NUMBER
);

-- Tabla Empleados (CodigoEmpleado, Nombre, Sueldo) sobre la que actuará el segundo trigger.
CREATE TABLE Empleado2 (
   CodigoEmpleado NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
   Nombre VARCHAR2(100),
   Sueldo NUMBER
);

-- Población de la tabla Empleado1.
INSERT INTO Empleado1 (Nombre, Sueldo) VALUES ('Juan', 30000);
INSERT INTO Empleado1 (Nombre, Sueldo) VALUES ('Ana', 35000);

-- Población de la tabla Empleado2.
INSERT INTO Empleado2 (Nombre, Sueldo) VALUES ('Juan', 30000);
INSERT INTO Empleado2 (Nombre, Sueldo) VALUES ('Ana', 35000);

-- Secuencia para el registro de modificaciones.
CREATE SEQUENCE Historico_Seq START WITH 1 INCREMENT BY 1;

-- Tabla asociada para el registro de modificaciones (Secuencia).
CREATE TABLE Historico_Empleado1 (
     ID_Historico NUMBER PRIMARY KEY,
     Usuario VARCHAR2(100),
     Timestamp TIMESTAMP,
     Accion VARCHAR2(10),
     CodigoEmpleado NUMBER,
     AtributoModificado VARCHAR2(100),
     ValorAnterior VARCHAR2(255),
     ValorActual VARCHAR2(255)
);

-- Tabla asociada para el registro de modificaciones (Columna identidad).
CREATE TABLE Historico_Empleado2 (
     ID_Historico NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
     Usuario VARCHAR2(100),
     Timestamp TIMESTAMP,
     Accion VARCHAR2(10),
     CodigoEmpleado NUMBER,
     AtributoModificado VARCHAR2(100),
     ValorAnterior VARCHAR2(255),
     ValorActual VARCHAR2(255)
);


-- Disparador de control sobre las modificaciones de la tabla Empleados (Secuencia).
CREATE OR REPLACE TRIGGER Trigger_Empleado1
    AFTER INSERT OR DELETE OR UPDATE ON Empleado1
    FOR EACH ROW
DECLARE
    v_usuario VARCHAR2(100) := USER;
    v_fechaHora TIMESTAMP := CURRENT_TIMESTAMP;
    v_accion VARCHAR2(10);
    v_atributo VARCHAR2(100);
    v_valorAnterior VARCHAR2(255);
    v_valorActual VARCHAR2(255);
BEGIN
    IF INSERTING THEN
        v_accion := 'insert';
    ELSIF DELETING THEN
        v_accion := 'delete';
    ELSIF UPDATING THEN
        v_accion := 'update';
        v_atributo := 'Sueldo';
        v_valorAnterior := :OLD.Sueldo;
        v_valorActual := :NEW.Sueldo;
    END IF;

    INSERT INTO Historico_Empleado1 (ID_Historico, Usuario, Timestamp, Accion, CodigoEmpleado, AtributoModificado, ValorAnterior, ValorActual)
    VALUES (Historico_Seq.NEXTVAL, v_usuario, v_fechaHora, v_accion, :NEW.CodigoEmpleado, v_atributo, v_valorAnterior, v_valorActual);
END;

-- Disparador de control sobre las modificaciones de la tabla Empleados (Columna identidad).
CREATE OR REPLACE TRIGGER Trigger_Empleado2
    AFTER INSERT OR DELETE OR UPDATE ON Empleado2
    FOR EACH ROW
DECLARE
    v_usuario VARCHAR2(100) := USER;
    v_fechaHora TIMESTAMP := CURRENT_TIMESTAMP;
    v_accion VARCHAR2(10);
    v_atributo VARCHAR2(100);
    v_valorAnterior VARCHAR2(255);
    v_valorActual VARCHAR2(255);
BEGIN
    IF INSERTING THEN
        v_accion := 'insert';
    ELSIF DELETING THEN
        v_accion := 'delete';
    ELSIF UPDATING THEN
        v_accion := 'update';
        v_atributo := 'Sueldo';
        v_valorAnterior := :OLD.Sueldo;
        v_valorActual := :NEW.Sueldo;
    END IF;

    INSERT INTO Historico_Empleado2 (Usuario, Timestamp, Accion, CodigoEmpleado, AtributoModificado, ValorAnterior, ValorActual)
    VALUES (v_usuario, v_fechaHora, v_accion, :NEW.CodigoEmpleado, v_atributo, v_valorAnterior, v_valorActual);
END;

-- Tabla Empleado1 antes de las modificaciones.
SELECT * FROM Empleado1;

-- Tabla Empleado2 antes de las modificaciones.
SELECT * FROM Empleado2;

-- Modificaciones de cada tipo en la tabla Empleado1 (Secuencia).
INSERT INTO Empleado1 (Nombre, Sueldo) VALUES ('Carlos', 40000);
UPDATE Empleado1 SET Sueldo = 45000 WHERE Nombre = 'Juan';
DELETE FROM Empleado1 WHERE Nombre = 'Ana';

-- Modificaciones de cada tipo en la tabla Empleado2 (Columna identidad).
INSERT INTO Empleado2 (Nombre, Sueldo) VALUES ('Carlos', 40000);
UPDATE Empleado2 SET Sueldo = 45000 WHERE Nombre = 'Juan';
DELETE FROM Empleado2 WHERE Nombre = 'Ana';

-- Tabla Empleado1 después de las modificaciones.
SELECT * FROM Empleado1;

-- Consulta de las modificaciones realizadas en la tabla Historico_Empleado1.
SELECT * FROM Historico_Empleado1;

-- Tabla Empleado2 después de las modificaciones.
SELECT * FROM Empleado2;

-- Consulta de las modificaciones realizadas en la tabla Historico_Empleado2.
SELECT * FROM Historico_Empleado2;