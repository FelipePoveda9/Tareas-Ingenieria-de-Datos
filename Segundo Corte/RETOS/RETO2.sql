crete database BaseMacostas;
use BaseMacostas;

create table Clientes(
    idCliente int primary key auto_increment,
    nombre varchar(50) not null,
    apellido varchar(50) not null,
    email varchar(100) not null unique,
    telefono varchar(15),
    direccion varchar(200)
);

create table Mascotas(
    idMascota int primary key auto_increment,
    nombre varchar(50) not null,
    tipo varchar(30) not null,
    raza varchar(50),
    edad int,
    idCliente int,
    foreign key (idCliente) references Clientes(idCliente)
);

create table Telefono(
    idTelefono int primary key auto_increment,
    numero varchar(15) not null,
    tipo varchar(20),
    idCliente int,
    foreign key (idCliente) references Clientes(idCliente)
);

create table Productos(
    idProducto int primary key auto_increment,
    nombre varchar(100) not null,
    descripcion varchar(255),
    precio decimal(10,2) not null,
    stock int not null
);

create table Ventas(
    idVenta int primary key auto_increment,
    fecha date not null,
    total decimal(10,2) not null,
    idCliente int,
    foreign key (idCliente) references Clientes(idCliente)
);

create table DetalleVentas(
    idDetalle int primary key auto_increment,
    idVenta int,
    idProducto int,
    cantidad int not null,
    precio decimal(10,2) not null,
    subtotal decimal(10,2) not null,
    foreign key (idVenta) references Ventas(idVenta),
    foreign key (idProducto) references Productos(idProducto)
);

create table Vacunas(
    idVacuna int primary key auto_increment,
    nombre varchar(100) not null,
    descripcion varchar(255),
    fechaAplicacion date,
    idMascota int,
    foreign key (idMascota) references Mascotas(idMascota)
);

create table VacunaMascota(
    idVacunaMascota int primary key auto_increment,
    idVacuna int,
    idMascota int,
    fechaAplicacion date,
    foreign key (idVacuna) references Vacunas(idVacuna),
    foreign key (idMascota) references Mascotas(idMascota)
);