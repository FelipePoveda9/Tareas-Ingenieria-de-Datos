CREATE DATABASE TechCorp;
USE TechCorp;

CREATE TABLE departamento (
    id_departamento INT AUTO_INCREMENT PRIMARY KEY,
    nombre_departamento VARCHAR(100)
);

INSERT INTO departamento (nombre_departamento) VALUES
('IT'),
('Ventas'),
('Publicidad'),
('Mercadeo'),
('Cocina');

CREATE TABLE empleados (
    id_empleados INT AUTO_INCREMENT PRIMARY KEY,
    primer_nombre VARCHAR(20),
    segundo_nombre VARCHAR(20),
    primer_apellido VARCHAR(20),
    segundo_apellido VARCHAR(20),
    fecha_nacimiento INT NOT NULL,
    fecha_actual INT NOT NULL,
    año_contratacion INT NOT NULL,
    salario INT NOT NULL,
    id_departamento INT, 
    FOREIGN KEY (id_departamento) REFERENCES departamento(id_departamento)
);

INSERT INTO empleados (primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, fecha_nacimiento, fecha_actual, año_contratacion, salario, id_departamento) VALUES
('Ana', 'Lucía', 'Pérez', 'Gómez', 1993, 2025, 2021, 4200, 1),  
('Carlos', 'Alberto', 'Ruiz', 'Martínez', 1979, 2025, 2022, 5000, 2), 
('Andrea', 'María', 'López', 'García', 1996, 2025, 2023, 3800, 3), 
('Camilo', 'David', 'Moreno', 'Luna', 1987, 2025, 2020, 4600, 4),
('Juan', 'Carlos', 'Fernández', 'Torres', 1984, 2025, 2015, 3900, 1), 
('Pedro', 'José', 'Jiménez', 'Núñez', 1990, 2025, 2022, 4100, 2); 


/*Truncate empleados;*/
/*consulta 1*/ select primer_nombre, segundo_nombre, (fecha_actual - fecha_nacimiento) as edad, salario from empleados;

/*consulta 2*/ select primer_nombre, primer_apellido, salario from empleados where salario > 4000;

/*consulta 3*/ 
select primer_nombre, primer_apellido, nombre_departamento 
from empleados inner join departamento on empleados.id_departamento in (departamento.id_departamento) 
where nombre_departamento = "Ventas"; -- Multitabla

/*consulta 4*/ select primer_nombre, primer_apellido, (fecha_actual - fecha_nacimiento) as edad from empleados where (fecha_actual - fecha_nacimiento) between 30 and 40;

/*consulta 5*/ select primer_nombre, primer_apellido, año_contratacion from empleados where año_contratacion > 2020;

/*consulta 6*/ 
select nombre_departamento, count(*) as empleados_por_departamento 
from empleados join departamento on empleados.id_departamento = departamento.id_departamento 
group by nombre_departamento;


/*consulta 7*/ select avg(salario) as salario_promedio from empleados;

/*consulta 8*/ select primer_nombre, segundo_nombre from empleados where primer_nombre like 'A%' or primer_nombre like 'C%';

/*consulta 9*/ 
select primer_nombre, segundo_nombre 
from empleados 
where id_departamento not in (select id_departamento from departamento where nombre_departamento in ("IT"));

/*Consulta 10*/ select primer_nombre, segundo_nombre, salario from empleados where salario = (select max(salario) from empleados);

/*Consulta QUiz: Empleados que pertenecen al departamento de ventas*/ 
select primer_nombre, primer_apellido, (select nombre_departamento from departamento where id_departamento in (empleados.id_departamento)) as departamento
from empleados where id_departamento in (select id_departamento from departamento where nombre_departamento in ("Ventas"));

/*Ejemplo multitabla*/
select empleados.primer_nombre as 'Empleado', departamento.nombre_departamento as 'Departamento'
from empleados
inner join departamento departamento on empleados.id_departamento = departamento.id_departamento;

/*Consultar empledados cuyo salario sea mayor al salario de la empresa*/ -- Salario empresa'4266.6667'
select primer_nombre, salario from empleados where salario > (select avg(salario) as salario_promedio from empleados);

/*Econtrar nombre del empreado con el segundo salario mas alto*/
select primer_nombre, segundo_nombre, primer_apellido, salario 
from empleados 
where salario = (select max(salario) from empleados where salario < (select max(salario) from empleados));

/*Usando left join muestre los departamentos que no tienen empleados asiganados*/
select departamento.nombre_departamento 
from departamento
left join empleados empleados on departamento.id_departamento in (empleados.id_departamento)
where empleados.id_empleados is null;


/*Total empleados por cada departamento*/
select nombre_departamento, count(*) as empleados_por_departamento 
from empleados join departamento on empleados.id_departamento in (departamento.id_departamento) 
group by nombre_departamento;
