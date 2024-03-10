DROP DATABASE IF EXISTS shein;
CREATE DATABASE shein;

USE shein;

CREATE TABLE sucursal(
	id_sucursal INT PRIMARY KEY AUTO_INCREMENT,
	direccion VARCHAR(50),
	contacto CHAR(9) NOT NULL,
	pais VARCHAR(50)
);
DESCRIBE sucursal; 

CREATE TABLE cliente(
	usuario VARCHAR(50) PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellidos VARCHAR(50) NOT NULL,
	direccion VARCHAR(50),
	n_tarjeta CHAR(29)
);
DESCRIBE cliente;

CREATE TABLE posesion(
	id_sucursal INT,
	usuario VARCHAR(50),
	CONSTRAINT pk_posesion PRIMARY KEY (id_sucursal,usuario),
	CONSTRAINT fk_posesion_sucursal FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal),
	CONSTRAINT fk_posesion_cliente FOREIGN KEY (usuario) REFERENCES cliente(usuario)
);
DESCRIBE posesion;

CREATE TABLE punto(
	id_puntos INT PRIMARY KEY AUTO_INCREMENT,
	disponible INT,
	usado INT,
	fecha_expira DATE,
	usuario VARCHAR(50),
	CONSTRAINT fk_punto_cliente FOREIGN KEY (usuario) REFERENCES cliente(usuario)
);
DESCRIBE punto;

CREATE TABLE pedido(
	n_seguim CHAR(11) PRIMARY KEY,
	pagado BOOLEAN,
	comentarios VARCHAR(250),
	usuario VARCHAR(50),
	CONSTRAINT fk_pedido_cliente FOREIGN KEY (usuario) REFERENCES cliente(usuario)
); 
DESCRIBE pedido;

CREATE TABLE articulo(
	id_articulo INT PRIMARY KEY AUTO_INCREMENT,
	categoria VARCHAR(50),
	nombre VARCHAR(50) NOT NULL, 
	referencia CHAR(9) UNIQUE NOT NULL 
);
DESCRIBE articulo;

CREATE TABLE pedido_articulo(
	n_seguim CHAR(11),
	id_articulo INT,
	CONSTRAINT pk_pa PRIMARY KEY (n_seguim,id_articulo),
	CONSTRAINT fk_pa_pedido FOREIGN KEY (n_seguim) REFERENCES pedido(n_seguim),
	CONSTRAINT fk_pa_articulo FOREIGN KEY (id_articulo) REFERENCES articulo(id_articulo)
);
DESCRIBE pedido_articulo;

INSERT INTO sucursal(direccion, contacto, pais ) VALUES
	('C/ Esmeralda N 123','685621370', 'Alemania'),
	('C/ Camino del Destino N 89','607834156', 'Espania' ),
	('C/ de las Mariposas N 34','649267583', 'Portugal'),
	('C/ Soniador N 87','632598741', 'Francia'),
	('C/ Misteriosa N 14','658420936', 'Italia'),
	('C/ Ilusionica N 20','613689247', 'Suiza');
SELECT * FROM sucursal;

INSERT INTO cliente(usuario, nombre, apellidos, direccion, n_tarjeta) VALUES
	('mariiaguillen04', 'Maria', 'Guillen Mateos', 'C/ Ramon y Cajal', 'ES75 4320 1865 9327 8104 6215'),
	('mariiorme03', 'Mario', 'Moreno Escribano', 'C/ Menta', 'AL12 3456 7890 9876 5432 1789'),
	('susaana_m04', 'Susana', 'Martin Orozco', 'C/ Canela', 'SZ98 7654 3210 1234 5678 9456'),
	('lean_04', 'Leandro', 'Vidal Nunez', 'C/ Freseo', 'RM56 7890 1234 0987 6543 2101'),
	('fran_rf_04', 'Fran', 'Ruiz Florido', 'C/ Moscada', 'IT24 6813 5791 3579 2468 0247'),
	('conde_p04', 'Pablo', 'Conde Mellado', 'C/ Real', 'FR31 8811 8606 8822 8851 2887'),
	('humanes_04', 'Pablo', 'Humanes Gandul', 'C/ Soria', 'FR12 0651 8606 7429 8031 2355'),
	('angy_charte3', 'Angela', 'Charte Torres', 'C/ Morillo', 'ES99 2626 4547 0055 1366 8994');
SELECT * FROM cliente;

INSERT INTO posesion (usuario, id_sucursal) VALUES
	('mariiorme03', 1 ),
	('angy_charte3', 5),
	('humanes_04', 3 ),
	('conde_p04', 6),
	('mariiaguillen04', 2 ),
	('lean_04', 4);
SELECT * FROM posesion;

INSERT INTO punto (disponible, usado, fecha_expira, usuario) VALUES
	(221, 0,'2024-05-14', 'mariiaguillen04' ),
	(3304, 504, '2024-08-01','angy_charte3' ),
	(1002, 708, '2024-04-24', 'humanes_04'),
	(6691, 332, '2024-04-02', 'mariiorme03'),
	(200, 0, '2024-03-30', 'conde_p04'),
	(5002, 4577, '2024-03-11', 'lean_04');
SELECT * FROM punto;

INSERT INTO pedido(n_seguim, pagado, comentarios, usuario) VALUES
	('A2B7C4D9E1F', true, 'Este disenio es tan chic y elegante. Definitivamente una pieza imprescindible para cualquier guardarropa de moda', 'mariiorme03'),
	('8L3M6N2O0P3', false, null, 'conde_p04' ),
	('Q5R1S9T7U2V', false, null, 'mariiaguillen04'),
	('X3Y6Z0A8B4R', true, 'La atencion a los detalles en este disenio es increible. Cada costura y adorno se nota, y eso hace que la prenda sea realmente especial.', 'humanes_04'),
	('M1N8O3P5Q6D', false, null, 'lean_04' ),
	('8O3P5QQ5B7C', true, 'Este articulo es tan versatil. Puedo imaginarme usandolo tanto para eventos formales como para un dia casual en la ciudad.', 'angy_charte3' );
SELECT * FROM pedido;


INSERT INTO articulo (categoria, nombre, referencia) VALUES
	('Ropa de mujer', 'Vestido de tirantres azul', '457844568GH'),
	('Ropa playera', 'Baniador Bikini tri angulo', '784597866WE'),
	('Hogar y cocina', 'Rociador de aromaterapia',  '698854012JK'),
	('Belleza y salud', 'Rubor color bloom', '213325784SD'),
	('Ninios', 'Kids top blanco sin tirantes', '024589774DX'),
	('Zapatos', 'Mujer sandalias con patron de esparto', '322659845YH');
SELECT * FROM articulo;

INSERT INTO pedido_articulo(n_seguim, id_articulo) VALUES
	('A2B7C4D9E1F', 2),
	('8L3M6N2O0P3', 3),
	('Q5R1S9T7U2V', 6),
	('X3Y6Z0A8B4R', 4),
	('M1N8O3P5Q6D', 1),
	('8O3P5QQ5B7C', 5);
SELECT * FROM pedido_articulo;