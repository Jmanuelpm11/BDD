Tarea 1: Creación de usuarios y políticas de conexión y caducidad
1.1

Create User "gestor_tienda"@"localhost" IDENTIFIED BY "gestor4321"

Create User "auditor_externo"@"%" IDENTIFIED BY "auditor1234"

-- En cuanto a la creacionde las contraseñas lo que he hecho es asegurarme de que las contraseñas no sean
iguales, para evitar fallas de seguridad, ademas e usado letras y numeros para hacer mas dificil acceder
acceder a la contraseña. 

1.2 

ALTER USER "auditor_externo"@"%" PASSWORD EXPIRE INTERVAL 30 DAY;

1.3

ALTER USER "gestor_tienda"@"%" CONNECTION_LIMIT 0 PASSWORD EXPIRE


Tarea 2: Creación y asignación de roles

2.1 

Create role "rol_consultor"

2.2

GRANT SELECT ON tienda_informatica TO "rol_consultor"@"%"

2.3

GRANT "rol_consultor" TO "auditor_externo"@"%"

Tarea 3: Seguridad mediante Vistas y Privilegios Granulares

3.1 

Create view v_tecnicos_activos AS 
SELECT ID, nombre, especialidad 
FROM Tecnicos 

3.2

GRANT SELECT ON v_tecnicos_activos TO gestor_tienda;

3.3

SELECT * FROM tecnicos;

Tarea 4: Consistencia y control con WITH CHECK OPTION

4.1

CREATE VIEW v_articulos_gama_baja AS
SELECT * FROM articulos
WHERE precio <= 50.00
WITH CHECK OPTION;

4.2

INSERT INTO v_articulos_gama_baja (id, nombre, precio) 
VALUES (101, 'Teclado Mecánico RGB', 75.00);

Tarea 5: Auditoría, Resolución de Incidencias y Reflexión Crítica (Apartado de
Análisis y Razonamiento)

5.1

-- Consultar privilegios específicos sobre tablas y vistas
SELECT grantee, table_name, privilege_type 
FROM information_schema.table_privileges 
WHERE grantee = 'auditor_externo';

-- Comprobar roles asignados al usuario
SELECT member::regrole AS rol, roleid::regrole AS grupo 
FROM pg_auth_members 
JOIN pg_roles ON pg_auth_members.roleid = pg_roles.oid 
WHERE member::regrole::text = 'auditor_externo';

5.2 

Basicamente si tu le das privilegios a todos los usuarios, crearias una brecha de seguridad
enorme, ya que si alguien externo a la empresa quiere intentar acceder a los datos, puede acceder desde cualquier usuario
eso lo que hace es que sea significativamente mas facil poder acceder a los datos de la Base de datos por parte de algun atacante.

5.3 

Al eliminar WITH CHECK OPTION, la vista sigue filtrando al consultar (SELECT), 
pero deja de validar las modificaciones (INSERT y UPDATE).

Esto permite insertar registros que no cumplen la condición (como artículos de más de 50 €) directamente en la tabla base,
haciendo que queden ocultos e invisibles al consultar la vista y rompiendo la integridad de los datos.



