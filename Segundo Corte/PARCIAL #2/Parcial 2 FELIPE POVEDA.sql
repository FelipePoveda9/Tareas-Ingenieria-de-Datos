CREATE DATABASE Parcial;
USE Parcial;

CREATE TABLE Departamento (
id_departamento INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
presupuesto DECIMAL(12,2) CHECK (presupuesto > 0)
);

insert into Departamento (nombre, presupuesto) values
('Tecnologia', 100000000),
('Contratacion', 50000000),
('Tecnologia', 150000000),
('Administrativo', 105000000),
('Salud', 500000000);

CREATE TABLE Empleado (
id_empleado INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100),
cargo VARCHAR(50),
salario DECIMAL(10,2) CHECK (salario > 0),
id_departamento INT,
fecha_ingreso DATE,
FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento)
);

insert into Empleado (nombre, cargo, salario, id_departamento, fecha_ingreso) values
('Juan','Gerente',12250000 , 1 ,'2024-10-30'),
('Carlos','Empleado',600000 , 2 ,'2023-10-30'),
('Felipe','Gerente',12250000 , 3 ,'2023-10-30'),
('Jaime','Subgerente',100000 , 4 ,'2025-09-25'),
('Tomas','CEO',31000000 , 5 ,'2020-10-30');

CREATE TABLE Proyecto (
id_proyecto INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100),
fecha_inicio DATE,
presupuesto DECIMAL(12,2),
id_departamento INT,
FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento)
);

insert into Proyecto (nombre, fecha_inicio, presupuesto, id_departamento) values
('InnovaTech','2025-09-30', 25000000 , 1),
('FastContract','2024-09-30',25000000, 2),
('ManageProcess','2025-05-30',25000000, 3),
('Logistica PCT','2025-10-20',25000000, 4),
('FarmaGo','2025-08-30',25000000, 5);

CREATE TABLE Asignacion (
id_asignacion INT AUTO_INCREMENT PRIMARY KEY,
id_empleado INT,
id_proyecto INT,
horas_trabajadas INT CHECK (horas_trabajadas >= 0),
FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
FOREIGN KEY (id_proyecto) REFERENCES Proyecto(id_proyecto)
);

insert into Asignacion (id_empleado, id_proyecto, horas_trabajadas) values
(1, 1, 30),
(2, 2, 60),
(3, 3, 75),
(4, 4, 10),
(5, 5, 95);

-- RETO 6 

-- Impedir que se inserte o actualice un empleado con salario inferior a 1.200.000
-- Trigger: BEFORE INSERT
DELIMITER $$
CREATE TRIGGER empleado_salario
BEFORE INSERT ON Empleado
FOR EACH ROW
BEGIN
    IF NEW.salario < 1200000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El salario no puede ser inferior a 1.200.000';
    END IF;
END$$
DELIMITER ;

insert into Empleado (nombre, cargo, salario, id_departamento, fecha_ingreso) values
('Cesar','Pasante',6000000 , 5 ,'2020-10-30');

-- Trigger: BEFORE UPDATE
DELIMITER $$
CREATE TRIGGER empleado_salario_update_check
BEFORE UPDATE ON Empleado
FOR EACH ROW
BEGIN
    IF NEW.salario < 1200000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El salario no puede ser inferior a 1.200.000';
    END IF;
END$$
DELIMITER ;

update Empleado set salario = 900000 where cargo in('Gerente');

-- Procedimiento: ActualizarSalariosMinimos()
DELIMITER $$
CREATE PROCEDURE ActualizarSalariosMinimos()
BEGIN
    UPDATE Empleado
    SET salario = 1200000
    WHERE salario < 1200000;
END$$
DELIMITER ;

call ActualizarSalariosMinimos();

-- Función: EmpleadosPorDebajoSalarioMin()
DELIMITER $$
CREATE FUNCTION EmpleadosPorDebajoSalarioMin(salario_min DECIMAL(10,2))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidad INT;

    SELECT COUNT(*) as empleados_por_debajo INTO cantidad
    FROM Empleado
    WHERE salario < salario_min
    ORDER BY nombre;

    RETURN cantidad;
END$$
DELIMITER ;

SELECT EmpleadosPorDebajoSalarioMin(1200000);

-- Transacción: Revertir inserciones inválidas.
DELIMITER $$
CREATE PROCEDURE RevertirInsercionesInvalidas()
BEGIN
    START TRANSACTION;
    INSERT INTO Asignacion (id_empleado, id_proyecto, horas_trabajadas) VALUES
    (1, 1, 30),
    (2, 2, 60),
    (3, 3, 75),
    (4, 4, 10),
    (5, 5, -5); -- horas_trabajadas < 0 no son aceptadas

    IF EXISTS (
        SELECT 1
        FROM Asignacion
        WHERE horas_trabajadas < 0) THEN
        ROLLBACK;
        SELECT 'Transacción invalida: se encontraron inserciones erroneas.' AS Resultado;
    ELSE
        COMMIT;
        SELECT 'Transacción completada exitosamente.' AS Resultado;
    END IF;
END$$
DELIMITER ;
describe Asignacion;
alter table Asignacion
modify horas_trabajadas INT;
CALL RevertirInsercionesInvalidas();

