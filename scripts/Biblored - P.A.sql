--Procedimiento Almacenado --------------------------------------------------------------
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