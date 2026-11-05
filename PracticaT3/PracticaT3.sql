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
