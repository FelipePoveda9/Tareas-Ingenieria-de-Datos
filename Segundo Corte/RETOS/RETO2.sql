create database BaseDatosMsc;
use BaseDatosMsc;

CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(50) NOT NULL,
    clave VARCHAR(100) NOT NULL,
    rol VARCHAR(20) NOT NULL
);

INSERT INTO usuario (nombre_usuario, clave, rol)
VALUES ('jpoveda', 'clave123', 'cliente');


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

INSERT INTO cliente (cedula, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, direccion, id_usuario)
VALUES ('1011088280', 'Juan', 'Felipe', 'Poveda', 'Jimenez', 'Calle 123', 1);

CREATE TABLE telefono (
    id_telefono INT AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR(20),
    tipo_telefono VARCHAR(20),
    cedula_cliente VARCHAR(20),
    FOREIGN KEY (cedula_cliente) REFERENCES cliente(cedula)
);

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
('M001', 'Firulais', 'Perro', 'M', 'Labrador', '1011088280'),
('M002', 'Michi', 'Gato', 'F', 'Angora', '1011088280'),
('M003', 'Rocky', 'Perro', 'M', 'Pitbull', '1011088280'),
('M004', 'Luna', 'Gato', 'F', 'Siamés', '1011088280'),
('M005', 'Max', 'Perro', 'M', 'Pastor Alemán', '1011088280');
SELECT * FROM mascota;


CREATE TABLE vacuna (
    codigo VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(100),
    dosis VARCHAR(20),
    enfermedad_que_trata VARCHAR(150)
);

CREATE TABLE vacunamascota (
    id_vacuna_mascota INT AUTO_INCREMENT PRIMARY KEY,
    codigo_vacuna VARCHAR(20),
    codigo_mascota VARCHAR(10),
    fecha_aplicacion DATE,
    observaciones TEXT,
    FOREIGN KEY (codigo_vacuna) REFERENCES vacuna(codigo),
    FOREIGN KEY (codigo_mascota) REFERENCES mascota(codigo)
);

CREATE TABLE producto (
    codigo_barras VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(100),
    marca VARCHAR(20),
    precio FLOAT(20)
);

CREATE TABLE venta (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    fecha_venta DATE,
    total FLOAT(20),
    cedula_cliente VARCHAR(20),
    FOREIGN KEY (cedula_cliente) REFERENCES cliente(cedula)
);

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