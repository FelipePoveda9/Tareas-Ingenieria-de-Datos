create database TechCorp;
use TechCorp;

CREATE TABLE empleados (
    id_empleados INT AUTO_INCREMENT PRIMARY KEY,
    primer_nombre VARCHAR(20),
    segundo_nombre VARCHAR(20),
    primer_apellido VARCHAR(20),
    segundo_apellido VARCHAR(20),
    edad INT NOT NULL,
    año_contratacion INT NOT NULL,
    departamento VARCHAR(100) NOT NULL,
    salario INT NOT NULL
);

INSERT INTO empleados (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, edad, año_contratacion, departamento, salario) VALUES
('Ana', 'Lucía', 'Pérez', 'Gómez', 32, 2021, 'Ventas', 4200),
('Carlos', 'Alberto', 'Ruiz', 'Martínez', 45, 2018, 'IT', 5000),
('Andrea', 'María', 'López', 'García', 29, 2023, 'Marketing', 3800),
('Camilo', 'David', 'Moreno', 'Luna', 38, 2020, 'Ventas', 4600),
('Juan', 'Carlos', 'Fernández', 'Torres', 41, 2015, 'Recursos Humanos', 3900),
('Pedro', 'José', 'Jiménez', 'Núñez', 35, 2022, 'Ventas', 4100);

-- Truncate empleados; 
/*Consulta 1*/
-- select primer_nombre, segundo_nombre, edad, salario from empleados
/*Consulta 2*/
-- select primer_nombre, primer_apellido, salario from empleados where salario > 4000
/*Consulta 3*/
-- select primer_nombre, primer_apellido, departamento from empleados where departamento in ("Ventas") 
/*Consulta 4*/
-- select primer_nombre, primer_apellido, edad from empleados where edad > 30 and edad < 40
/*Consulta 5*/
-- select primer_nombre, primer_apellido, año_contratacion from empleados where año_contratacion > 2020 
/*Consulta 6*/
-- select departamento, count(*) as empleados_por_departamento from empleados group by departamento;
/*Consulta 7*/
-- select avg(salario) AS salario_promedio from empleados;
/*Consulta 8*/
-- select primer_nombre, segundo_nombre from empleados where left(primer_nombre, 1) = 'A' or left(segundo_nombre, 1) = 'C';
/*Consulta 9*/
-- select primer_nombre, segundo_nombre from empleados where not departamento in("IT");