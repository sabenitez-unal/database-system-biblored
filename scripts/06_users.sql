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



