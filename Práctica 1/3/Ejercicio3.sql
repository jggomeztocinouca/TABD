CREATE TABLE Inventario (
                            articulo_id NUMBER PRIMARY KEY,
                            unidades_existencias NUMBER NOT NULL,
                            fecha_actualizacion DATE DEFAULT SYSDATE NOT NULL
);

CREATE TABLE ControlVentas (
                               venta_id NUMBER PRIMARY KEY,
                               articulo_id NUMBER NOT NULL,
                               unidades_vendidas NUMBER NOT NULL,
                               fecha_venta DATE NOT NULL,
                               comentario VARCHAR2(255),
                               CONSTRAINT fk_articulo
                                   FOREIGN KEY (articulo_id)
                                       REFERENCES Inventario (articulo_id)
);

INSERT INTO Inventario VALUES (1, 100, SYSDATE); -- Artículo 1 con 100 unidades
INSERT INTO Inventario VALUES (2, 50, SYSDATE);  -- Artículo 2 con 50 unidades

INSERT INTO ControlVentas VALUES (1, 1, 20, SYSDATE, 'Pedido realizado'); -- Venta de 20 unidades del Artículo 1
INSERT INTO ControlVentas VALUES (2, 2, 5, SYSDATE, 'Pedido realizado');  -- Venta de 5 unidades del Artículo 2

DECLARE
    v_id NUMBER := &id; -- ID de la venta
    v_articulo_id NUMBER := &articulo_id; -- ID del artículo a vender
    v_unidades_solicitadas NUMBER := &unidades_solicitadas; -- Unidades solicitadas
    v_unidades_existencias NUMBER; -- Unidades disponibles
    v_fecha_actualizacion DATE; -- Fecha de actualización
BEGIN
    SELECT unidades_existencias, fecha_actualizacion
    INTO v_unidades_existencias, v_fecha_actualizacion
    FROM Inventario
    WHERE articulo_id = v_articulo_id;

    IF v_unidades_solicitadas <= v_unidades_existencias THEN
        -- Hay suficientes unidades (continuar con la venta)
        UPDATE Inventario
        SET unidades_existencias = unidades_existencias - v_unidades_solicitadas,
            fecha_actualizacion = SYSDATE
        WHERE articulo_id = v_articulo_id;

        INSERT INTO ControlVentas (venta_id, articulo_id, unidades_vendidas, fecha_venta, comentario)
        VALUES (v_id, v_articulo_id, v_unidades_solicitadas, SYSDATE, 'Pedido realizado');

        DBMS_OUTPUT.PUT_LINE('Venta procesada correctamente.');
    ELSE
        -- No hay suficientes unidades (cancelar la venta)
        DBMS_OUTPUT.PUT_LINE('No hay suficientes unidades disponibles para realizar el pedido.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('El artículo solicitado no existe.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ha ocurrido un error al procesar la venta. Inténtelo de nuevo.');
END;
