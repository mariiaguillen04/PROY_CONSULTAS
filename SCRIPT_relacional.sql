SUCURSAL(id_sucursal, direccion, contacto,pais)
	PK(id_sucursal)

CLIENTE(usuario, nombre, apellidos, direccion, n_tarjeta)
	PK(usuario)

POSESION(id_sucursal, usuario)
	PK(id_sucursal, usuario)
	Fk1(id_sucursal -> SUCURSAL)
	Fk2(usuario -> CLIENTE)

PUNTO(id_puntos, usuario, disponible, usado, fecha_expira)
	PK(id_puntos)
	Fk(usuario -> CLIENTE)

PEDIDO(n_seguim, usuario, pagado, comentarios)
	PK(n_seguim)
	Fk(usuario -> CLIENTE)

ARTICULO(id_articulo, categoria, nombre, referencia)
	PK(id_articulo)

PEDIDO-ARTICULO(n_seguim, id_articulo)
	PK(n_seguim, id_articulo)
	Fk1(n_seguim -> PEDIDO)
	Fk2(id_articulo -> ARTICULO)