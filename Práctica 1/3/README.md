# Ejercicio 3
Escribe un script PL/SQL anónimo para llevar el control de las ventas de los artículos de la base de datos, siguiendo los siguientes pasos:

1. Crea una tabla llamada Inventario donde guardaremos, para cada artículo el número de unidades existentes en el almacén y la fecha en que se actualizó por última vez esa información.
2. Crea una tabla denominada ControlVentas donde para cada venta guardaremos el artículo, el número de unidades vendidas o solicitadas, la fecha de venta o solicitud y un comentario que indicará si se pudo satisfacer el pedido o si, por el contrario, no hubo existencias disponibles.
3. Introduce algunas filas en las tablas.
4. Escribe un script PL/SQL anónimo que procese la orden de compra de cualquier número de unidades de un artículo dado.Si no hay cantidad disponible, se comunicará a través de un mensaje al usuario.