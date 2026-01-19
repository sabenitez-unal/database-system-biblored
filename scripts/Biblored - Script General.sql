-- Se crea el esquema de la base de datos 'Biblored' --

create schema biblored;


---Secuencias---

--contador para tabla 'genero'--
create sequence biblored.seq_generos_pk
    start with 1
    increment by 1
    minvalue 1
    no maxvalue 
    no cycle
    cache 1;

--contador para tabla 'pais'--
create sequence biblored.seq_paises_pk
    start with 1
    increment by 1
    minvalue 1 
    no maxvalue 
    no cycle
    cache 1;

--contador para tabla 'nacionalidad'--
create sequence biblored.seq_nacionalidades_pk
    start with 1
    increment by 1
    minvalue 1 
    no maxvalue 
    no cycle
    cache 1;

--contador para tabla 'ejemplar'--
create sequence biblored.seq_ejemplares_pk
    start with 1
    increment by 1
    minvalue 1 
    no maxvalue 
    no cycle
    cache 1;

--contador para tabla 'editorial'--
create sequence biblored.seq_editoriales_pk
    start with 1
    increment by 1
    minvalue 1 
    no maxvalue 
    no cycle
    cache 1;

--contador para tabla 'prestamo'--
create sequence biblored.seq_prestamos_pk
    start with 1
    increment by 1
    minvalue 1 
    no maxvalue 
    no cycle
    cache 1;


--contador para tabla 'autor-libro'--
create sequence biblored.seq_autor_libro_pk
    start with 1
    increment by 1
    minvalue 1 
    no maxvalue 
    no cycle
    cache 1;

--contador para tabla 'autor'--
create sequence biblored.seq_autores_pk
    start with 1
    increment by 1
    minvalue 1 
    no maxvalue 
    no cycle
    cache 1;

--contador para tabla 'sede'--
create sequence biblored.seq_sedes_pk
    start with 1
    increment by 1
    minvalue 1 
    no maxvalue 
    no cycle
    cache 1;

--contador para tabla 'localidad'--
create sequence biblored.seq_localidades_pk
    start with 1
    increment by 1
    minvalue 1 
    no maxvalue 
    no cycle
    cache 1;

--contador para tabla 'trabajador'--
create sequence biblored.seq_trabajadores_pk
    start with 1
    increment by 1
    minvalue 1 
    no maxvalue 
    no cycle
    cache 1;

--contador para tabla 'contrato'--
create sequence biblored.seq_contratos_pk
    start with 1
    increment by 1
    minvalue 1 
    no maxvalue 
    no cycle
    cache 1;

--contador para tabla 'tipo-contrato'--
create sequence biblored.seq_tipo_contrato_pk
    start with 1
    increment by 1
    minvalue 1 
    no maxvalue 
    no cycle
    cache 1;

--contador para tabla de auditoría 'histórico_prestamo'--
create sequence biblored.historicos
    start with 1
    increment by 1
    minvalue 1 
    no maxvalue 
    no cycle
    cache 1;

-----------------------------------------------------------------------------------------------------------------
-- Creacion de roles y permisos

-- Administradores con rol de permisos de superusuario --
create role administradores superuser;

-- Otros roles importantes ---
create role bibliotecarios;
create role afiliados;
create role trabajadores;
create role acudientes;

-- Se otorgan todos los privilegios sobre el esquema biblored a los administradores --

grant all privileges on schema biblored, public to administradores;

-- Se otorga permisos de uso sobre el esquema a los demás roles --
grant usage on schema biblored to bibliotecarios;
grant usage on schema biblored to afiliados;
grant usage on schema biblored to acudientes;
grant usage on schema biblored to trabajadores;

-- Permisos de uso sobre las secuencias a la hora de crear registros --
grant usage on all sequences in schema biblored to bibliotecarios;
grant usage on all sequences in schema biblored to afiliados;
grant usage on all sequences in schema biblored to acudientes;

-- Se otorgan permisos de consulta y manipulación de datos a las tablas requeridas por el biblotecario
grant select, insert, update, delete on 
inventario, libro, ejemplar, prestamo, historico_prestamo, autor_libro, editorial, autor, 
nacionalidad, genero, afiliado, acudiente to bibliotecarios;
grant select on pais to bibliotecarios;

-- Permisos de consulta y manipulación de datos de las tablas requeridas por el afiliado y los acudientes --
grant select, insert, update, delete on afiliado, acudiente to afiliados;
grant select on libro, genero, inventario, prestamo, editorial, ejemplar, historico_prestamo, autor, autor_libro to afiliados;

grant select, insert, update, delete on afiliado, acudiente to acudientes;

-- Permisos de consulta o actualización de datos en tablas requeridas para los trabajadores --
grant select, update on trabajador to trabajadores;
grant select on contrato, tipo_contrato to trabajadores;
-------------------------------------------------------------------------------------------------------------
--Creacion de usuarios


--Creación de usuarios y asignación de roles ya definidos--
-- 'with inherit true' permite la acumulación de privilegios si un usuario cuenta con varios roles.

--Usuario de ejemplo para el bibliotecario--
create user samuel_bibliotecario with encrypted password 'samuel_bib';
grant bibliotecarios to samuel_bibliotecario with inherit true;
grant trabajadores to samuel_bibliotecario with inherit true;

--Usuario de ejemplo para el afiliado--
create user santiago_afiliado with encrypted password 'santiago123';
grant afiliados to santiago_afiliado with inherit true;

--Usuario de ejemplo para el acudiente de un afiliado que también es un afiliado--
create user gabriel_acudiente with encrypted password 'gabriel123';
grant acudientes to gabriel_acudiente with inherit true;

--Usuario de ejemplo para el trabajador--
create user carlos_trabajador with encrypted password 'carlitos55';
grant trabajadores to carlos_trabajador with inherit true;

--Usuario de ejemplo para el administrador de la DB--
create user daniel_admin with encrypted password 'admin555';
grant administradores to daniel_admin with inherit true;


--Creación del único usuario existente para el director de la sede--
create user director_sede with encrypted password 'director';

--Asignación de permisos al usuario de director--
grant select, insert, update, delete on trabajador, contrato, 
tipo_contrato to director_sede;

grant select on sede, localidad, ejemplar, inventario, libro, genero, 
prestamo, autor_libro, autor, nacionalidad, pais, afiliado, 
acudiente to director_sede;
grant usage on all sequences in schema biblored to director_sede;


----------------------------------------------------------------------------
--Creacion de tablas

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
------------------------------------------------------------------------------------------------
-- Constraints
--Creacion de constraints---------------------------------------------------------------------------------------------------

--Primary Keys--------------------
alter table biblored.genero 
add constraint pk_genero_id
    primary key(genero_id);

alter table biblored.pais 
add constraint pk_pais_id
    primary key(pais_id);

alter table biblored.nacionalidad
add constraint pk_nacionalidad_id
    primary key(nacionalidad_id);

alter table biblored.libro 
add constraint pk_codigo_isbn
    primary key(codigo_isbn);

alter table biblored.editorial
add constraint pk_editorial_id
	primary key(editorial_id);

alter table biblored.ejemplar 
add constraint pk_ejemplar_id
    primary key(ejemplar_id);

alter table biblored.prestamo 
add constraint pk_prestamo_id
    primary key(prestamo_id);

alter table biblored.autor_libro 
add constraint pk_autor_libro_id
    primary key(autor_libro_id);

alter table biblored.autor
add constraint pk_autor_id
    primary key(autor_id);

alter table biblored.inventario
add constraint pk_inventario_id
    primary key(inventario_id);

alter table biblored.afiliado 
add constraint pk_documento_af
    primary key(documento_af);

alter table biblored.acudiente 
add constraint pk_documento_ac
    primary key(documento_ac);

alter table biblored.sede 
add constraint pk_sede_id
    primary key(sede_id);

alter table biblored.localidad 
add constraint pk_localidad_id
    primary key(localidad_id);

alter table biblored.trabajador
add constraint pk_trabajador_id
    primary key(trabajador_id);

alter table biblored.contrato 
add constraint pk_contrato_id
    primary key(contrato_id);

alter table biblored.tipo_contrato 
add constraint pk_tipo_contrato_id
    primary key(tipo_contrato_id);

alter table biblored.historico_prestamo 
add constraint pk_historico_prestamo_id
	primary key(hist_id);

--Foreign Keys ---------------------------

alter table biblored.nacionalidad 
add constraint fk_autor_id_nac
    foreign key (autor_id)
    references biblored.autor(autor_id);
    
alter table biblored.nacionalidad 
add constraint fk_pais_id_nac
    foreign key (pais_id)
    references biblored.pais(pais_id); 

alter table biblored.libro
add constraint fk_genero_id_lib
    foreign key (genero_id)
    references biblored.genero(genero_id);

alter table biblored.libro
add constraint fk_editorial_id_lib
	foreign key (editorial)
	references biblored.editorial(editorial_id);

alter table biblored.ejemplar
add constraint fk_codigo_isbn_ejem
    foreign key (codigo_isbn)
    references biblored.libro(codigo_isbn);
    
alter table biblored.ejemplar
add constraint fk_prestamo_id_ejem
	foreign key (prestamo_id)
	references biblored.prestamo(prestamo_id)
	on delete set null;

alter table biblored.ejemplar
add constraint fk_inventario_id_ejem
	foreign key (inventario_id)
	references biblored.inventario(inventario_id);
	
alter table biblored.prestamo 
add constraint fk_doc_afiliado_pres
    foreign key (doc_afiliado)
    references biblored.afiliado(documento_af);

alter table biblored.autor_libro 
add constraint fk_autor_id_autLib
    foreign key(autor_id)
    references biblored.autor(autor_id);

alter table biblored.autor_libro
add constraint fk_codigo_isbn_autLib
    foreign key(codigo_isbn)
    references biblored.libro(codigo_isbn)
	on delete cascade;

alter table biblored.inventario
add constraint fk_sede_id_inv
    foreign key(sede_id)
    references biblored.sede(sede_id);

alter table biblored.afiliado
add constraint fk_documento_ac_af
    foreign key (documento_ac)
    references biblored.acudiente(documento_ac); 

alter table biblored.sede
add constraint fk_localidad_id_sed
    foreign key (localidad_id)
    references biblored.localidad(localidad_id);

alter table biblored.trabajador
add constraint fk_sede_id_trab
    foreign key(sede_id)
    references biblored.sede(sede_id);

alter table biblored.contrato
add constraint fk_trabajador_id_cont
    foreign key(trabajador_id)
    references biblored.trabajador(trabajador_id)
    on delete cascade;

alter table biblored.contrato
add constraint fk_tipo_contrato_id_cont
    foreign key(tipo_contrato)
    references biblored.tipo_contrato(tipo_contrato_id);


--Unique keys--------------------------------

alter table biblored.pais 
add constraint uk_nombre_pais
    unique(nombre);

alter table biblored.sede 
add constraint uk_nombre_sede
    unique(nombre);

alter table biblored.localidad
add constraint uk_nombre_localidad
    unique(nombre);

alter table biblored.editorial
add constraint uk_nombre_editorial
	unique(nombre_editorial);

alter table biblored.trabajador 
add constraint uk_cedula_trabajador
    unique(cedula),
add constraint uk_email_trabajo_trabajador
    unique(email_trabajo);

alter table biblored.tipo_contrato
add constraint uk_nombre_contrato
    unique(nombre_contrato);

------------------------------------------------------------------------------------------
--Llenado de tablas

--Llenado de tablas------------------------------------------------------------------
insert into biblored.genero (nombre, descripcion)
values
    ('Ciencia Ficción', 'Género que especula sobre futuros posibles o universos alternativos, a menudo basados en avances científicos y tecnológicos, o en cambios sociales.'),
    ('Fantasía', 'Género que incluye elementos sobrenaturales o mágicos que no existen en la realidad, como criaturas míticas o mundos imaginarios.'),
    ('Novela Histórica', 'Narraciones ambientadas en épocas pasadas, con una base real y elementos de ficción que complementan la historia.'),
    ('Romance', 'Historias centradas en relaciones amorosas y afectivas, con énfasis en el desarrollo emocional de los personajes.'),
    ('Misterio', 'Obras que giran en torno a la resolución de un enigma, normalmente un crimen o desaparición, que se desvela al final.'),
    ('Terror', 'Género que busca provocar miedo, inquietud o suspenso en el lector, mediante situaciones sobrenaturales o psicológicas.'),
    ('Biografía', 'Relato de la vida de una persona real, basada en hechos documentados y presentada de manera narrativa.'),
    ('Autobiografía', 'Historia de vida escrita por la propia persona, que narra sus experiencias personales y profesionales.'),
    ('Aventura', 'Narraciones que involucran viajes, desafíos y riesgos, donde los personajes enfrentan situaciones emocionantes y peligrosas.'),
    ('Literatura Infantil', 'Género destinado a niños, con historias simples, educativas o fantasiosas, adaptadas a su nivel de comprensión.'),
    ('Literatura Juvenil', 'Obras dirigidas a adolescentes, que abordan temas de identidad, relaciones, conflictos y crecimiento personal.'),
    ('Drama', 'Género que presenta conflictos emocionales intensos, generalmente centrado en la vida cotidiana y las relaciones humanas.'),
    ('Poesía', 'Forma literaria que utiliza el lenguaje de manera estética y rítmica para expresar emociones, ideas o imágenes.'),
    ('Ensayo', 'Texto argumentativo en prosa que expone una idea o reflexión sobre un tema específico desde una perspectiva personal.');

insert into biblored.tipo_contrato(nombre_contrato)
values
    ('término indefinido'),
    ('término fijo'),
    ('prestación de servicios'),
    ('aprendizaje'),
    ('obra o labor'),
    ('medio tiempo');


insert into biblored.pais (nombre)
values
    ('Colombia'), --1
    ('España'),   --2
    ('Francia'),  --3
    ('Reino Unido'), --4
    ('Estados Unidos'), --5
    ('Argentina'),--6
    ('México'),   --7
    ('Italia'),   --8
    ('Alemania'), --9
    ('Rusia'),    --10
    ('Chile'),    --11
    ('Perú'),     --12
    ('Brasil'),   --13
    ('Japón'),    --14
    ('Canadá');   --15


insert into biblored.autor (p_nombre, s_nombre, p_apellido, s_apellido, fec_nacimiento, sexo_bio)
values
    ('gabriel', 'josé', 'garcía', 'márquez', '1927-03-06', 'M'),       -- colombia
    ('isabel', 'ángela', 'allende', 'llona', '1942-08-02', 'F'),       -- chile
    ('mario', 'jorge', 'vargas', 'llosa', '1936-03-28', 'M'),          -- perú, españa
    ('julio', 'florencio', 'cortázar', 'descotte', '1914-08-26', 'M'), -- argentina
    ('virginia', 'ada', 'woolf', 'stephen', '1882-01-25', 'F'),        -- reino unido
    ('leo', 'nikoláievich', 'tolstói', 'miloslavski', '1828-09-09', 'M'), -- rusia
    ('ernest', 'miller', 'hemingway', null, '1899-07-21', 'M'),        -- ee.uu.
    ('haruki', null, 'murakami', null, '1949-01-12', 'M'),             -- japón
    ('emily', null, 'brontë', null, '1818-07-30', 'F'),                -- reino unido
    ('mark', null, 'twain', null, '1835-11-30', 'M'),                  -- ee.uu.
    ('clarice', null, 'lispector', null, '1920-12-10', 'F'),           -- brasil, rusia
    ('jorge', 'francisco', 'borges', 'acevedo', '1899-08-24', 'M'),    -- argentina
    ('carlos', null, 'fuentes', null, '1928-11-11', 'M'),              -- méxico, ee.uu.
    ('margaret', null, 'atwood', null, '1939-11-18', 'F'),             -- canadá
    ('charles', 'john', 'dickens', null, '1812-02-07', 'M'),           -- reino unido
    ('antoine', null, 'de saint-exupéry', null, '1900-06-29', 'M');    -- francia        

insert into biblored.nacionalidad (autor_id, pais_id)
values
    (1, 1),    -- gabriel garcía márquez – colombia
    (2, 11),   -- isabel allende – chile
    (3, 12),   -- mario vargas llosa – perú
    (3, 2),    -- mario vargas llosa – españa
    (4, 6),    -- julio cortázar – argentina
    (5, 4),    -- virginia woolf – reino unido
    (6, 10),   -- leo tolstói – rusia
    (7, 5),    -- ernest hemingway – estados unidos
    (8, 14),   -- haruki murakami – japón
    (9, 4),    -- emily brontë – reino unido
    (10, 5),   -- mark twain – estados unidos
    (11, 13),  -- clarice lispector – brasil
    (11, 10),  -- clarice lispector – rusia (nació en el Imperio Ruso)
    (12, 6),   -- jorge luis borges – argentina
    (13, 7),   -- carlos fuentes – méxico
    (13, 5),   -- carlos fuentes – estados unidos
    (14, 15),  -- margaret atwood – canadá
    (15, 4),   -- charles dickens – reino unido
    (16, 3);   -- antoine de saint-exupéry – francia

insert into biblored.acudiente (documento_ac, p_nombre, s_nombre, p_apellido, s_apellido, fec_nacimiento, telefono, email)
values
    ('1001052167', 'carlos', 'andrés', 'ramírez', 'pineda', '1980-05-14', '+57 3104567890', 'carlos.ramirez@email.com'),
    ('1212345678','maría', null, 'gonzález', 'suárez', '1978-11-02', '+57 3156789021', 'maria.gonzalez@email.com'),
    ('79707322','luis', 'fernando', 'rodríguez', null, '1985-04-19', '+57 3123456789', 'luis.rodriguez@email.com'),
    ('51105334', 'ana', 'milena', 'quintero', 'restrepo', '1990-08-25', '+57 3169876543', 'ana.quintero@email.com'),
    ('1002003123','julián', null, 'pérez', 'cárdenas', '1983-02-11', '+57 3012345678', 'julian.perez@email.com'),
    ('1102123554', 'martha', 'lucía', 'arias', null, '1975-09-30', '+57 3176543210', 'martha.arias@email.com'),
    ('78254199','andrés', 'felipe', 'toro', 'zapata', '1987-06-07', '+57 3001122334', 'andres.toro@email.com'),
    ('1000231233','diana', null, 'salazar', 'gómez', '1981-12-03', '+57 3189988776', 'diana.salazar@email.com'),
    ('43909878', 'jorge', 'enrique', 'muñoz', null, '1979-10-15', '+57 3195566778', 'jorge.munoz@email.com'),
    ('1020234811', 'claudia', 'patricia', 'valencia', 'ospina', '1986-01-27', '+57 3143322110', 'claudia.valencia@email.com'),
    ('65118234', 'juan', null, 'moreno', 'castaño', '1982-07-20', '+57 3112233445', 'juan.moreno@email.com'),
    ('1023432123', 'paola', 'andrea', 'ruiz', null, '1991-03-09', '+57 3138899776', 'paola.ruiz@email.com'),
    ('1001042231', 'edwin', 'mauricio', 'sánchez', 'barrera', '1984-05-05', '+57 3201234567', 'edwin.sanchez@email.com'),
    ('1002987612', 'natalia', null, 'castro', 'león', '1989-09-17', '+57 3227766554', 'natalia.castro@email.com'),
    ('1011055289', 'hector', 'daniel', 'bermúdez', null, '1977-04-04', '+57 3236677889', 'hector.bermudez@email.com');


insert into biblored.localidad (nombre)
values
    ('antonio nariño'), --1
    ('barrios unidos'), --2
    ('bosa'),           --3
    ('candelaria'),     --4
    ('chapinero'),      --5
    ('ciudad bolívar'), --6
    ('engativá'),       --7
    ('fontibón'),       --8
    ('kennedy'),        --9
    ('los mártires'),   --10
    ('puente aranda'),  --11
    ('rafael uribe uribe'), --12
    ('san cristóbal'),  --13
    ('santa fe'),       --14
    ('suba'),           --15
    ('sumapaz'),        --16
    ('teusaquillo'),    --17
    ('tunjuelito'),     --18
    ('usaquén'),        --19   
    ('usme');           --20


insert into biblored.sede (nombre, telefono, direccion, email, tipo_biblioteca, localidad_id) -- que es tipo biblioteca
values 
    ('Biblioteca Cárcel Buen Pastor', '+57 3127639810', 'Carrera 58 # 80-95' ,'angie.buitrago@biblored.gov.co', 'Biblioteca Carcelaria', 2),
    ('Biblioteca Cárcel Modelo', '+57 3220987322', 'Carrera 57 #16-60', 'kateryn.duarte@biblored.gov.co', 'Biblioteca Carcelaria', 11),
    ('Biblioteca Pública Fontibón', '(601) 5803050 ext. 6250', 'Calle 18 N. 99 - 38', 'olga.zambrano@biblored.gov.co', 'Biblioteca Pública', 8),
    ('Biblioteca Pública CEFE Cometas', '(601) 5803060 ext. 6261', 'Diagonal 127A #81-26', 'anyela.arias@biblored.gov.co', 'Biblioteca Pública', 15),
    ('Biblioteca Pública CEFE Fontanar Del Río', '(601) 5803050 Ext. 6410', 'Avenida Calle 145 # 138A -10' , 'cristhian.torres@biblored.gov.co', 'Biblioteca Pública', 15),
    ('Biblioteca Pública FUGA', '(601) 4320410', 'Calle 10 #3-16', 'freddy.quitian@biblored.gov.co', 'Biblioteca Pública', 4),
    ('Biblioteca Pública El Mirador', '(601) 5803050 ext. 6401 / 6400', 'Calle 71h Bis Sur #27 - 79', 'nirza.morales@biblored.gov.co', 'Biblioteca Pública', 6),
    ('Biblioteca Pública de la Participación Ciudadana', '(601) 5803050 ext. 6230', 'Carrera 19A # 63C- 40', 'olga.zambrano@biblored.gov.co', 'Biblioteca Pública', 2),
    ('Biblioteca Cárcel Distrital', '+57 31089563210', 'Carrera 8 # 1C - 50 sur', 'mary.jamioy@biblored.gov.co', 'Biblioteca Carcelaria', 13),
    ('Biblioteca Pública El Parque', '(601) 5803050 ext. 6211', 'Carrera 5 #36-21', 'yuly.leon@biblored.gov.co', 'Biblioteca Pública', 14),
    ('Biblioteca Público-Escolar La Marichuela', '(601) 5803050 ext. 6200', 'Diagonal 76B Sur #1C-40', 'diana.cardona@biblored.gov.co', 'Biblioteca Público Escolar', 20),
    ('Biblioteca Pública Virgilio Barco', '(601) 5803010 ext. 3000', 'Avenida Carrera. 60 # 57 - 60', 'sergio.cardenas@biblored.gov.co', 'Biblioteca Pública', 17),
    ('Biblioteca Público Escolar Sumapaz', '3137459116', 'Centro Poblado vereda La Unión, Corregimiento de San Juan', 'edna.melo@biblored.gov.co', 'Biblioteca Público Escolar', 16),
    ('Biblioteca Pública Gabriel García Márquez - El Tunal', '(601) 5803070 ext. 2001', 'Calle 48B sur # 21-13', 'arnulfo.ariza@biblored.gov.co', 'Biblioteca Pública', 18),
    ('Biblioteca Pública Carlos E. Restrepo', '(601) 5803050 ext. 6020 y 6021', 'Transversal 21A #19-54 sur', 'carlos.vera@biblored.gov.co', 'Biblioteca Pública', 1),
    ('Biblioteca Pública Manuel Zapata Olivella - El Tintal', '(601) 5803060 ext. 1001', 'Avenida Ciudad de Cali # 6C - 09', 'soledad.prieto@biblored.gov.co', 'Biblioteca Pública', 9);


insert into biblored.trabajador (p_nombre, s_nombre, p_apellido, s_apellido, telefono, email, email_trabajo, fec_nacimiento, cedula, sede_id)
values
    ('Ana', 'María', 'Gómez', 'López', '+57 3101234567', 'ana.gomez@gmail.com', 'ana.gomez@biblored.gov.co', '1985-04-12', '1034567890', 1),
    ('Carlos', null, 'Ramírez', 'Pineda', '+57 3112345678', 'carlos.ramirez@hotmail.com', 'carlos.ramirez@biblored.gov.co', '1978-11-05', '1023456789', 2),
    ('Laura', 'Isabel', 'Martínez', null, '+57 3123456789', 'laura.martinez@yahoo.com', 'laura.martinez@biblored.gov.co', '1990-07-22', '1045678901', 3),
    ('Juan', 'Andrés', 'Rodríguez', 'Sánchez', '+57 3134567890', 'juan.rodriguez@gmail.com', 'juan.rodriguez@biblored.gov.co', '1982-01-17', '1056789012', 4),
    ('María', null, 'Fernández', 'García', '+57 3145678901', 'maria.fernandez@outlook.com', 'maria.fernandez@biblored.gov.co', '1975-09-30', '1067890123', 5),
    ('David', 'Fernando', 'Torres', null, '+57 3156789012', 'david.torres@gmail.com', 'david.torres@biblored.gov.co', '1988-06-14', '1078901234', 6),
    ('Valentina', null, 'Suárez', 'Cárdenas', '+57 3167890123', 'valentina.suarez@yahoo.com', 'valentina.suarez@biblored.gov.co', '1992-03-05', '1089012345', 7),
    ('Andrés', 'Felipe', 'López', null, '+57 3178901234', 'andres.lopez@gmail.com', 'andres.lopez@biblored.gov.co', '1980-12-01', '1090123456', 8),
    ('Catalina', null, 'Pérez', 'Restrepo', '+57 3189012345', 'catalina.perez@hotmail.com', 'catalina.perez@biblored.gov.co', '1977-05-20', '1101234567', 9),
    ('Julián', 'Sebastián', 'Gómez', null, '+57 3190123456', 'julian.gomez@gmail.com', 'julian.gomez@biblored.gov.co', '1983-02-11', '1112345678', 10),
    ('Adriana', null, 'Muñoz', 'López', '+57 3201234567', 'adriana.munoz@yahoo.com', 'adriana.munoz@biblored.gov.co', '1989-08-25', '1123456789', 11),
    ('Fernando', 'Andrés', 'Castro', null, '+57 3212345678', 'fernando.castro@gmail.com', 'fernando.castro@biblored.gov.co', '1979-10-15', '1134567890', 12),
    ('Gabriela', null, 'Vega', 'Barrera', '+57 3223456789', 'gabriela.vega@hotmail.com', 'gabriela.vega@biblored.gov.co', '1991-03-09', '1145678901', 13),
    ('Ricardo', 'Esteban', 'Salazar', null, '+57 3234567890', 'ricardo.salazar@yahoo.com', 'ricardo.salazar@biblored.gov.co', '1984-05-05', '1156789012', 14),
    ('Natalia', null, 'Castro', 'León', '+57 3245678901', 'natalia.castro@gmail.com', 'natalia.castro@biblored.gov.co', '1989-09-17', '1167890123', 15),
    ('Sergio', 'Andrés', 'Cárdenas', null, '+57 3256789012', 'sergio.cardenas@hotmail.com', 'sergio.cardenas@biblored.gov.co', '1982-07-20', '1178901234', 16),
    ('Paola', null, 'Ruiz', 'González', '+57 3267890123', 'paola.ruiz@yahoo.com', 'paola.ruiz@biblored.gov.co', '1993-11-18', '1189012345', 5),
    ('Jorge', 'Enrique', 'Muñoz', null, '+57 3278901234', 'jorge.munoz@gmail.com', 'jorge.munoz@biblored.gov.co', '1987-01-27', '1190123456', 6),
    ('Claudia', null, 'Valencia', 'Ospina', '+57 3289012345', 'claudia.valencia@hotmail.com', 'claudia.valencia@biblored.gov.co', '1986-01-27', '1201234567', 7),
    ('Carlos', 'Andrés', 'Vera', null, '+57 3290123456', 'carlos.vera@gmail.com', 'carlos.vera@biblored.gov.co', '1977-04-04', '1212345678', 8);


insert into biblored.afiliado (documento_af, p_nombre, s_nombre, p_apellido, s_apellido, estado_afiliacion, f_inicio_afiliacion, f_fin_afiliacion, tipo_documento, fec_nacimiento, telefono, email, documento_ac)
values
    -- Afiliados menores con acudiente (documento_ac ≠ NULL)
    ('2001052167', 'Camila',    null,  'López',   'García',   'A', '2024-01-10', null, 'TI', '2012-05-22', '+57 3001112233', 'camila.lopez@example.com',    '1001052167'),
    ('2002052168', 'Santiago',  'David','Pérez',   null,        'A', '2023-09-01', null, 'RC', '2011-11-15', '+57 3112223344', 'santiago.perez@example.com', '1001052167'),
    ('2003052169', 'María',     'Paula','Rodríguez','Torres',    'I', '2021-03-20', '2024-03-19', 'TI', '2010-08-30', '+57 3123334455', 'maria.paula.rodriguez@example.com', '1212345678'),
    ('2004052170', 'Valentina', null,  'González', null,       'A', '2024-06-12', null, 'TI', '2013-02-05', '+57 3134445566', 'valentina.gonzalez@example.com', '1102123554'),
    ('2005052171', 'Mateo',     null,  'Martínez', 'Suárez',   'A', '2022-11-20', null, 'TI', '2014-07-18', '+57 3145556677', 'mateo.martinez@example.com',    '78254199'),
    ('2006052172', 'Sara',      'Lucía','Hernández',null,      'I', '2020-07-15', '2023-07-14', 'RC', '2009-09-10', '+57 3156667788', 'sara.hernandez@example.com',    '79707322'),
    ('2007052173', 'Lucas',     null,  'Ramírez',  'Castillo', 'A', '2023-05-05', null, 'TI', '2015-12-22', '+57 3167778899', 'lucas.ramirez@example.com',     '1000231233'),
    -- Adultos sin acudiente (documento_ac = NULL)
    ('2008052174', 'Andrés',    'Felipe','Torres',  'Cárdenas', 'A', '2020-02-14', null, 'CC', '1987-06-07', '+57 3178889900', 'andres.torres@example.com',    null),
    ('2009052175', 'Paola',     null,  'Sánchez', 'Vega',     'A', '2021-08-01', null, 'CC', '1990-03-09', '+57 3189990011', 'paola.sanchez@example.com',     null),
    ('2010052176', 'Fernando',  null,  'Castro',   null,       'I', '2018-05-10', '2023-05-09', 'CC', '1982-10-15', '+57 3190001122', 'fernando.castro@example.com',  null),
    ('2011052177', 'Natalia',   'Andrea','Gómez',    null,       'A', '2022-12-12', null, 'CC', '1979-01-27', '+57 3101112233', 'natalia.gomez@example.com',    null),
    -- Otros afiliados menores con acudiente (distintos responsables)
    ('2012052178', 'Diego',     null,  'Muñoz',    'López',    'A', '2024-03-18', null, 'TI', '2012-10-30', '+57 3112223344', 'diego.munoz@example.com',      '51105334'),
    ('2013052179', 'Camilo',    'Esteban','Suárez',  null,       'A', '2023-11-07', null, 'TI', '2013-06-05', '+57 3123334455', 'camilo.suarez@example.com',    '1020234811'),
    ('2014052180', 'Isabella',  null,  'Díaz',     'Restrepo', 'A', '2024-02-22', null, 'TI', '2014-04-14', '+57 3134445566', 'isabella.diaz@example.com',    '43909878'),
    ('2015052181', 'Mateo',     'Julián','Castaño',  null,       'I', '2021-09-09', '2024-09-08', 'RC', '2009-01-20', '+57 3145556677', 'mateo.castano@example.com',    '1002987612');

insert into biblored.editorial (nombre_editorial)
values 
	('Editorial Sudamericana'), 	--1
	('Plaza & Janés'), 				--2
	('Seix Barral'), 				--3
	('Hogarth Press'), 				--4
	('The Russian Messenger'), 		--5
	('Charles Scribner’s Sons'),	--6
	('Kōdansha'), 					--7
	('Thomas Cautley Newby'), 		--8
	('American Publishing Co.'), 	--9
	('Editora Rocco'), 				--10
	('Editorial Sur'), 				--11
	('Editorial Era'), 				--12
	('McClelland and Stewart'), 	--13
	('Chapman & Hall'); 			--14

insert into biblored.libro (codigo_isbn, titulo, editorial, ano_publicacion, edicion, genero_id)
values
    -- Gabriel García Márquez
    ('9780307474728', 'Cien años de soledad',          1,    1967, null,  2),
    -- Isabel Allende
    ('9788401352836', 'La casa de los espíritus',      2,    1982,    1,  2),
    -- Mario Vargas Llosa
    ('9788432205544', 'La ciudad y los perros',        3,    1963, null, 12),
    -- Julio Cortázar
    ('9788437604947', 'Rayuela',                       1,    1963,    3, 12),
    -- Virginia Woolf
    ('9780241341461', 'Mrs Dalloway',                  4,    1925, null, 12),
    -- León Tolstói
    ('9780140447934', 'Guerra y paz',                  5,    1869, null,  3),
    -- Ernest Hemingway
    ('9780684801223', 'El viejo y el mar',             6,    1952, null,  9),
    -- Haruki Murakami
    ('9788483460063', 'Tokio Blues (Norwegian Wood)',  7,    1987, null,  4),
    -- Emily Brontë
    ('9780141439556', 'Cumbres Borrascosas',           8,    1847,    2,  4),
    -- Mark Twain
    ('9780141321103', 'Las aventuras de Tom Sawyer',   9,    1876, null,  9),
    -- Clarice Lispector
    ('9788535910649', 'La hora de la estrella',        10,   1977, null, 12),
    -- Jorge Luis Borges
    ('9789504915625', 'Ficciones',                     11,   1944, null,  5),
    -- Carlos Fuentes
    ('9786071606177', 'La muerte de Artemio Cruz',     12,   1962,    2,  3),
    -- Margaret Atwood
    ('9780385490818', 'El cuento de la criada',        13,   1985, null,  1),
    -- Charles Dickens
    ('9780140439441', 'Great Expectations',            14,    861, null, 12);


insert into biblored.autor_libro (autor_id, codigo_isbn)
values
    (1,  '9780307474728'),  -- Gabriel García Márquez: Cien años de soledad
    (2,  '9788401352836'),  -- Isabel Allende: La casa de los espíritus
    (3,  '9788432205544'),  -- Mario Vargas Llosa: La ciudad y los perros
    (4,  '9788437604947'),  -- Julio Cortázar: Rayuela
    (5,  '9780241341461'),  -- Virginia Woolf: Mrs Dalloway
    (6,  '9780140447934'),  -- León Tolstói: Guerra y paz
    (7,  '9780684801223'),  -- Ernest Hemingway: El viejo y el mar
    (8,  '9788483460063'),  -- Haruki Murakami: Tokio Blues (Norwegian Wood)
    (9,  '9780141439556'),  -- Emily Brontë: Cumbres Borrascosas
    (10, '9780141321103'),  -- Mark Twain: Las aventuras de Tom Sawyer
    (11, '9788535910649'),  -- Clarice Lispector: La hora de la estrella
    (12, '9789504915625'),  -- Jorge Luis Borges: Ficciones
    (13, '9786071606177'),  -- Carlos Fuentes: La muerte de Artemio Cruz
    (14, '9780385490818'),  -- Margaret Atwood: El cuento de la criada
    (15, '9780140439441');  -- Charles Dickens: Great Expectations

insert into biblored.prestamo (fecha_devolucion, fecha_prestamo, doc_afiliado, estado)
values
    -- Préstamos activos (dentro del límite de devolución)
    ('2025-07-20', '2025-07-01', '2001052167', 'AT'),
    ('2025-07-22', '2025-07-03', '2002052168', 'AT'),
    ('2025-07-25', '2025-07-05', '2003052169', 'AT'),
    ('2025-07-28', '2025-07-08', '2004052170', 'AT'),
    ('2025-08-01', '2025-07-10', '2005052171', 'AT'),
    ('2025-07-19', '2025-07-02', '2006052172', 'AT'),
    ('2025-07-21', '2025-07-04', '2007052173', 'AT'),
    ('2025-07-23', '2025-07-06', '2008052174', 'AT'),
    ('2025-07-26', '2025-07-09', '2009052175', 'AT'),
    ('2025-07-24', '2025-07-07', '2010052176', 'AT'),
    -- Préstamos retrasados (RT: la fecha de devolución ya pasó)
    ('2025-06-30', '2025-06-10', '2011052177', 'RT'),
    ('2025-06-25', '2025-06-05', '2012052178', 'RT'),
    ('2025-06-20', '2025-06-01', '2013052179', 'RT'),
    ('2025-06-15', '2025-05-28', '2014052180', 'RT'),
    ('2025-06-10', '2025-05-20', '2015052181', 'RT');

insert into biblored.inventario (inventario_id, sede_id) --depende de inventario id
values	
	('A-N GARMC', 1),
	('A-N ALLEL', 3),
	('A-N VARLL', 2),
	('A-N CORTR', 4),
	('A-N WOOLM', 6),
	('A-N TOLSG', 7),
	('A-N HEMIE', 8),
	('A-N MURAT', 5),
	('A-N BRONC', 9),
	('A-N TWAIL', 10),
	('A-N LISPL', 15),
	('A-N LUIBF', 14),
	('A-N FUENL', 13),
	('A-N ATWOE', 11),
	('A-N DICKG', 12);

insert into biblored.ejemplar (estado_fisico, inventario_id, prestamo_id, codigo_isbn) -- depende del inventario id
values
	(null, 'A-N GARMC', 13,  '9780307474728'),
    (null, 'A-N ALLEL', 12,  '9788401352836'),
    (null, 'A-N VARLL', 14,  '9788432205544'),
    (null, 'A-N CORTR', 1,  '9788437604947'),
    (null, 'A-N WOOLM', null,  '9780241341461'),
    ('Solapa dañada', 'A-N TOLSG', null,  '9780140447934'),
    (null, 'A-N HEMIE', 5,  '9780684801223'),
    (null, 'A-N MURAT', 6,  '9788483460063'),
    (null, 'A-N BRONC', 10,  '9780141439556'),
    ('Cierta humedad', 'A-N TWAIL', null, '9780141321103'),
    ('Portada deteriorada', 'A-N LISPL', 2, '9788535910649'),
    (null, 'A-N LUIBF', 8, '9789504915625'),
    (null, 'A-N FUENL', 4, '9786071606177'),
    ('Reencuadernado', 'A-N ATWOE', 15, '9780385490818'),
    (null, 'A-N DICKG', 11, '9780140439441'),
	(null, 'A-N WOOLM', 3, '9780141321103'),
	(null, 'A-N TOLSG', 7, '9780140447934'),
	(null, 'A-N TWAIL', 9,  '9780241341461');


insert into biblored.contrato (fecha_inicio_con, fecha_fin_con, salario, tipo_vinculacion, trabajador_id, tipo_contrato) 
values
    ('2021-10-21', '2027-10-20', 2000000, 'Bibliotecario', 1, 2),
    ('2021-05-15', NULL, 1800000, 'Servicios Generales', 2, 3),
    ('2023-01-10', NULL, 2100000, 'Auxiliar Administrativo', 3, 1),
    ('2020-08-01', '2027-07-31', 2500000, 'Coordinador', 4, 2),
    ('2024-02-01', NULL, 1950000, 'Bibliotecario', 5, 1),
    ('2023-03-12', '2027-03-11', 1600000, 'Vigilancia', 6, 2),
    ('2022-07-20', NULL, 1700000, 'Servicios Generales', 7, 5),
    ('2021-11-01', '2027-10-31', 1850000, 'Auxiliar Administrativo', 8, 4),
    ('2024-01-01', '2027-01-01', 2600000, 'Coordinador', 9, 2),
    ('2020-03-15', NULL, 2200000, 'Bibliotecario', 10, 1),
    ('2023-06-01', NULL, 1750000, 'Vigilancia', 11, 6),
    ('2022-09-10', '2027-09-09', 1900000, 'Servicios Generales', 12, 2),
    ('2021-04-25', NULL, 2300000, 'Auxiliar Administrativo', 13, 1),
    ('2020-12-01', '2027-12-01', 2400000, 'Coordinador', 14, 3),
    ('2024-06-15', NULL, 1800000, 'Bibliotecario', 15, 1),
    ('2022-01-05', '2027-01-04', 1650000, 'Vigilancia', 16, 2),
    ('2023-07-01', NULL, 2000000, 'Auxiliar Administrativo', 17, 1),
    ('2021-09-30', '2027-09-30', 1700000, 'Servicios Generales', 18, 2),
    ('2023-11-20', NULL, 2550000, 'Coordinador', 19, 1),
    ('2020-02-15', '2027-02-14', 1850000, 'Vigilancia', 20, 3);
--No se hace ningun insert a la tabla historico porque eso se llena solo con procedimientos almacenados (Por el momento)

---------------------------------------------------------------------------------------------------------------------
----Procedimiento Almacenado --------------------------------------------------------------
-- Funcion que guardará los valores de un préstamo que se eliminará de la DB dentro del histórico de préstamos --
create or replace function prestamo_finalizado() returns trigger as $$
	declare
    v_ejemplar_id int; --Aquí se guardará la referencia que se tiene de préstamo en la tabla ejemplar
    
	begin
		-- Introducimos la consulta del ejemplar que coincida con el prestamo a eliminar para guardar la copia --
		select ejemplar_id into v_ejemplar_id
    	from biblored.ejemplar
    	where ejemplar.prestamo_id = old.prestamo_id;

		insert into biblored.historico_prestamo (prestamo_id, ejemplar_id, fecha_prestamo, fecha_devolucion, doc_afiliado)
		values (old.prestamo_id, v_ejemplar_id, old.fecha_prestamo, old.fecha_devolucion, old.doc_afiliado);
		return old; -- Retorna old para que continúe la operación del delete

	end
$$ language plpgsql;

-- Trigger que se encarga de ejecutar la función de copia de datos de los préstamos completados una vez se eliminen de la DB --
create trigger auditoria_prestamo
before delete on prestamo
for each row execute function prestamo_finalizado();

------------------------------------------------------------------------------------------------------------------------------------
--Consultas

-- Afiliado desea consultar la disponibilidad de los ejemplares de un libro (y sus caracteristicas) en cada una de las sedes donde exista buscando por titulo del libro --
-- Consultara el libro 'las aventuras de tom sawyer'

select inventario.inventario_id, libro.titulo,
	   (select nombre_editorial from editorial where libro.editorial = editorial.editorial_id), libro.ano_publicacion,
	   case when prestamo_id is not null then 'En Préstamo' else 'Disponible' end as Disponibilidad, 
	   sede.nombre as Sede
from inventario
inner join ejemplar on inventario.inventario_id = ejemplar.inventario_id 
inner join libro on libro.codigo_isbn = ejemplar.codigo_isbn
inner join sede on sede.sede_id = inventario.sede_id
where lower(libro.titulo) = lower('cien años de soledad');
--Se les da el mismo formato de texto a la condicion para que se encuentre el libro sin importar si se escribió en mayúscula o minúscula el titulo



-- Trabajador desea consultar los detalles de su contrato laboral.

select t1.p_nombre, t1.s_nombre, t1.p_apellido, t1.s_apellido, c.contrato_id as Numero_de_Contrato, t2.nombre_contrato as Tipo_Contrato,
	   fecha_inicio_con, fecha_fin_con, tipo_vinculacion as Cargo
from contrato c 
inner join tipo_contrato t2 on c.tipo_contrato = t2.tipo_contrato_id
inner join trabajador t1 on t1.trabajador_id = c.contrato_id
where c.trabajador_id = 3;

-- Acudiente desea consultar los datos de los afiliados que están a su cargo, el estado de afiliación de ellos y sus prestamos

select 
    afiliado.documento_af, afiliado.p_nombre, afiliado.p_apellido,
    case 
        when afiliado.estado_afiliacion = 'A' then 'Activo'
        else 'Inactivo'
    end as estado_afiliacion, 
    prestamo.fecha_prestamo, prestamo.fecha_devolucion,
    STRING_AGG(libro.titulo, ', ') AS titulos_prestados
    
from biblored.afiliado
left join biblored.prestamo
    on afiliado.documento_af = prestamo.doc_afiliado and prestamo.estado = 'AT'
left join biblored.ejemplar
    on prestamo.prestamo_id = ejemplar.prestamo_id
left join biblored.libro
    on ejemplar.codigo_isbn = libro.codigo_isbn
where afiliado.documento_ac = '1001052167'
group by afiliado.documento_af, afiliado.p_nombre, afiliado.p_apellido, afiliado.estado_afiliacion, prestamo.fecha_prestamo, prestamo.fecha_devolucion;


-- El gerente desea consultar cuantos meses le restan a los trabajadores de una sede.

SELECT 
    biblored.trabajador.cedula,
    biblored.trabajador.p_nombre,
    biblored.trabajador.p_apellido,
    biblored.contrato.fecha_inicio_con,
    biblored.contrato.fecha_fin_con,
    CASE 
       
        WHEN biblored.contrato.fecha_fin_con IS NULL THEN 'Fecha indefinida'
        ELSE 
            (EXTRACT(YEAR FROM AGE(biblored.contrato.fecha_fin_con, CURRENT_DATE)) * 12
             + EXTRACT(MONTH FROM AGE(biblored.contrato.fecha_fin_con, CURRENT_DATE))
            )::text
    END AS meses_restantes
FROM biblored.trabajador
LEFT JOIN biblored.contrato 
    ON biblored.trabajador.trabajador_id = biblored.contrato.trabajador_id;

        
-- Esta consulta es para los bibliotecarios, pones en que sede quieres consultar los libros, la consulta  
-- muestra cuantos libros hay de una editorial y sus titulos.
        
SELECT 
    biblored.editorial.nombre_editorial AS nombre_editorial,
    COUNT(*) AS total_libros,
    STRING_AGG(biblored.libro.titulo, ', ') AS titulos
FROM biblored.ejemplar
INNER JOIN biblored.libro 
    ON biblored.ejemplar.codigo_isbn = biblored.libro.codigo_isbn
INNER JOIN biblored.editorial
    ON biblored.libro.editorial = biblored.editorial.editorial_id
INNER JOIN biblored.inventario
    ON biblored.ejemplar.inventario_id = biblored.inventario.inventario_id
INNER JOIN biblored.sede
    ON biblored.inventario.sede_id = biblored.sede.sede_id
WHERE biblored.sede.sede_id = 1 -- ACA SE PONE LA SEDE QUE UNO QUIERE
GROUP BY biblored.editorial.nombre_editorial;










