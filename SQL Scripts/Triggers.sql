-- =========================
-- Creación de Triggers.
-- =========================

-- Trigger para evitar stock negativo en inventario (INSERT).
DELIMITER $$
CREATE TRIGGER trg_inventario_no_stock_negativo_insert
BEFORE INSERT ON Inventario
FOR EACH ROW
BEGIN
    IF NEW.stock_actual < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El stock no puede ser negativo';
    END IF;
END$$
DELIMITER ;

-- Trigger para evitar stock negativo en inventario (UPDATE).
DELIMITER $$
CREATE TRIGGER trg_inventario_no_stock_negativo_update
BEFORE UPDATE ON Inventario
FOR EACH ROW
BEGIN
    IF NEW.stock_actual < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El stock no puede ser negativo';
    END IF;
END$$
DELIMITER ;

-- Trigger para evitar salarios inválidos en empleados.
DELIMITER $$
CREATE TRIGGER trg_empleados_salario_valido
BEFORE INSERT ON Empleados
FOR EACH ROW
BEGIN
    IF NEW.salario <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El salario debe ser mayor a 0';
    END IF;
END$$
DELIMITER ;

-- =========================
-- Verificación de funcionamiento:

-- INSERT INTO Inventario (id_producto, id_sucursal, id_sector, stock_actual)
-- VALUES (1, 1, 1, -10);

-- INSERT INTO Empleados (nombre, apellido, puesto, salario, id_sucursal, id_sector)
-- VALUES ('Test', 'Error', 'Cajero', -5000, 1, 1);
-- =========================
