CREATE OR REPLACE FUNCTION alumnos_matriculados(
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
END;
/


-- Consulta que selecciona los datos de un curso y sus ediciones, incluyendo el número de alumnos matriculados en cada edición
SELECT c.Cod_Curso,
       c.Nombre,
       c.Descripcion,
       c.Precio,
       e.Cod_Edicion,
       e.Fecha_Inicio,
       e.Fecha_Fin,
       e.Lugar,
       alumnos_matriculados(c.Cod_Curso, e.Cod_Edicion) AS Num_Alumnos_Matriculados
FROM Cursos c
         JOIN Edicion e ON c.Cod_Curso = e.Cod_Curso
WHERE c.Cod_Curso = 1 -- Filtro: Código del curso
ORDER BY e.Cod_Edicion; -- Ordenación: En orden ascendente por el código de la edición
