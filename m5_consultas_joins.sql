-- ENTREGA 5 

USE Ventas_Tech_DB 

SELECT * FROM dbo.ventas; 
SELECT * FROM DBO.CLIENTES;
SELECT * FROM dbo.productos;


-- CONSULTA 1

SELECT
*
FROM dbo.ventas
INNER JOIN dbo.clientes
ON dbo.ventas.id_cliente = dbo.clientes.id_cliente;


SELECT 
    dbo.ventas.id_venta,
    dbo.clientes.id_cliente,
    dbo.clientes.nombre,
    dbo.clientes.ciudad,
    dbo.ventas.fecha_venta,
    dbo.productos.id_producto,
    dbo.productos.nombre_producto,   
    dbo.ventas.precio_unitario,
    dbo.ventas.cantidad,
    dbo.ventas.precio_unitario * dbo.ventas.cantidad AS total_ventas
 

FROM dbo.ventas
INNER JOIN dbo.clientes
    ON dbo.ventas.id_cliente = dbo.clientes.id_cliente
INNER JOIN dbo.productos
    ON dbo.ventas.id_producto = dbo.productos.id_producto
ORDER BY total_ventas DESC;


-- CONSULTA 2
--SE AGREGAN CLIENTES PARA TENER VALORES NULL DE VENTAS Y PODER VERIFICAR
--INSERT INTO clientes (nombre, email, ciudad, fecha_registro)
--VALUES
--('Maríano López',   'mariaLOP@mail.com',   'Buenos Aires', '2024-11-03'),
--('Carlos Maldonado',   'carMaldo@mail.com',  'Córdoba',      '2024-06-10');


SELECT 
    dbo.clientes.nombre,
    dbo.clientes.email,
    dbo.clientes.fecha_registro,
    dbo.ventas.id_venta
FROM dbo.clientes
LEFT JOIN dbo.ventas
    ON dbo.clientes.id_cliente = dbo.ventas.id_cliente
WHERE dbo.ventas.id_venta IS NULL;


-- CONSULTA 3
-- SE AGREGAN PRODUCTOS 
--INSERT INTO productos (nombre_producto, id_categoria, precio, stock, activo)
--VALUES
--('ASUS Pro 17', 1, 1200.00, 15, 1),
--('Auriculares JBL', 2, 28.00, 80, 1);


SELECT
        dbo.productos.nombre_producto,
        dbo.productos.precio,
        dbo.categorias.nombre_categoria,
        dbo.ventas.id_venta
        
FROM dbo.productos

LEFT JOIN dbo.ventas
    ON dbo.productos.id_producto = dbo.ventas.id_producto
LEFT JOIN dbo.categorias
    ON dbo.productos.id_categoria = dbo.categorias.id_categoria
WHERE dbo.ventas.id_venta IS NULL;


--CONSULTA 4
-- SELECT fecha, total, 'Online' AS canal FROM ventas WHERE ... UNION ALL SELECT fecha, total, 'Presencial' AS canal FROM ventas WHERE ...


--SE AGREGAN VENTAS 2do SEMESTRE PARA NO TENER VALORES NULL 


--INSERT INTO ventas (id_cliente, id_producto, cantidad, precio_unitario, fecha_venta)
--VALUES
--(4, 5, 3,  130.00, '2024-12-10'),
--(5, 1, 1, 1200.00, '2024-10-12'),
--(1, 3, 5, 450.00, '2024-08-10'),
--(3, 2, 8,   28.00, '2024-08-13'),
--(4, 4, 1,  120.00, '2024-07-14'),
--(5, 3, 2,  450.00, '2024-06-15');

SELECT 
       '1er_semestre' as canal,
      SUM(precio_unitario * cantidad) as ventas_total
    FROM dbo.ventas
    WHERE fecha_venta < '2024-07-01'
UNION ALL 
SELECT 
       '2do_semestre' as canal,
       SUM(precio_unitario * cantidad) as ventas_total
    FROM dbo.ventas
    WHERE fecha_venta >= '2024-07-01';

