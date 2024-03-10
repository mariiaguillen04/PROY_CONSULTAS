USE shein;

-- SUCURSAL
-- 1º Muestra la dirección de aquellas sucursales de las cuales, su teléfono de contacto termine en'6'.
SELECT direccion 
FROM sucursal
WHERE contacto LIKE '%6';

-- 2º Muestra la información de la sucursal situada en Francia.
SELECT * 
FROM sucursal
WHERE pais = 'Francia';

-- 3º Muestra el teléfono de contacto y la dirección de aquellas sucursales que se situan en un país que contenga la letra 'n'.
SELECT contacto, direccion 
FROM sucursal
WHERE pais LIKE '%n%';


-- CLIENTE
-- 1º Muestra la información de aquellos clientes que contengan la 'a' en la segunda posición de su nombre.
SELECT * 
FROM cliente 
WHERE SUBSTRING(nombre, 2, 1) = 'a';

-- 2º Muestra una columna denominada 'nombre_completo' que contenga el nombre y los apeliidos de el cliente, además, de mostrar su usuario.
SELECT usuario, CONCAT(nombre, ' ', apellidos) AS nombre_completo
FROM cliente;

-- 3º Muestra la información de aquellos clientes residentes de Francia.
SELECT *
FROM cliente
WHERE n_tarjeta LIKE 'FR%';


-- POSESION
-- 1º Muestra un mensaje que informe al cliente su usuario y la sucursal a la que pertenece, asigando un nombre a esta columna.
SELECT CONCAT('Usted ', usuario, ' recibirá los pedidos desde la sucursal ', id_sucursal)
	AS mensaje_informativo
FROM posesion;

-- 2º Muestra los identificadores de las sucursales a las que pertenecen los usuarios ordenados de mayor a menor.
SELECT *
FROM posesion
ORDER BY id_sucursal DESC;

-- 3º Muestra el usuario que pertenezca a la sucural 2.
SELECT *
FROM posesion
WHERE id_sucursal = 2 AND 5;


-- PUNTO
-- 1º Muestra los puntos usados y disponibles, mayores que 510 ,por los usuarios
SELECT usuario, disponible, usado
FROM punto
WHERE usado > 510 AND disponible> 510;

-- 2º Muestra los datos de los registros del usuario 'conde_p04'
SELECT * 
FROM punto
WHERE usuario = 'conde_p04';

-- 3º Muestra los datos de aquellos puntos que expiren en abril.
SELECT *
FROM punto
WHERE MONTH(fecha_expira) = 4;


-- PEDIDO
-- 1º Muestra los comentarios de los pedidos pagados.
SELECT n_seguim, comentarios
FROM pedido 
WHERE pagado = 1;

SELECT * FROM pedido;

-- 2º Muestra los usuarios, que hayan realizado un pedido los cuales contengan la letra 'D' en el número de seguimiento.
SELECT usuario
FROM pedido
WHERE n_seguim LIKE '%D%';

-- 3º Muestra los pedidos y correspondientes usuarios que no hayan pagado.
SELECT n_seguim, usuario
FROM pedido
WHERE pagado = 0;

-- ARTICULO
-- 1º Muestra la categoria y el nombre de los articulos 3 y 4.
SELECT nombre, categoria
FROM articulo 
WHERE id_articulo = 3 OR id_articulo = 4;
SELECT * FROM articulo;

-- 2º Muestra la informacion de los pedidos cuya referencia comience  por 4.
SELECT * 
FROM articulo
WHERE referencia LIKE '4%';

-- 3º Muestra el nombre de los articulos que contienen el numero 7 en la cuarta posición.
SELECT nombre 
FROM articulo
WHERE SUBSTRING(referencia, 4, 1) = 7;


-- PEDIDO_ARTICULO
-- 1º Muestra los artículos que contengan la letra 'A' en el n_seguim.
SELECT *
FROM pedido_articulo
WHERE n_seguim LIKE '%A%';

-- 2º Muestra los pedidos que posean el articulo 1 y 5, no ambos a la vez.
SELECT *
FROM pedido_articulo
WHERE id_articulo = 1 OR id_articulo = 5;

-- 3º Muestra los pedidos cuya n_seguim contenga la letra 'Q'
SELECT *
FROM pedido_articulo
WHERE n_seguim LIKE '%Q%';


-- CONSULTAS COMPLEJAS
-- 1º Obtener la información de los clientes que poseen artículos de la categoria belleza y salud.
SELECT cli.*
FROM pedido p
	JOIN  cliente cli ON cli.usuario = p.usuario
    JOIN pedido_articulo pa ON p.n_seguim = pa.n_seguim
    JOIN articulo ar ON pa.id_articulo = ar.id_articulo
    WHERE categoria = 'Belleza y salud';
    
-- 2º Calcula el total de puntos disponibles de los usuarios registrados
SELECT COUNT(disponible) AS total_puntos_plataforma
FROM punto;

-- 3º Encuentra los artículos que han sido pedidos pero aún no han sido pagados.
SELECT pa.id_articulo, ar.nombre
FROM pedido_articulo pa
	JOIN pedido p ON pa.n_seguim = p.n_seguim
    JOIN articulo ar ON pa.id_articulo = ar.id_articulo
    WHERE pagado = 0;

-- 4º Encuentra los pedidos que contienen artículos de una categoría específica.
SELECT pa.n_seguim, ar.nombre, ar.categoria
FROM pedido_articulo pa
	JOIN pedido p ON pa.n_seguim = p.n_seguim
    JOIN articulo ar ON pa.id_articulo = ar.id_articulo
    WHERE categoria = 'Ninios';

-- 5º Encuentra al usuario, la dirección y el país para el envio del pedido 'A2B7C4D9E1F'.
SELECT cli.direccion, p.usuario
FROM pedido p 
	JOIN  cliente cli ON p.usuario = cli.usuario
WHERE n_seguim = 'A2B7C4D9E1F';

-- 6º Muestra la referencia y el nombre de los articulos que han sido pagados.
SELECT ar.referencia, ar.nombre
FROM pedido_articulo pa
	JOIN articulo ar ON pa.id_articulo = ar.id_articulo
    JOIN pedido p ON pa.n_seguim = p.n_seguim
    WHERE pagado = 1;

-- 7º Muestra el contacto con el que se debe de comunicar el usuario 'angy_charte3'
SELECT s.contacto, po.usuario
FROM posesion po
	JOIN sucursal s ON po.id_sucursal = s.id_sucursal
	JOIN cliente cli ON po.usuario = cli.usuario
    WHERE cli.usuario = 'angy_charte3'; 

	