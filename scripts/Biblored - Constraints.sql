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

