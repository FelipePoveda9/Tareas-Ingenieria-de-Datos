create database ventasTienda;
use ventasTienda; 

create table cliente(
	iDCliente int auto_increment primary key, #Autoincrement incrementa de forma automatica 
	documentoCliente varchar(50) not null,
	nombreCliente varchar(50) not null,
	email varchar(50) unique, 
	telefono varchar(50),
	fechaRegistro timestamp default current_timestamp
);

#alter modifica la estructura de la base de datos (puede ser cualquier cosa, entre atributos, tablas, indices, datos, casillas, etc...)
describe cliente;
alter table cliente add direccionCliente varchar(20); #add añade a la tabla un campo
alter table cliente modify telefono varchar(15) not null; #modify modifica un campo de la tabla
alter table cliente drop column direccionCliente; #drop elimina la columna que se llama, en este caso es direccionCliente
alter table cliente change email emailCliente varchar(50) unique; #change se usa para cambiar el nombre de la columna UNICAMENTE (tambien se puede usar rename)

create table pedido( #En este caso la tabla con el "muchos" seria pedidos 
	idPedido int auto_increment primary key, 
	idClienteFK int,
	fechaPedido date,
	total decimal (10,2),
	foreign key (idClienteFK) references cliente(idCliente) #Esta es la manera de crear una relacion dentro de una tabla
);

create table usuario(
    idUsuario int auto_increment primary key,
    idClienteFK int,
    nombreUsuario varchar(50) unique not null,
    foreign key (idClienteFK) references cliente(idCliente) 
);

create table producto(
    idProducto int auto_increment primary key,
    nombreProducto varchar(100) not null,
    precio decimal(10,2) not null,
    stock int not null
);

create table detallePedido( #Aquí se relacionan los productos con los pedidos (muchos a muchos simulados)
    idDetallePedido int auto_increment primary key,
    cantidad int not null,
    precioUnitario decimal(10,2) not null
);

alter table detallePedido add idProductoFK int; #Relación con productos
alter table detallePedido add constraint fk_producto_detallePedido foreign key (idProductoFK) references producto(idProducto);

alter table detallePedido add idPedidoFK int; #Relación con pedidos
alter table detallePedido add constraint fk_pedido_detallePedido foreign key (idPedidoFK) references pedido(idPedido);


/*alter table pedido #Esta es la manera de realizar una relacion fuera de una tabla
add constraint FKclientePedido
foreign key (idClienteFK)
references cliente(idCliente);*/

#drop table pedido;
#drop table cliente;