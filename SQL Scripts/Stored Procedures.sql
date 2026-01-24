-- =========================
-- Creación de Stored Procedures.
-- =========================

-- Stored Procedure de alta de un producto.
DELIMITER $$
CREATE PROCEDURE sp_alta_producto (
    IN p_nombre VARCHAR(30),
    IN p_precio DECIMAL(10,2),
    IN p_id_proveedor INT,
    IN p_id_categoria INT
)
BEGIN
    DECLARE v_existe INT;

    IF p_precio <= 0 THEN
        SELECT 'El precio debe ser mayor a 0' AS mensaje;
    ELSE
        -- Verificar si el producto ya existe
        SELECT COUNT(*)
        INTO v_existe
        FROM Productos
        WHERE nombre = p_nombre;

        IF v_existe > 0 THEN
            SELECT 'El producto ya existe' AS mensaje;
        ELSE
            INSERT INTO Productos (nombre, precio, id_proveedor, id_categoria)
            VALUES (p_nombre, p_precio, p_id_proveedor, p_id_categoria);

            SELECT 'Producto creado correctamente' AS mensaje;
        END IF;
    END IF;
END$$
DELIMITER ;

-- Stored Procedure de asignación de stock a un producto en una sucursal.
DELIMITER $$
CREATE PROCEDURE sp_actualizar_inventario (
    IN p_id_producto INT,
    IN p_id_sucursal INT,
    IN p_id_sector INT,
    IN p_stock_actual INT
)
BEGIN
    DECLARE v_existe INT;

    IF p_stock_actual < 0 THEN
        SELECT 'El stock no puede ser negativo' AS mensaje;
    ELSE
        SELECT COUNT(*)
        INTO v_existe
        FROM Inventario
        WHERE id_producto = p_id_producto
          AND id_sucursal = p_id_sucursal
          AND id_sector = p_id_sector;

        IF v_existe > 0 THEN
            UPDATE Inventario
            SET stock_actual = p_stock_actual
            WHERE id_producto = p_id_producto
              AND id_sucursal = p_id_sucursal
              AND id_sector = p_id_sector;

            SELECT 'Stock actualizado correctamente' AS mensaje;
        ELSE
            INSERT INTO Inventario (id_producto, id_sucursal, id_sector, stock_actual)
            VALUES (p_id_producto, p_id_sucursal, p_id_sector, p_stock_actual);

            SELECT 'Stock registrado correctamente' AS mensaje;
        END IF;
    END IF;
END$$
DELIMITER ;

-- =========================
-- Verificación de funcionamiento:

-- CALL sp_alta_producto('Leche Descremada', 950.50, 1, 2);
-- CALL sp_actualizar_inventario(1, 2, 3, 120); 
-- =========================