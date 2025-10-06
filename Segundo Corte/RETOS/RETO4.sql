CREATE DATABASE BaseDatosMsc;
USE BaseDatosMsc;

CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(50) NOT NULL,
    clave VARCHAR(100) NOT NULL,
    rol VARCHAR(20) NOT NULL
);

INSERT INTO usuario (nombre_usuario, clave, rol) VALUES
('jjaime', 'claveJaime123', 'cliente'),
('jtomas', 'claveTomas456', 'cliente'),
('jjuan', 'claveJuan789', 'cliente'),
('jdavid', 'claveDavid101', 'cliente'),
('jcamilo', 'claveCamilo202', 'cliente');


CREATE TABLE cliente (
    cedula VARCHAR(20) PRIMARY KEY,
    primer_nombre VARCHAR(20),
    segundo_nombre VARCHAR(20),
    primer_apellido VARCHAR(20),
    segundo_apellido VARCHAR(20),
    direccion VARCHAR(200),
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

INSERT INTO cliente (cedula, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, direccion, id_usuario) VALUES
('1011088281', 'Jaime', 'Alberto', 'Lopez', 'Gonzalez', 'Calle 10, Av. Principal', 1),
('1011088282', 'Tomás', 'Antonio', 'Pérez', 'Martínez', 'Calle 11, Zona 5', 2),
('1011088283', 'Juan', 'Carlos', 'Poveda', 'Jiménez', 'Calle 12, Edificio 5', 3),
('1011088284', 'David', 'Andrés', 'Cabrera', 'Ruiz', 'Calle 13, Piso 3', 4),
('1011088285', 'Camilo', 'Fernando', 'Gómez', 'Sánchez', 'Calle 14, Casa 8', 5);

CREATE TABLE telefono (
    id_telefono INT AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR(20),
    tipo_telefono VARCHAR(20),
    cedula_cliente VARCHAR(20),
    FOREIGN KEY (cedula_cliente) REFERENCES cliente(cedula)
);

INSERT INTO telefono (numero, tipo_telefono, cedula_cliente) VALUES
('3101234567', 'Móvil', '1011088281'),
('3112345678', 'Móvil', '1011088282'),
('3123456789', 'Fijo', '1011088283'),
('3134567890', 'Móvil', '1011088284'),
('3145678901', 'Fijo', '1011088285');

CREATE TABLE mascota (
    codigo VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(100),
    tipo VARCHAR(20),
    genero CHAR(1),
    raza VARCHAR(20),
    cedula_cliente VARCHAR(20),
    FOREIGN KEY (cedula_cliente) REFERENCES cliente(cedula)
);

INSERT INTO mascota (codigo, nombre, tipo, genero, raza, cedula_cliente) VALUES
('M001', 'Firulais', 'Perro', 'M', 'Labrador', '1011088281'),  -- Jaime
('M002', 'Michi', 'Gato', 'F', 'Angora', '1011088282'),       -- Tomás
('M003', 'Rocky', 'Perro', 'M', 'Pitbull', '1011088283'),     -- Juan
('M004', 'Luna', 'Gato', 'F', 'Siamés', '1011088284'),        -- David
('M005', 'Max', 'Perro', 'M', 'Pastor Alemán', '1011088285'); -- Camilo


CREATE TABLE vacuna (
    codigo VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(100),
    dosis VARCHAR(20),
    enfermedad_que_trata VARCHAR(150)
);

INSERT INTO vacuna (codigo, nombre, dosis, enfermedad_que_trata) VALUES
('V001', 'Rabia', '1', 'Rabia'),
('V002', 'Leptospirosis', '2', 'Leptospirosis'),
('V003', 'Parvovirus', '3', 'Parvovirus'),
('V004', 'Adenovirus', '2', 'Adenovirus'),
('V005', 'Distemper', '3', 'Distemper');

CREATE TABLE vacunamascota (
    id_vacuna_mascota INT AUTO_INCREMENT PRIMARY KEY,
    codigo_vacuna VARCHAR(20),
    codigo_mascota VARCHAR(10),
    fecha_aplicacion DATE,
    observaciones TEXT,
    FOREIGN KEY (codigo_vacuna) REFERENCES vacuna(codigo),
    FOREIGN KEY (codigo_mascota) REFERENCES mascota(codigo)
);

INSERT INTO vacunamascota (codigo_vacuna, codigo_mascota, fecha_aplicacion, observaciones) VALUES
('V001', 'M001', '2025-09-01', 'Primera dosis para prevención de rabia'),  -- Firulais (Jaime)
('V002', 'M002', '2025-09-02', 'Prevención de leptospirosis'),           -- Michi (Tomás)
('V003', 'M003', '2025-09-03', 'Vacuna contra parvovirus'),             -- Rocky (Juan)
('V004', 'M004', '2025-09-04', 'Adenovirus, dosis 2'),                  -- Luna (David)
('V005', 'M005', '2025-09-05', 'Vacuna para distemper, dosis completa'); -- Max (Camilo)

CREATE TABLE producto (
    codigo_barras VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(100),
    marca VARCHAR(20),
    precio FLOAT(20)
);

INSERT INTO producto (codigo_barras, nombre, marca, precio) VALUES
('P001', 'Alimento Canino', 'Pedigree', 25.50),
('P002', 'Alimento Felino', 'Whiskas', 18.00),
('P003', 'Collar Antipulgas', 'Frontline', 15.00),
('P004', 'Cama para Mascota', 'PetSoft', 40.00),
('P005', 'Juguete para Gato', 'Catnip', 10.00);

CREATE TABLE venta (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    fecha_venta DATE,
    total FLOAT(20),
    cedula_cliente VARCHAR(20),
    FOREIGN KEY (cedula_cliente) REFERENCES cliente(cedula)
);

INSERT INTO venta (fecha_venta, total, cedula_cliente) VALUES
('2025-09-10', 55.50, '1011088281'),
('2025-09-11', 45.00, '1011088282'),
('2025-09-12', 70.00, '1011088283'),
('2025-09-13', 85.00, '1011088284'),
('2025-09-14', 40.00, '1011088285');

CREATE TABLE detalleventa (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT,
    codigo_producto VARCHAR(20),
    cantidad INT,
    precio_unitario FLOAT(20),
    subtotal FLOAT(20),
    FOREIGN KEY (id_venta) REFERENCES venta(id_venta),
    FOREIGN KEY (codigo_producto) REFERENCES producto(codigo_barras)
);

INSERT INTO detalleventa (id_venta, codigo_producto, cantidad, precio_unitario, subtotal) VALUES
(1, 'P001', 1, 25.50, 25.50),
(2, 'P002', 2, 18.00, 36.00),
(3, 'P003', 1, 9.00, 9.00),
(4, 'P004', 2, 25.50, 51.00),
(5, 'P005', 1, 10.00, 10.00);


-- select cantidad, subtotal
-- order by: Ordena de manera ascendente
-- order by ____desc: Ordena de manera descendente 
-- SELECT *: Toda la tabla
-- TRUNCATE TABLE: Limpia la tabla

/*select nombre, marca
from producto 
order by nombre;*/

/*SELECT cedula_cliente, SUM(total) AS total_compras
FROM venta
GROUP BY cedula_cliente;*/

-- OPERADOR LOGICO NO
/*SELECT * FROM producto
WHERE NOT marca = 'Pedigree';*/

-- OPERADOR LOGICO Ó
/*SELECT * FROM producto
WHERE marca = 'Pedigree' OR marca = 'Whiskas';*/

-- OPERADOR LOGICO Y
/*SELECT * FROM producto
WHERE precio > 10 AND marca = 'Pedigree';*/

-- OPERADORES LOGICOS MIX
/*SELECT * FROM producto
WHERE (marca = 'Pedigree' OR marca = 'Whiskas') AND precio < 30;*/

-- Fuciones Agregado
/*
AVG: select * avg(campo) as alias from tabla
SUM: select * sum(campo) from tabla 
COUNT: select * count(argumento) as alias from tabla where condicion
MAX: select * max(campo) as alias from tabla where condicion
MIN: select * min(campo) as alias from tabla where condicion
WHERE antes de agrupar
HAVING despues de agrupar*/

SELECT AVG(precio) AS promedio_precios
FROM producto;

SELECT SUM(total) AS total_recaudado
FROM venta;

SELECT SUM(cantidad) AS total_productos_vendidos
FROM detalleventa;

SELECT cedula_cliente, SUM(total) AS total_compras
FROM venta
GROUP BY cedula_cliente;

SELECT cedula_cliente, SUM(total) AS total_compras
FROM venta
GROUP BY cedula_cliente
HAVING total_compras > 60;

SELECT COUNT(codigo_producto) AS productos_diferentes
FROM detalleventa;

SELECT MAX(precio) AS precio_maximo
FROM producto;

SELECT MIN(precio) AS precio_minimo, MAX(precio) AS precio_maximo
FROM producto;

SELECT cedula_cliente, COUNT(*) AS cantidad_ventas
FROM venta
GROUP BY cedula_cliente;

SELECT cedula_cliente, COUNT(*) AS total_mascotas
FROM mascota
GROUP BY cedula_cliente;
