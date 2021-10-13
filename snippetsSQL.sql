USE Ejercicios;

-- Creación y modificación de tablas

CREATE TABLE clientes (
	id INT PRIMARY KEY IDENTITY(1,1),
	nombre_cliente VARCHAR(15),
	apellido_cliente VARCHAR(15),
	telefono varchar(12)
);

CREATE TABLE pedidos (
	id INT PRIMARY KEY IDENTITY(1,1),
	producto VARCHAR(20),
	total_pedido DECIMAL(8,2),
	fecha_pedido DATETIME,
	clienteid INT NOT NULL,
FOREIGN KEY(clienteid) REFERENCES clientes (id)
);

INSERT INTO clientes (nombre_cliente, apellido_cliente, telefono)
VALUES ('Paola', 'Pérez', '5544839922');

INSERT INTO clientes (nombre_cliente, apellido_cliente, telefono)
VALUES ('Fernando', 'González', '5564864922');

INSERT INTO clientes (nombre_cliente, apellido_cliente, telefono)
VALUES ('Karla', 'Paez', '5504837822');

INSERT INTO clientes (nombre_cliente, apellido_cliente, telefono)
VALUES ('Juan', 'Torres', '5576839922');

INSERT INTO clientes (nombre_cliente, apellido_cliente, telefono)
VALUES ('Mariana', 'Flores', '5532830822');


INSERT INTO pedidos (producto, total_pedido, fecha_pedido, clienteid)
VALUES ('Celular', 10000.00, CURRENT_TIMESTAMP, 1);

INSERT INTO pedidos (producto, total_pedido, fecha_pedido, clienteid)
VALUES ('Funda Celular', 100.00, CURRENT_TIMESTAMP, 1);

INSERT INTO pedidos (producto, total_pedido, fecha_pedido, clienteid)
VALUES ('Computadora', 20000.00, CURRENT_TIMESTAMP, 2);

INSERT INTO pedidos (producto, total_pedido, fecha_pedido, clienteid)
VALUES ('Libreta', 50.00, CURRENT_TIMESTAMP, 2);

INSERT INTO pedidos (producto, total_pedido, fecha_pedido, clienteid)
VALUES ('lápices', 30, CURRENT_TIMESTAMP, 2);

-- Añadir un nuevo campo a una tabla
ALTER TABLE clientes ADD [cliente_direccion] VARCHAR(50);

ALTER TABLE pedidos ALTER COLUMN total_pedido DECIMAL(7,2);

SELECT * FROM pedidos;

DELETE FROM pedidos WHERE id IN (8,14,11);

-- Consultas referenciales
SELECT a.* , b.producto 
FROM clientes a, pedidos b
WHERE a.nombre_cliente LIKE 'fer%' AND a.id = b.clienteid;

-- Consultas con conjuntos
SELECT a.* , b.producto 
FROM clientes a
INNER JOIN pedidos b
ON a.id = b.clienteid
WHERE a.nombre_cliente LIKE 'fer%';

-- Update con INNER JOIN 
UPDATE wm_clientes 
SET wm.telefono = campana.telefono,
wm.telefono = campana.telefono,
wm.telefono = campana.telefono
FROM wm_clientes wm
INNER JOIN nueva_campana campana ON wm.curp=campana.curp;

-- SELECCIONAR REGISTROS ENTRE 2 FECHAS
SELECT * 
FROM clientes
WHERE fecha_alta_cliente between CONVERT(DATETIME,'2021-04-19 00:00:00.000', 121) AND CONVERT(DATETIME,'2021-04-25 23:59:59.000', 121);

-- SELECCIONAR REGISTROS VALIDANDO QUE NO HAYA CAMPOS VACIOS O NULOS
SELECT * FROM clientes
WHERE cliente_telefono != '' OR cliente_telefono IS NOT NULL;

-- HACER UN SELECT ANTES DE UNA ACTUALIZACIÓN PARA VALIDAR CUANTOS REGISTROS VAMOS A AFECTAR
SELECT * 

--UPDATE clientes SET cliente_telefono = '551020304050'
FROM clientes
WHERE cliente_rfc IN ('ANUE801415VRL');

-- CONSULTA CON MULTIPLES CONDICIONES (RFC UNICO, SUMA, CAST/CONVERSIÓN DE TIPO DE DATO)
SELECT nombre, apellido,direccion, COUNT(DISTINCT rfc) AS total_clientes, SUM(CAST(numero_compras AS INT)) AS tot_compras, SUM(CAST([monto_credito] AS FLOAT)) AS monto_total_credito 
FROM clientes
WHERE numero_compras >= 5 and numero_devoluciones <= 2
GROUP BY apellido,nombre,rfc
ORDER BY apellido,rfc DESC;

--CREAR UNA FUNCIÓN
CREATE FUNCTION dbo.convetirCFF(@celsius real)
RETURNS real
AS
BEGIN
	DECLARE @resultado real
	SET @resultado = @celsius*1.8+32
	RETURN @resultado
END

--CREAR UN PROCEDMIENTO ALMACENADO
CREATE PROCEDURE convertirCF
@celsius real
AS
SELECT @celsius*1.8+32 as Fahrenheit

--Ejecutar el proceso
exec convertirCF 0
