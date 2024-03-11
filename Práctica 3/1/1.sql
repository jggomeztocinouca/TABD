CREATE TABLE Cursos (
                        Cod_Curso NUMBER(5),
                        Nombre VARCHAR2(50) NOT NULL,
                        Descripcion VARCHAR2(90) NOT NULL,
                        Precio NUMBER(5,2) NOT NULL,
                        Descuento NUMBER(4,2) NOT NULL,
                        CONSTRAINT PK_Cursos PRIMARY KEY (Cod_Curso)
                    );

CREATE TABLE Alumnos (
                         Cod_Alumno NUMBER(5),
                         Nombre VARCHAR2(50) NOT NULL,
                         Apellidos VARCHAR2(50) NOT NULL,
                         CONSTRAINT PK_Alumnos PRIMARY KEY (Cod_Alumno)
                     );

CREATE TABLE Edicion (
                         Cod_Curso NUMBER(5),
                         Cod_Edicion NUMBER(3),
                         Fecha_Inicio DATE NOT NULL,
                         Fecha_Fin DATE NOT NULL,
                         Lugar VARCHAR2(40) NOT NULL,
                         CONSTRAINT PK_Edicion PRIMARY KEY (Cod_Curso, Cod_Edicion),
                         CONSTRAINT FK_Edicion_Cursos FOREIGN KEY (Cod_Curso) REFERENCES Cursos(Cod_Curso)
                     );


CREATE TABLE Matricula (
                           Cod_Curso NUMBER(5),
                           Cod_Edicion NUMBER(2),
                           Cod_Alumno NUMBER(5),
                           Fecha_Matricula DATE NOT NULL,
                           CONSTRAINT PK_Matricula PRIMARY KEY (Cod_Curso, Cod_Edicion, Cod_Alumno),
                           CONSTRAINT FK_Matricula_Edicion FOREIGN KEY (Cod_Curso, Cod_Edicion) REFERENCES Edicion(Cod_Curso, Cod_Edicion),
                           CONSTRAINT FK_Matricula_Alumnos FOREIGN KEY (Cod_Alumno) REFERENCES Alumnos(Cod_Alumno)
                       );

-- Cursos
INSERT INTO Cursos VALUES (1, 'Curso SQL', 'Aprendizaje de SQL desde cero', 100, 10);
INSERT INTO Cursos VALUES (2, 'Curso PL/SQL', 'Profundización en PL/SQL', 150, 20);
INSERT INTO Cursos VALUES (3, 'Curso Java', 'Desarrollo de aplicaciones con Java', 200, 15);

-- Alumnos
INSERT INTO Alumnos VALUES (1001, 'Juan', 'Pérez');
INSERT INTO Alumnos VALUES (1002, 'Ana', 'Gómez');
INSERT INTO Alumnos VALUES (1003, 'Carlos', 'Martínez');
INSERT INTO Alumnos VALUES (1004, 'Luisa', 'Jiménez');
INSERT INTO Alumnos VALUES (1005, 'Sofía', 'López');

-- Edición
-- Ediciones para Curso SQL
INSERT INTO Edicion VALUES (1, 1, TO_DATE('2023-01-10', 'YYYY-MM-DD'), TO_DATE('2023-01-20', 'YYYY-MM-DD'), 'Online');
INSERT INTO Edicion VALUES (1, 2, TO_DATE('2023-02-10', 'YYYY-MM-DD'), TO_DATE('2023-02-20', 'YYYY-MM-DD'), 'Presencial');

-- Ediciones para Curso PL/SQL
INSERT INTO Edicion VALUES (2, 1, TO_DATE('2023-03-10', 'YYYY-MM-DD'), TO_DATE('2023-03-20', 'YYYY-MM-DD'), 'Online');

-- Ediciones para Curso Java
INSERT INTO Edicion VALUES (3, 1, TO_DATE('2023-04-10', 'YYYY-MM-DD'), TO_DATE('2023-04-20', 'YYYY-MM-DD'), 'Online');
INSERT INTO Edicion VALUES (3, 2, TO_DATE('2023-05-10', 'YYYY-MM-DD'), TO_DATE('2023-05-20', 'YYYY-MM-DD'), 'Presencial');

-- Matrículas
-- Matrículas para Curso SQL
INSERT INTO Matricula VALUES (1, 1, 1001, SYSDATE);
INSERT INTO Matricula VALUES (1, 1, 1002, SYSDATE);
INSERT INTO Matricula VALUES (1, 2, 1003, SYSDATE);
INSERT INTO Matricula VALUES (1, 2, 1004, SYSDATE);

-- Matrículas para Curso PL/SQL
INSERT INTO Matricula VALUES (2, 1, 1005, SYSDATE);

-- Matrículas para Curso Java
INSERT INTO Matricula VALUES (3, 1, 1001, SYSDATE);
INSERT INTO Matricula VALUES (3, 1, 1002, SYSDATE);
INSERT INTO Matricula VALUES (3, 2, 1003, SYSDATE);
INSERT INTO Matricula VALUES (3, 2, 1004, SYSDATE);
INSERT INTO Matricula VALUES (3, 2, 1005, SYSDATE);

COMMIT;

CREATE OR REPLACE PROCEDURE ModificarPrecioCurso
       (num_min_alumnos IN NUMBER := 1) IS
BEGIN
    FOR curso IN (SELECT c.Cod_Curso, c.Descuento
        FROM Cursos c -- Seleccionamos el código del curso y el descuento de los cursos
        WHERE NOT EXISTS ( -- Donde no se cumpla la siguiente condición:
            SELECT e.Cod_Curso -- Seleccionamos el código del curso
            -- De las coincidencias de la tabla Edicion con la tabla Matricula
            FROM Edicion e LEFT JOIN Matricula m ON e.Cod_Curso = m.Cod_Curso AND e.Cod_Edicion = m.Cod_Edicion
            GROUP BY e.Cod_Curso, e.Cod_Edicion -- Agrupados por el código del curso y el código de la edición
            HAVING COUNT(m.Cod_Alumno) < num_min_alumnos -- Si el número de alumnos es menor que el mínimo
            INTERSECT -- Y
            -- El código del curso coincide con el código del curso
            SELECT e.Cod_Curso FROM Edicion e WHERE e.Cod_Curso = c.Cod_Curso
        ))
    LOOP -- Para cada curso que cumpla la condición anterior
        UPDATE Cursos SET Precio = Precio - (Precio * (curso.Descuento / 100)) -- Se aplica el descuento
        WHERE Cod_Curso = curso.Cod_Curso;
    END LOOP;
    COMMIT;
END;

DECLARE
    n_min_alumnos NUMBER := 2;
BEGIN
    -- Precio antes de los descuentos
    DBMS_OUTPUT.PUT_LINE('PRECIO ANTES DE LOS DESCUENTOS');
    FOR Curso
    IN (SELECT Cod_Curso, Nombre, Precio FROM Cursos) LOOP
        DBMS_OUTPUT.PUT_LINE('Curso: ' || Curso.Nombre || ', Precio final: ' || Curso.Precio);
    END LOOP;

    -- Aplicamos los descuentos
    ModificarPrecioCurso(n_min_alumnos);
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('PRECIO DESPUÉS DE LOS DESCUENTOS');
    FOR Curso
    IN (SELECT Cod_Curso, Nombre, Precio FROM Cursos) LOOP
        DBMS_OUTPUT.PUT_LINE('Curso: ' || Curso.Nombre || ', Precio final: ' || Curso.Precio);
    END LOOP;
END;