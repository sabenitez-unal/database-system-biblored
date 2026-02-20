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










