# Práctica 4: Disparadores y secuencias, y columnas identidad

## Ejercicio:
Escribe un disparador que realice el seguimiento de las operaciones de modificación realizadas sobre la tabla Empleados (CodigoEmpleado, Nombre, Sueldo). 

El disparador llevará un control de todas las modificaciones que se realicen sobre esta tabla guardando una información común para todas las acciones y otra información específica en el caso de que la modificación proceda de una actualización.

La información común para todas las acciones es:
1. Código único generado automáticamente para identificar cada modificación realizada sobre la tabla.
2. Nombre del usuario que realiza la modificación.
3. Hora en la que se realiza la modificación.
4. La acción realizada ("insert", "update" o "delete").
5. El valor correspondiente a la clave primaria de la fila modificada.

La información específica sólo debe guardarse cuando se produzca una actualización. En este caso, además de la información anterior se deberá almacenar el detalle correspondiente a esta actualización, consistente en: el nombre del atributo modificado, el valor anterior y el valor actual tras la modificación.

Realizar dos implementaciones para generar el código único de cada acción:
1. Utilizando una secuencia.
2. Utilizando una columna identidad. 
