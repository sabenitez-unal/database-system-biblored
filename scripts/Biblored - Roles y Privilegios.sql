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

