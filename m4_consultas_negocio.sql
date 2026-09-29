

-- Consulta 1 — Resumen ejecutivo mensual Total facturado, cantidad de pedidos y ticket promedio, agrupados por mes.
--Calculá el total como cantidad * precio_unitario. Usá alias descriptivos en español y agrupá por mes con EXTRACT(MONTH FROM fecha_venta).


SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM dbo.ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;


-- Consulta 2 — Ranking de productos Top 5 de id_producto por total facturado, mostrando las unidades 
-- vendidas (SUM(cantidad)) y el total generado. Usá GROUP BY id_producto, ORDER BY y limitá el resultado a 5.

SELECT TOP 5
    id_producto,
    SUM (cantidad) as unidades_vendidas,
    SUM (cantidad * precio_unitario) as total_generado
FROM dbo.ventas
GROUP BY id_producto
ORDER BY total_generado DESC;

-- Consulta 3 — Clientes recurrentes id_cliente que hayan realizado más de un pedido, 
-- mostrando la cantidad de pedidos y el total gastado. Usá GROUP BY id_cliente y HAVING COUNT(*) > 1.

SELECT 
    id_cliente as Clientes_recurrentes,
    COUNT(*) AS cantidad_de_pedidos,
    SUM (cantidad * precio_unitario) as total_gastado
FROM dbo.ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;

-- Consulta 4 — Meses por encima/por debajo del promedio Total facturado por mes, con una columna adicional que
--  etiquete con CASE WHEN si ese mes quedó 'Por encima' o 'Por debajo' del promedio mensual general.


SELECT
    MONTH(fecha_venta) as mes,
    SUM (cantidad * precio_unitario) as total_facturado,
    CASE
        WHEN SUM (CANTIDAD * PRECIO_UNITARIO) > (
        Select AVG (TOTAL)
        From ( 
                Select 
                    SUM (cantidad * precio_unitario) AS total
                    From dbo.ventas
                    Group by MONTH(fecha_venta)
                    )AS meses

        )
        THEN 'por encima'
        ELSE 'por debajo'
    END AS  estado
FROM dbo.ventas 
GROUP BY MONTH(fecha_venta);





-- Bloque de cierre 

-- el mes 3 fue el de mayor facturacion y ventas. con 13 ventas y total_facturado 8414.00
-- El producto 2 fue el más vendido, aunque el que mayor facturacion genero fue el 1 con solo 6 unidades_vendidas.
-- el cliente 1 representa casi el 50% del total de las ventas con 7530 sobre un total de 15138.






--  VENTAS.
-- SELECT * FROM dbo.ventas;

