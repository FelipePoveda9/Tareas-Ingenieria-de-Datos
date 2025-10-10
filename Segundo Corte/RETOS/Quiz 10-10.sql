create database QuizFunciones;
use QuizFunciones;

CREATE TABLE usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nombreUsuario VARCHAR(50) NOT NULL,
    clave VARCHAR(100) NOT NULL,
    rol VARCHAR(20) NOT NULL
);

INSERT INTO usuario (nombreUsuario, clave, rol) VALUES
('jjaime', 'claveJaime123', 'cliente'),
('jtomas', 'claveTomas456', 'cliente'),
('jjuan', 'claveJuan789', 'cliente'),
('jdavid', 'claveDavid101', 'cliente'),
('jcamilo', 'claveCamilo202', 'cliente');

CREATE TABLE cliente (
    cedula VARCHAR(20) PRIMARY KEY,
    primerNombre VARCHAR(20),
    segundoNombre VARCHAR(20),
    primerApellido VARCHAR(20),
    segundoApellido VARCHAR(20),
    direccion VARCHAR(200),
    idUsuario INT,
    FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario)
);

INSERT INTO cliente (cedula, primerNombre, segundoNombre, primerApellido, segundoApellido, direccion, idUsuario) VALUES
('1011088281', 'Jaime', 'Alberto', 'Lopez', 'Gonzalez', 'Calle 10, Av. Principal', 1),
('1011088282', 'Tomás', 'Antonio', 'Pérez', 'Martínez', 'Calle 11, Zona 5', 2),
('1011088283', 'Juan', 'Carlos', 'Poveda', 'Jiménez', 'Calle 12, Edificio 5', 3),
('1011088284', 'David', 'Andrés',  'Cabrera', 'Ruiz', 'Calle 13, Piso 3', 4),
('1011088285', 'Camilo', 'Fernando', 'Gómez', 'Sánchez', 'Calle 14, Casa 8', 5);

CREATE TABLE mascota (
    codigo VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(100),
    tipo VARCHAR(20),
    genero CHAR(1),
    raza VARCHAR(20),
    cedulaCliente VARCHAR(20),
    FOREIGN KEY (cedulaCliente) REFERENCES cliente(cedula)
);

INSERT INTO mascota (codigo, nombre, tipo, genero, raza, cedulaCliente) VALUES
('M001', 'Firulais', 'Perro', 'M', 'Labrador', '1011088281'),  -- Jaime
('M002', 'Michi', 'Gato', 'F', 'Angora', '1011088282'),       -- Tomás
('M003', 'Rocky', 'Perro', 'M', 'Pitbull', '1011088283'),     -- Juan
('M004', 'Luna', 'Gato', 'F', 'Siamés', '1011088284'),        -- David
('M005', 'Max', 'Perro', 'M', 'Pastor Alemán', '1011088285'); -- Camilo

CREATE TABLE vacuna (
    codigo VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(100),
    dosis VARCHAR(20),
    enfermedadQueTrata VARCHAR(150),
    fechaVigencia DATE
);

INSERT INTO vacuna (codigo, nombre, dosis, enfermedadQueTrata, fechaVigencia) VALUES
('V001', 'Rabia', '1', 'Rabia', '2024-10-01'),
('V002', 'Leptospirosis', '2', 'Leptospirosis', '2025-10-20'),
('V003', 'Parvovirus', '3', 'Parvovirus', '2025-10-30'),
('V004', 'Adenovirus', '2', 'Adenovirus', '2024-09-09'),
('V005', 'Distemper', '3', 'Distemper', '2024-10-01');

-- Crear una tabla trigger auditoria para guardar los logs cada que se registre un cliente se registre en esa tabla cliente.

CREATE TABLE auditoriaCliente (
    idLog INT AUTO_INCREMENT PRIMARY KEY,
    cedulaCliente VARCHAR(20),
    nombreCompleto VARCHAR(100),
    fechaHora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    accion VARCHAR(20)
);

DELIMITER $$

CREATE TRIGGER auditoriaLogNuevo
AFTER INSERT ON cliente
FOR EACH ROW
BEGIN
    insert into auditoriaCliente (cedulaCliente, nombreCompleto, accion) VALUES 
    (new.cedula,  CONCAT(new.primerNombre, ' ', new.primerApellido), 'INSERT');
END $$

DELIMITER ;

INSERT INTO cliente (cedula, primerNombre, segundoNombre, primerApellido, segundoApellido, direccion, idUsuario) VALUES 
('1011088286', 'Luis', 'Miguel', 'Rodríguez', 'Vega', 'Calle 20, Torre B', 1);

select * from auditoriaCliente;


-- 1. Crear una función para saber si la vacuna esta vigente o esta vencida

DELIMITER $$

CREATE FUNCTION VerificarVigenciaVacuna(fechaVigencia DATE)
RETURNS VARCHAR(20)
BEGIN
    DECLARE resultado VARCHAR(20);
    
    if fechaVigencia >= CURDATE() then
        set resultado = 'Vigente';
    else
        set resultado = 'Vencida';
    end if;
    
    RETURN resultado;
END $$
DELIMITER ;

select codigo, nombre, VerificarVigenciaVacuna(fechaVigencia) as estadoVigencia
from vacuna;

DELIMITER $$

-- 2. Crear función para mostrar el nombre de la mascota, la raza y el nombre del propietario

DELIMITER $$

CREATE FUNCTION ObtenerDatosMascota(codigoMascota VARCHAR(10))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE resultado VARCHAR(255);
    select CONCAT('Mascota: ', m.nombre, ', Raza: ', m.raza, ', Propietario: ', c.primerNombre, ' ', c.primerApellido)
    into resultado from mascota m join cliente c on m.cedulaCliente in(c.cedula) where m.codigo in(codigoMascota);
    RETURN resultado;
END $$

DELIMITER ;

select ObtenerDatosMascota('M001');

-- 3. Trigger que impida eliminar un cliente si tiene una mascota registrada

DELIMITER $$

CREATE TRIGGER impedirEliminacionClienteConMascota
BEFORE DELETE ON cliente
FOR EACH ROW
BEGIN
    if (select COUNT(*) from mascota where cedulaCliente in(old.cedula)) > 0 THEN
        signal sqlstate '45000'
        set message_text = 'No se puede eliminar el cliente porque tiene mascotas registradas.';
    end if;
END $$

DELIMITER ;

delete from cliente where cedula in('1011088281'); 

-- 4. Trigger para guardar al cliente eliminado en una tabla.

create table clientesEliminados (
    cedula varchar(20),
    primerNombre varchar(20),
    segundoNombre varchar(20),
    primerApellido varchar(20),
    segundoApellido varchar(20),
    direccion varchar(200),
    idUsuario int,
    fechaEliminacion timestamp default current_timestamp
);

delete from mascota where cedulaCliente in('1011088286');
delete from cliente where cedula in('1011088286');

DELIMITER $$

CREATE TRIGGER guardarClienteEliminado
AFTER DELETE ON cliente
FOR EACH ROW
BEGIN
    insert into clientesEliminados (cedula, primerNombre, segundoNombre, primerApellido, segundoApellido, direccion, idUsuario) values 
    (old.cedula, old.primerNombre, old.segundoNombre, old.primerApellido, old.segundoApellido, old.direccion, old.idUsuario    );
END $$

DELIMITER ;

select * from clientesEliminados;


-- 5. Agregar columna fechaDeActualizacion a la tabla cliente y trigger de actualización.

alter table cliente
add column fechaDeActualizacion timestamp null;

delimiter $$

CREATE TRIGGER actualizarFechaCliente
BEFORE UPDATE ON cliente
FOR EACH ROW
BEGIN
    set new.fechaDeActualizacion = current_timestamp;
END $$

delimiter ;

update cliente set direccion = 'Nueva dirección' where cedula in('1011088285');
select cedula, direccion, fechaDeActualizacion from cliente where cedula in('1011088285');