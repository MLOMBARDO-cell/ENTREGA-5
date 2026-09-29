-- CREACION BASE DE DATOS

CREATE DATABASE Ventas_Tech_DB;


use Ventas_Tech_DB;

-- ELIMINAR TABLAS SI EXISTEN

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;


-- CREACION DE TABLAS

CREATE TABLE categorias (
id_categoria int identity primary key,
nombre_categoria varchar (50) not null,
descripcion varchar (200)
);

CREATE TABLE clientes (
id_cliente int identity primary key,
nombre varchar (100) not null,
email varchar (100) unique,
ciudad varchar(50),
fecha_registro date not null
);


CREATE TABLE productos (
id_producto int identity primary key,
nombre_producto varchar (100) not null,
id_categoria int not null,
precio decimal (10,2) not null,
stock int default 0,
activo smallint default 1,

constraint fk_productos_categorias
	foreign key (id_categoria)
    references categorias (id_categoria)
    );
    
CREATE TABLE ventas (
id_venta int identity primary key,
id_cliente int not null,
id_producto int not null,
cantidad int not null,
precio_unitario decimal (10,2) not null,
fecha_venta date not null,

constraint fk_ventas_clientes
	foreign key (id_cliente)
    references clientes (id_cliente),
    
constraint fk_ventas_productos
	foreign key (id_producto)
    references productos (id_producto)
    
);

-- INSERT DATA

INSERT INTO categorias (nombre_categoria, descripcion)
VALUES 
('Computación', 'Laptops, PCs y monitores'),
('Accesorios', 'Periféricos y complementos'),
('Audio', 'Auriculares y parlantes'),
('Almacenamiento', 'Discos y memorias');


INSERT INTO clientes (nombre, email, ciudad, fecha_registro)
VALUES
('María López',   'maria@mail.com',   'Buenos Aires', '2024-01-05'),
('Carlos Ruiz',   'carlos@mail.com',  'Córdoba',      '2024-01-10'),
('Ana Gómez',     'ana@mail.com',     'Rosario',      '2024-02-01'),
('Pedro Sanz',    'pedro@mail.com',   'Mendoza',      '2024-02-15'),
('Laura Torres',  'laura@mail.com',   'Tucumán',      '2024-03-01');

INSERT INTO productos (nombre_producto, id_categoria, precio, stock, activo)
VALUES
('Laptop Pro 15', 1, 1200.00, 15, 1),
('Mouse Inalámbrico', 2, 28.00, 80, 1),
('Monitor 4K 27"', 1, 450.00, 12, 1),
('Auriculares BT Pro',  3,  120.00, 35, 1),
('SSD Externo 1TB', 4, 130.00, 18, 1),
('Teclado Mecánico', 2, 95.00, 40, 1);

INSERT INTO ventas (id_cliente, id_producto, cantidad, precio_unitario, fecha_venta)
VALUES
(1, 1, 2, 1200.00, '2024-01-05'),
(2, 2, 5, 28.00, '2024-01-06'),
(3, 3, 1, 450.00, '2024-02-07'),
(1, 4, 2,  120.00, '2024-02-08'),
(4, 5, 3,  130.00, '2024-03-10'),
(2, 6, 4,   95.00, '2024-03-11'),
(5, 1, 1, 1200.00, '2024-03-12'),
(1, 3, 5, 450.00, '2024-04-10'),
(3, 2, 8,   28.00, '2024-04-13'),
(4, 4, 1,  120.00, '2024-04-14'),
(5, 3, 2,  450.00, '2024-05-15');
go

-- VERIFICACION

SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;


-- ENTREGA 3 



