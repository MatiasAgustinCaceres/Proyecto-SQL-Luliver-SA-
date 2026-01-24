-- =========================
-- Creación del Schema.
-- =========================

CREATE SCHEMA IF NOT EXISTS LuliverSA;
USE LuliverSA;

-- =========================
-- Creación de Tablas.
-- =========================

-- Tabla Sucursal
CREATE TABLE Sucursal (
    id_sucursal INT AUTO_INCREMENT PRIMARY KEY,
    direccion VARCHAR(30) NOT NULL,
    mail VARCHAR(30) NOT NULL
);

-- Tabla Proveedores
CREATE TABLE Proveedores (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    razon_social VARCHAR(30) NOT NULL,
    contacto VARCHAR(30) NOT NULL
);

-- Tabla Categorias
CREATE TABLE Categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL
);

-- Tabla Sectores
CREATE TABLE Sectores (
    id_sector INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    id_sucursal INT NOT NULL,
    FOREIGN KEY (id_sucursal) REFERENCES Sucursal(id_sucursal)
);

-- Tabla Productos
CREATE TABLE Productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    id_proveedor INT NOT NULL,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES Proveedores(id_proveedor),
    FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria)
);

-- Tabla Inventari
CREATE TABLE Inventario (
    id_inventario INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    id_sucursal INT NOT NULL,
    id_sector INT NOT NULL,
    stock_actual INT NOT NULL CHECK (stock_actual >= 0),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto),
    FOREIGN KEY (id_sucursal) REFERENCES Sucursal(id_sucursal),
    FOREIGN KEY (id_sector) REFERENCES Sectores(id_sector)
);

-- Tabla Empleados
CREATE TABLE Empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    puesto VARCHAR(30) NOT NULL,
    salario DECIMAL(10,2) NOT NULL CHECK (salario > 0),
    id_sucursal INT NOT NULL,
    id_sector INT NOT NULL,
    FOREIGN KEY (id_sucursal) REFERENCES Sucursal(id_sucursal),
    FOREIGN KEY (id_sector) REFERENCES Sectores(id_sector)
);

-- =========================
-- Carga de Datos
-- =========================

-- Sucursales
INSERT INTO Sucursal (direccion, mail) VALUES
('Av. San Martín 123', 'sanmartin@luliver.com'),
('Av. Rivadavia 456', 'rivadavia@luliver.com'),
('Av. Belgrano 789', 'belgrano@luliver.com'),
('Av. Corrientes 321', 'corrientes@luliver.com');

-- Proveedores
INSERT INTO Proveedores (razon_social, contacto) VALUES
('La Serenisima', 'ventas@serenisima.com'),
('Molinos Rio', 'contacto@molinos.com'),
('Arcor SA', 'info@arcor.com'),
('Danone', 'danone@proveedores.com'),
('Sancor', 'sancor@proveedores.com'),
('Unilever', 'unilever@proveedores.com');

-- Categorias
INSERT INTO Categorias (nombre) VALUES
('Lacteos'),
('Almacen'),
('Golosinas'),
('Bebidas'),
('Limpieza'),
('Congelados');

-- Sectores
INSERT INTO Sectores (nombre, id_sucursal) VALUES
('Lacteos', 1),
('Almacen', 1),
('Limpieza', 1),
('Lacteos', 2),
('Golosinas', 2),
('Bebidas', 3),
('Congelados', 3),
('Almacen', 4);

-- Productos
INSERT INTO Productos (nombre, precio, id_proveedor, id_categoria) VALUES
('Leche Entera', 450.50, 1, 1),
('Yogur Natural', 380.00, 4, 1),
('Queso Cremoso', 1250.75, 5, 1),
('Manteca', 690.00, 5, 1),
('Fideos', 520.75, 2, 2),
('Arroz', 610.20, 2, 2),
('Aceite', 1350.90, 2, 2),
('Harina', 480.30, 2, 2),
('Chocolate', 610.30, 3, 3),
('Caramelos', 420.00, 3, 3),
('Gaseosa Cola', 890.00, 6, 4),
('Agua Mineral', 350.00, 6, 4),
('Detergente', 740.50, 6, 5),
('Lavandina', 410.00, 6, 5),
('Hamburguesas', 1800.00, 6, 6),
('Papas Congeladas', 1500.00, 6, 6);

-- Inventario
INSERT INTO Inventario (id_producto, id_sucursal, id_sector, stock_actual) VALUES
(1, 1, 1, 120),
(2, 1, 1, 90),
(3, 1, 1, 40),
(4, 1, 1, 60),
(5, 1, 2, 70),
(6, 1, 2, 85),
(7, 1, 2, 50),
(8, 1, 2, 65),
(1, 2, 4, 110),
(2, 2, 4, 95),
(9, 2, 5, 150),
(10, 2, 5, 130),
(11, 3, 6, 200),
(12, 3, 6, 180),
(15, 3, 7, 70),
(16, 3, 7, 90),
(5, 4, 8, 60),
(6, 4, 8, 55),
(13, 4, 8, 75),
(14, 4, 8, 80);

-- Empleados
INSERT INTO Empleados (nombre, apellido, puesto, salario, id_sucursal, id_sector) VALUES
('Juan', 'Perez', 'Cajero', 300000.00, 1, 2),
('Maria', 'Gomez', 'Cajera', 305000.00, 1, 2),
('Carlos', 'Diaz', 'Repositor', 280000.00, 1, 1),
('Laura', 'Fernandez', 'Supervisor', 420000.00, 1, 3),
('Lucia', 'Martinez', 'Cajera', 300000.00, 2, 5),
('Ana', 'Lopez', 'Cajera', 305000.00, 2, 5),
('Lucas', 'Suarez', 'Repositor', 285000.00, 2, 4),
('Martin', 'Romero', 'Supervisor', 430000.00, 2, 4),
('Sofia', 'Alvarez', 'Cajera', 300000.00, 3, 6),
('Paula', 'Benitez', 'Cajera', 305000.00, 3, 6),
('Diego', 'Mendez', 'Repositor', 290000.00, 3, 7),
('Nicolas', 'Vega', 'Supervisor', 440000.00, 3, 7),
('Carla', 'Rios', 'Cajera', 300000.00, 4, 8),
('Julieta', 'Silva', 'Cajera', 305000.00, 4, 8),
('Andres', 'Torres', 'Repositor', 285000.00, 4, 8),
('Federico', 'Luna', 'Supervisor', 435000.00, 4, 8);

-- =========================
-- Verificación de carga de datos:

-- SELECT * FROM Sucursal;
-- SELECT * FROM Proveedores;
-- SELECT * FROM Categorias;
-- SELECT * FROM Sectores;
-- SELECT * FROM Productos;
-- SELECT * FROM Inventario;
-- SELECT * FROM Empleados;
-- =========================