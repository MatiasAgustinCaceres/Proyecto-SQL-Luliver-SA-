-- =========================
-- Creación de Vistas.
-- =========================

-- Vista de stock de producto por sucursal
CREATE VIEW vista_stock_de_producto_por_sucursal AS
SELECT 
    s.id_sucursal,
    s.direccion AS sucursal,
    p.nombre AS producto,
    c.nombre AS categoria,
    i.stock_actual
FROM Inventario i
JOIN Sucursal s ON i.id_sucursal = s.id_sucursal
JOIN Productos p ON i.id_producto = p.id_producto
JOIN Categorias c ON p.id_categoria = c.id_categoria;

-- Vista de empleados por sucursal.
CREATE VIEW vista_empleados_por_sucursal AS
SELECT
    s.direccion AS sucursal,
    se.nombre AS sector,
    e.nombre,
    e.apellido,
    e.puesto,
    e.salario
FROM Empleados e
JOIN Sucursal s ON e.id_sucursal = s.id_sucursal
JOIN Sectores se ON e.id_sector = se.id_sector;

-- Vista de stock por categoria.
CREATE VIEW vista_stock_por_categoria AS
SELECT
    c.nombre AS categoria,
    SUM(i.stock_actual) AS stock_total
FROM Inventario i
JOIN Productos p ON i.id_producto = p.id_producto
JOIN Categorias c ON p.id_categoria = c.id_categoria
GROUP BY c.nombre;

-- Vista de provedores por sucursal.
CREATE VIEW vista_proveedores_por_sucursal AS
SELECT DISTINCT
    s.direccion AS sucursal,
    pr.razon_social AS proveedor
FROM Inventario i
JOIN Sucursal s ON i.id_sucursal = s.id_sucursal
JOIN Productos p ON i.id_producto = p.id_producto
JOIN Proveedores pr ON p.id_provedor = pr.id_provedor;

-- Vista de gasto en salarios por sucursal. Mensual y proyección anual.
CREATE VIEW vista_gasto_salarios_por_sucursal AS
SELECT
    s.direccion AS sucursal,
    SUM(e.salario) AS gasto_mensual,
    SUM(e.salario) * 12 AS gasto_anual
FROM Sucursal s
JOIN Empleados e ON s.id_sucursal = e.id_sucursal
GROUP BY s.direccion;

-- =========================
-- Verificación de funcionamiento:

-- SELECT * FROM luliversa.vista_stock_de_producto_por_sucursal;
-- SELECT * FROM luliversa.vista_empleados_por_sucursal;
-- SELECT * FROM luliversa.vista_stock_por_categoria;
-- SELECT * FROM luliversa.vista_proveedores_por_sucursal;
-- SELECT * FROM luliversa.vista_gasto_salarios_por_sucursal;
-- =========================