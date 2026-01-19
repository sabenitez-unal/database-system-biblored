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