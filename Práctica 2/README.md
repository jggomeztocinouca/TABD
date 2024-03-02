# Práctica 2: Control de Cuentas Bancarias con PL/SQL

## Objetivo
Escribe un script PL/SQL anónimo para realizar el control de las cuentas bancarias. 

## Especificaciones
Se deben crear las siguientes tablas:

### Tabla CUENTAS

| Atributo  | Tipo de Datos |
|-----------|---------------|
| IDCuenta  | NUMBER(4)     |
| Valor     | NUMBER(11,2)  |

### Tabla ACCIONES

| Atributo   | Tipo de Datos |
|------------|---------------|
| IdCuenta   | NUMBER(4)     |
| TipoOp     | CHAR(1)       |
| NuevoValor | NUMBER(11,2)  |
| Estado     | VARCHAR2(45)  |
| FechaMod   | DATE          |

El script PL/SQL llevará el control de las cuentas almacenadas en la tabla CUENTAS basándose en las instrucciones almacenadas en la tabla ACCIONES. Cada fila de la tabla ACCIONES contiene:

- El identificador de la cuenta sobre la que se debe actuar (IdCuenta).
- La acción que se debe llevar a cabo codificada con un carácter (TipoOp):
    - i o I para insertar
    - a o A para actualizar
    - b o B para borrar
- Una cantidad que se utilizará en el caso de que se deba actualizar la cuenta a ese valor (NuevoValor).
- Un comentario que indicará el nombre de la operación que se realizó o intentó realizar, seguido de si se realizó o no con éxito (Estado).
- La fecha en la que se actualizó por última vez cada fila de la tabla ACCIONES.

## Restricciones de operación:

- Si hay que realizar una inserción y la cuenta ya existe, se realizará una operación de actualización en su lugar.
- Si hay que realizar una actualización de una cuenta que no existe, entonces habrá que realizar una inserción.
- Si hay que borrar una cuenta que no existe, no se realizará ninguna acción.

## Instancias de prueba
Como ejemplo, prueba a ejecutar tu script con las siguientes instancias:

#### Tabla CUENTAS:

| IdCuenta | Valor    |
|----------|----------|
| 1        | 1000,00  |
| 2        | 2000,00  |
| 3        | 1500,00  |
| 4        | 6500,00  |
| 5        | 500,00   |

#### Tabla ACCIONES:

| IdCuenta | TipoOp | NuevoValor | Estado | FechaMod |
|----------|--------|------------|--------|----------|
| 3        | a      | 599        | null   | null     |
| 6        | i      | 20099      | null   | null     |
| 5        | B      | null       | null   | null     |
| 7        | A      | 1599       | null   | null     |
| 1        | i      | 399        | null   | null     |
| 9        | b      | null       | null   | null     |
| 10       | h      | null       | null   | null     |
