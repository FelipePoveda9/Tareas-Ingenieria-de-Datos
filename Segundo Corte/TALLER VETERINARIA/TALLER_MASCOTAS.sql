-- Eliminar la base de datos si ya existe (opcional, con cuidado)
DROP DATABASE IF EXISTS tienda_veterinaria;

-- Crear base de datos
CREATE DATABASE tienda_veterinaria;
USE tienda_veterinaria;

-- Tabla: CLIENTE
CREATE TABLE cliente (
    cedula VARCHAR(20) PRIMARY KEY,
    primer_nombre VARCHAR(50),
    segundo_nombre VARCHAR(50),
    primer_apellido VARCHAR(50),
    segundo_apellido VARCHAR(50),
    direccion VARCHAR(100),
    telefono VARCHAR(20)
);

-- Tabla: MASCOTA
CREATE TABLE mascota (
    codigo_mascota INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    raza VARCHAR(50),
    tipo_mascota VARCHAR(30),
    genero VARCHAR(10),
    cedula_cliente VARCHAR(20),
    FOREIGN KEY (cedula_cliente) REFERENCES cliente(cedula)
);

-- Tabla: VACUNA
CREATE TABLE vacuna (
    codigo_vacuna INT AUTO_INCREMENT PRIMARY KEY,
    nombre_vacuna VARCHAR(100),
    dosis VARCHAR(50),
    enfermedad VARCHAR(100)
);

-- Tabla intermedia: APLICAR (relación N:M entre mascota y vacuna)
CREATE TABLE aplicar (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo_mascota INT,
    codigo_vacuna INT,
    fecha_aplicacion DATE,
    FOREIGN KEY (codigo_mascota) REFERENCES mascota(codigo_mascota),
    FOREIGN KEY (codigo_vacuna) REFERENCES vacuna(codigo_vacuna)
);

-- Tabla: PRODUCTO
CREATE TABLE producto (
    codigo_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre_producto VARCHAR(100),
    precio DECIMAL(10, 2),
    marca VARCHAR(50)
);

-- Tabla: VENTA
CREATE TABLE venta (
    codigo_venta INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    cedula_cliente VARCHAR(20),
    FOREIGN KEY (cedula_cliente) REFERENCES cliente(cedula)
);

-- Tabla intermedia: TIENE (relación N:M entre venta y producto)
CREATE TABLE venta_producto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo_venta INT,
    codigo_producto INT,
    cantidad INT,
    FOREIGN KEY (codigo_venta) REFERENCES venta(codigo_venta),
    FOREIGN KEY (codigo_producto) REFERENCES producto(codigo_producto)
);
