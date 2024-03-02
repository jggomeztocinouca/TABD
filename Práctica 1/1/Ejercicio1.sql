SET SERVEROUTPUT ON;

DECLARE
    temperatura REAL := &temperatura_entrada;
    escala CHAR := &escala_entrada;

    temperatura_convertida REAL;

BEGIN
    IF escala = 'C' THEN
        -- Celsius a Fahrenheit
        temperatura_convertida := (9/5) * temperatura + 32;
        dbms_output.put_line('La temperatura en Fahrenheit es: ' || temperatura_convertida);
    ELSIF escala = 'F' THEN
        -- Fahrenheit a Celsius
        temperatura_convertida := (5/9) * (temperatura - 32);
        dbms_output.put_line('La temperatura en Celsius es: ' || temperatura_convertida);
    ELSE
        dbms_output.put_line('Escala no reconocida. Por favor, introduzca "C" para Celsius o "F" para Fahrenheit.');
    END IF;
END;
/

-- Jesús Gómez - 2024