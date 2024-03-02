# Ejercicio 2
Ejecuta los siguientes scripts PL/SQL anónimos. 

Copia el resultado de ejecutarlos a un fichero y explica porqué muestran resultados diferentes aún cuando la variable v_num toma el mismo valor en ambos scripts. 
Envía este fichero con el resultado de la ejecución y tu explicación como resultado de esta tarea.

### Bloque 1
```oraclesqlplus
-- Block 1
SET SERVEROUTPUT ON
DECLARE
v_num NUMBER := NULL;
BEGIN
IF v_num > 0 THEN
DBMS_OUTPUT.PUT_LINE ('v_num is greater than 0');
ELSE DBMS_OUTPUT.PUT_LINE ('v_num is not greater than 0');
END IF;
END;
```

### Bloque 2
```oraclesqlplus
-- Block 2
SET SERVEROUTPUT ON
DECLARE v_num NUMBER := NULL;
BEGIN
IF v_num > 0 THEN
DBMS_OUTPUT.PUT_LINE ('v_num is greater than 0');
END IF;
IF NOT (v_num > 0) THEN
DBMS_OUTPUT.PUT_LINE ('v_num is not greater than 0');
END IF;
END;
```