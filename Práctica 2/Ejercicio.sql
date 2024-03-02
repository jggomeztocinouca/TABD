-- Creación de las tablas CUENTAS y ACCIONES
CREATE TABLE CUENTAS (
                         IDCuenta NUMBER(4),
                         Valor NUMBER(11,2)
);

CREATE TABLE ACCIONES (
                          IdCuenta NUMBER(4),
                          TipoOp CHAR(1),
                          NuevoValor NUMBER(11,2),
                          Estado VARCHAR2(100), -- Modificado para admitir cadenas más larga [No me cabía un mensaje (:]
                          FechaMod DATE
);

-- Tuplas de ejemplo
INSERT INTO CUENTAS (IDCuenta, Valor) VALUES (1, 1000.00);
INSERT INTO CUENTAS (IDCuenta, Valor) VALUES (2, 2000.00);
INSERT INTO CUENTAS (IDCuenta, Valor) VALUES (3, 1500.00);
INSERT INTO CUENTAS (IDCuenta, Valor) VALUES (4, 6500.00);
INSERT INTO CUENTAS (IDCuenta, Valor) VALUES (5, 500.00);

INSERT INTO ACCIONES (IdCuenta, TipoOp, NuevoValor, Estado, FechaMod) VALUES (3, 'a', 599, NULL, NULL);
INSERT INTO ACCIONES (IdCuenta, TipoOp, NuevoValor, Estado, FechaMod) VALUES (6, 'i', 20099, NULL, NULL);
INSERT INTO ACCIONES (IdCuenta, TipoOp, NuevoValor, Estado, FechaMod) VALUES (5, 'B', NULL, NULL, NULL);
INSERT INTO ACCIONES (IdCuenta, TipoOp, NuevoValor, Estado, FechaMod) VALUES (7, 'A', 1599, NULL, NULL);
INSERT INTO ACCIONES (IdCuenta, TipoOp, NuevoValor, Estado, FechaMod) VALUES (1, 'i', 399, NULL, NULL);
INSERT INTO ACCIONES (IdCuenta, TipoOp, NuevoValor, Estado, FechaMod) VALUES (9, 'b', NULL, NULL, NULL);
INSERT INTO ACCIONES (IdCuenta, TipoOp, NuevoValor, Estado, FechaMod) VALUES (10, 'h', NULL, NULL, NULL);

-- Procedimiento para la gestión de acciones
DECLARE
    CURSOR Acciones_Cursor IS
        SELECT * FROM ACCIONES
        FOR UPDATE OF Estado, FechaMod;
    estado_accion VARCHAR2(100);
BEGIN
    FOR Accion IN Acciones_Cursor LOOP
        CASE UPPER(Accion.TipoOp)
            WHEN 'I' THEN
                BEGIN
                    INSERT INTO CUENTAS (IDCuenta, Valor) VALUES (Accion.IdCuenta, Accion.NuevoValor);
                    estado_accion := 'Insertado con éxito';
                    EXCEPTION
                        WHEN DUP_VAL_ON_INDEX THEN
                            UPDATE CUENTAS SET Valor = Accion.NuevoValor WHERE IDCuenta = Accion.IdCuenta;
                            estado_accion := 'Cuenta existente. Actualizado con éxito.';
                END;
            WHEN 'A' THEN
                BEGIN
                    UPDATE CUENTAS SET Valor = Accion.NuevoValor WHERE IDCuenta = Accion.IdCuenta;
                    IF SQL%ROWCOUNT = 0 THEN
                        INSERT INTO CUENTAS (IDCuenta, Valor) VALUES (Accion.IdCuenta, Accion.NuevoValor);
                        estado_accion := 'Cuenta no existente. Insertado con éxito.';
                    ELSE
                        estado_accion := 'Actualizado con éxito.';
                    END IF;
                END;
            WHEN 'B' THEN
                BEGIN
                    DELETE FROM CUENTAS WHERE IDCuenta = Accion.IdCuenta;
                    IF SQL%ROWCOUNT = 0 THEN
                        estado_accion := 'Cuenta no existente. No se borró ninguna fila.';
                    ELSE
                        estado_accion := 'Borrado con éxito';
                    END IF;
                END;
            ELSE
                estado_accion := 'Operación desconocida';
        END CASE;
        UPDATE ACCIONES SET Estado = estado_accion, FechaMod = SYSDATE WHERE CURRENT OF Acciones_Cursor;
    END LOOP;
END;
/
