-- Tablas --------------------------------------------------------------------------------------------------------------------------

create table biblored.genero (
    genero_id int default nextval('biblored.seq_generos_pk'),
    nombre varchar (50) not null,
    descripcion varchar(500) 
);

create table biblored.pais (
    pais_id int default nextval('biblored.seq_paises_pk'),
    nombre varchar(50) not null
);

create table biblored.nacionalidad (
    nacionalidad_id int default nextval('biblored.seq_nacionalidades_pk'),
    autor_id int not null,
    pais_id int
);


create table biblored.libro (
	codigo_isbn varchar(20),
    titulo varchar(100) not null,
    editorial int not null,
    ano_publicacion int not null,
    edicion varchar(50),
    genero_id int not null
    
);

create table biblored.editorial (
	editorial_id int default nextval('biblored.seq_editoriales_pk'),
	nombre_editorial varchar(50) not null

);

create table biblored.ejemplar (
	ejemplar_id int default nextval('biblored.seq_ejemplares_pk'),
	estado_fisico varchar(80),
	inventario_id varchar(15) not null,
	prestamo_id int,
	codigo_isbn varchar(20) not null

);

create table biblored.prestamo (
    prestamo_id int default nextval('biblored.seq_prestamos_pk'),
    fecha_devolucion date not null,
    fecha_prestamo date not null,
    doc_afiliado varchar(10) not null,
    estado varchar(2) not null -- AT (A tiempo) RT (Retardado)

);

create table biblored.autor_libro (
    autor_libro_id int default nextval('biblored.seq_autor_libro_pk'),
    autor_id int not null,
    codigo_isbn varchar(20) not null

);

create table biblored.autor (
    autor_id int default nextval('biblored.seq_autores_pk'),
    p_nombre varchar(50) not null,
    s_nombre varchar(50),
    p_apellido varchar(50) not null,
    s_apellido varchar (50),
    fec_nacimiento date not null,
    sexo_bio varchar (1)
);

create table biblored.inventario (
    inventario_id varchar(15),
    sede_id int not null
);

create table biblored.afiliado (
    documento_af varchar(10),
    p_nombre varchar(50) not null,
    s_nombre varchar(50),
    p_apellido varchar(50) not null,
    s_apellido varchar (50),
    estado_afiliacion varchar(1) not null, -- (A)activo, (I)inactivo
    f_inicio_afiliacion date not null,
    f_fin_afiliacion date,
    tipo_documento varchar(20) not null,
    fec_nacimiento date not null,
    telefono varchar(20) not null,
    email varchar(80) not null,
    documento_ac varchar(10)
);

create table biblored.acudiente (
    documento_ac varchar(10),
    p_nombre varchar(50) not null,
    s_nombre varchar(50),
    p_apellido varchar(50) not null,
    s_apellido varchar (50),
    fec_nacimiento date not null,
    telefono varchar(20) not null,
    email varchar(80) not null
);

create table biblored.sede (
    sede_id int default nextval('biblored.seq_sedes_pk'),
    nombre varchar (100) not null,
    telefono varchar (50) not null,
    direccion varchar (60) not null,
    email varchar(80) not null,
    tipo_biblioteca varchar (30) not null,
    localidad_id int not null
);

create table biblored.localidad (
    localidad_id int default nextval('biblored.seq_localidades_pk'),
    nombre varchar(50) not null
);

create table biblored.trabajador (
    trabajador_id int default nextval('biblored.seq_trabajadores_pk'),
    p_nombre varchar(50) not null,
    s_nombre varchar(50),
    p_apellido varchar(50) not null,
    s_apellido varchar (50),
    telefono varchar(20) not null,
    email varchar(80) not null,
    email_trabajo varchar (80) not null,
    fec_nacimiento date not null,
    cedula varchar(10) not null,
    sede_id int not null
);

create table biblored.contrato (
    contrato_id int default nextval('biblored.seq_contratos_pk'),
    fecha_inicio_con date not null,
    fecha_fin_con date,
    salario int not null,
    tipo_vinculacion varchar(50) not null,
    trabajador_id int not null,
    tipo_contrato int not null
);

create table biblored.tipo_contrato (
    tipo_contrato_id int default nextval('biblored.seq_tipo_contrato_pk'),
    nombre_contrato varchar (40) not null
);



--- Tablas para auditorías ---

-- Tabla de prestamos-completados para tener registro de préstamos ya devueltos --
-- Se utilizará un procedimiento almacenado para guardar el respaldo de los préstamos ya realizados antes de ser eliminados --

create table biblored.historico_prestamo (
	hist_id int default nextval('biblored.historicos'),
	prestamo_id int not null,
	ejemplar_id int not null,
	fecha_prestamo date not null,
	fecha_devolucion date not null,
	doc_afiliado varchar(10) not null
);
