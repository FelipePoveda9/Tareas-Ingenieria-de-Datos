CREATE DATABASE BaseDatosMsc;
USE BaseDatosMsc;

CREATE TABLE Cliente (
    cedula VARCHAR(20) PRIMARY KEY NOT NULL,
    primer_nombre VARCHAR(30) NOT NULL,
    segundo_nombre VARCHAR(30) NOT NULL,
    primer_apellido VARCHAR(30) NOT NULL,
    segundo_apellido VARCHAR(30) NOT NULL,
    direccion VARCHAR(225) NOT NULL
);

CREATE TABLE Telefono (
    id_telefono INT PRIMARY KEY NOT NULL,
    numero VARCHAR(20) NOT NULL,
    tipo_telefono VARCHAR(25) NOT NULL,
    cedula_cliente VARCHAR(20) NOT NULL,
    FOREIGN KEY (cedula_cliente) REFERENCES Cliente(cedula)
);

CREATE TABLE Producto (
    id_producto VARCHAR(20) PRIMARY KEY NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    precio_unitario FLOAT 
);

CREATE TABLE Venta (
    id_venta INT PRIMARY KEY,
    fechadeventa DATE,
    total FLOAT,
    cedula_cliente VARCHAR(40),
    FOREIGN KEY (cedula_cliente) REFERENCES Cliente(cedula)
);

CREATE TABLE DetalleVenta (
    id_detalle INT PRIMARY KEY,
    id_venta INT,
    codigo_producto VARCHAR(50),
    cantidad INT,
    precio FLOAT,
    subtotal FLOAT,
    FOREIGN KEY (id_venta) REFERENCES Venta(id_venta),
    FOREIGN KEY (codigo_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Mascota (
    codigo VARCHAR(10) PRIMARY KEY NOT NULL,
    nombre_tabla VARCHAR(100) NOT NULL,
    tipo VARCHAR(25) NOT NULL,
    genero CHAR(1) CHECK (genero IN ('M', 'H')),
    raza VARCHAR(100) NOT NULL,
    cedula_cliente VARCHAR(20) NOT NULL,
    FOREIGN KEY (cedula_cliente) REFERENCES Cliente(cedula) 
);

CREATE TABLE Vacuna (
    nombre VARCHAR(30) PRIMARY KEY NOT NULL,
    dosis VARCHAR(100) NOT NULL,
    codigo VARCHAR(25) NOT NULL,
    enfermedad VARCHAR(255) NOT NULL
);

CREATE TABLE VacunaMascota (
    id_vacuna_mascota INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    codigo_vacuna VARCHAR(100) NOT NULL,
    codigo_mascota VARCHAR(25) NOT NULL,
    fecha_aplicacion DATETIME NOT NULL,
    observaciones TEXT NULL,
    FOREIGN KEY (codigo_vacuna) REFERENCES Vacuna(nombre),
    FOREIGN KEY (codigo_mascota) REFERENCES Mascota(codigo)
);
