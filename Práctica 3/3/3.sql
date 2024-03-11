CREATE OR REPLACE PACKAGE gestion_cursos IS

    -- Declaración del procedimiento para modificar el precio del curso.
    PROCEDURE ModificarPrecioCurso(num_min_alumnos IN NUMBER := 1);

    -- Declaración de la función para contar alumnos matriculados.
    FUNCTION alumnos_matriculados(c_cod_curso IN NUMBER, c_cod_edicion IN NUMBER)
        RETURN NUMBER;

END gestion_cursos;
/

CREATE OR REPLACE PACKAGE BODY gestion_cursos IS

    PROCEDURE ModificarPrecioCurso
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
    END ModificarPrecioCurso;


    FUNCTION alumnos_matriculados(
        c_cod_curso IN NUMBER, -- Parámetro de entrada: Código del curso.
        c_cod_edicion IN NUMBER -- Parámetro de entrada: Código de la edición.
    ) RETURN NUMBER IS -- Tipo de dato devuelto por la función: NUMBER.

        n_alumnos NUMBER; -- Variable: Número de alumnos matriculados.

    BEGIN
        -- Consulta para contar el número total de alumnos matriculados en una edición específica de un curso.
        SELECT COUNT(*)
        INTO n_alumnos
        FROM Matricula
        WHERE Cod_Curso = c_cod_curso AND Cod_Edicion = c_cod_edicion;

        -- Devuelve el número de alumnos matriculados encontrados en la variable creada para ello.
        RETURN n_alumnos;
    END alumnos_matriculados;

END gestion_cursos;
/

DECLARE
    num_alumnos NUMBER;
    cod_curso NUMBER := 1;
    cod_edicion NUMBER := 1;
    num_min_alumnos NUMBER := 2;
BEGIN
    -- Consulta para visualizar los precios en los cursos antes de aplicar el descuento.
    DBMS_OUTPUT.PUT_LINE('PRECIO ANTES DE LOS DESCUENTOS');
    FOR curso IN (SELECT Cod_Curso, Nombre, Precio FROM Cursos)
        LOOP
            DBMS_OUTPUT.PUT_LINE('Curso: ' || curso.Nombre || ' - Precio actualizado: ' || curso.Precio);
        END LOOP;

    -- Llamada al procedimiento para modificar el precio del curso basado en el número mínimo de alumnos.
    gestion_cursos.ModificarPrecioCurso(num_min_alumnos);

    -- Consulta para verificar los cambios de precios en los cursos después de aplicar el descuento.
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('PRECIO DESPUÉS DE LOS DESCUENTOS');
    FOR curso IN (SELECT Cod_Curso, Nombre, Precio FROM Cursos)
        LOOP
            DBMS_OUTPUT.PUT_LINE('Curso: ' || curso.Nombre || ' - Precio actualizado: ' || curso.Precio);
        END LOOP;

    -- Llamada a la función para contar el número de alumnos matriculados en una edición específica del curso.
    num_alumnos := gestion_cursos.alumnos_matriculados(cod_curso, cod_edicion);
    DBMS_OUTPUT.PUT_LINE('Número de alumnos matriculados en el curso ' || cod_curso || ', edición ' || cod_edicion || ': ' || num_alumnos);

END;
/

