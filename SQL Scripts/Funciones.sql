-- =========================
-- Creación de Funciones.
-- =========================

-- Funcion de stock total de un producto.
DELIMITER $$
CREATE FUNCTION fn_stock_total_producto_por_nombre(p_nombre_producto VARCHAR(30))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_id_producto INT;
    DECLARE v_stock_total INT;

    -- Obtener el ID del producto
    SELECT id_producto
    INTO v_id_producto
    FROM Productos
    WHERE nombre = p_nombre_producto
    LIMIT 1;

    -- Si el producto no existe
    IF v_id_producto IS NULL THEN
        RETURN NULL;
    END IF;

    -- Calcular stock total
    SELECT SUM(stock_actual)
    INTO v_stock_total
    FROM Inventario
    WHERE id_producto = v_id_producto;

    RETURN IFNULL(v_stock_total, 0);
END$$
DELIMITER ;

-- Funcion del salario medio por sector.
DELIMITER $$
CREATE FUNCTION fn_salario_promedio_sector(p_nombre_sector VARCHAR(30))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_id_sector INT;
    DECLARE v_salario_promedio DECIMAL(10,2);

    -- Obtener ID del sector
    SELECT id_sector
    INTO v_id_sector
    FROM Sectores
    WHERE nombre = p_nombre_sector
    LIMIT 1;

    -- Si el sector no existe
    IF v_id_sector IS NULL THEN
        RETURN NULL;
    END IF;

    -- Calcular salario promedio
    SELECT AVG(salario)
    INTO v_salario_promedio
    FROM Empleados
    WHERE id_sector = v_id_sector;

    RETURN v_salario_promedio;
END$$
DELIMITER ;

-- =========================
-- Verificación de funcionamiento:

-- SELECT fn_stock_total_producto_por_nombre('Leche Entera') AS stock_total;
-- SELECT fn_salario_promedio_sector('Lacteos') AS salario_promedio;
-- =========================

