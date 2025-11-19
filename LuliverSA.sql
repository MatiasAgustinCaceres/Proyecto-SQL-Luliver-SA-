-- Crear el schema
CREATE SCHEMA IF NOT EXISTS LuliverSA;
USE LuliverSA;

-- Tabla Sucursal
CREATE TABLE Sucursal (
    id_sucursal INT AUTO_INCREMENT PRIMARY KEY,
    direccion VARCHAR(30),
    mail VARCHAR(30)
);

-- Tabla Proveedores
CREATE TABLE Proveedores (
    id_provedor INT AUTO_INCREMENT PRIMARY KEY,
    razon_social VARCHAR(30),
    contacto VARCHAR(30)
);

-- Tabla Sectores
CREATE TABLE Sectores (
    id_sector INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30),
    id_sucursal INT,
    FOREIGN KEY (id_sucursal) REFERENCES Sucursal(id_sucursal)
);

-- Tabla Productos
CREATE TABLE Productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30),
    precio INT,
    stock INT,
    id_provedor INT,
    id_sector INT,
    FOREIGN KEY (id_provedor) REFERENCES Proveedores(id_provedor),
    FOREIGN KEY (id_sector) REFERENCES Sectores(id_sector)
);

-- Tabla Empleados
CREATE TABLE Empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30),
    apellido VARCHAR(30),
    puesto VARCHAR(30),
    salario INT,
    id_sucursal INT,
    id_sector INT,
    FOREIGN KEY (id_sucursal) REFERENCES Sucursal(id_sucursal),
    FOREIGN KEY (id_sector) REFERENCES Sectores(id_sector)
);