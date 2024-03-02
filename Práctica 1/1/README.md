# Ejercicio 1
Escribe un script PL/SQL anónimo que reciba como entradas:
- Un valor real que representa una temperatura.
- Un carácter que indica la escala en la que está medida dicha temperatura ('C' para Celsius o 'F' para Farenheit).
y muestre la temperatura expresada en la otra escala.

Para resolver este ejercicio debes utilizar los siguientes conceptos:
- Sentencia IF-THEN-ELSE.
- Variables de sustitución (variables que van precedidas del símbolo &) dentro del producto SQL*Plus.
- El procedimiento dbms_output.put_line(VARCHAR2 cadena) para mostrar mensajes.

Recuerda que la regla de transformación entre las escalas de temperatura es la siguiente:
- Tc=(5/9)*(Tf-32)
    - Tc = Temperatura en grados Celsius
    - Tf = Temperatura en grados Fahrenheit
- Tf=(9/5)*Tc+32
  - Tc=Temperatura in grados Celsius
  - Tf=Temperatura in grados Fahrenheit 

