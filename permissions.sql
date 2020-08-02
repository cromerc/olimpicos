-- Crear el rol de administrador y asignar permiso para hacer todo con las tablas
CREATE ROLE OLIMPICOS_ADMIN;
GRANT CREATE SESSION TO OLIMPICOS_ADMIN;
GRANT ALL ON ATLETA TO OLIMPICOS_ADMIN;
GRANT ALL ON CAPITAL TO OLIMPICOS_ADMIN;
GRANT ALL ON CATEGORIA TO OLIMPICOS_ADMIN;
GRANT ALL ON CIUDAD TO OLIMPICOS_ADMIN;
GRANT ALL ON COMPETENCIA TO OLIMPICOS_ADMIN;
GRANT ALL ON COMPETER_POR TO OLIMPICOS_ADMIN;
GRANT ALL ON DELEGACION TO OLIMPICOS_ADMIN;
GRANT ALL ON GANAR TO OLIMPICOS_ADMIN;
GRANT ALL ON HOSPEDAR TO OLIMPICOS_ADMIN;
GRANT ALL ON HOTEL TO OLIMPICOS_ADMIN;
GRANT ALL ON LUGAR TO OLIMPICOS_ADMIN;
GRANT ALL ON MEDALLA TO OLIMPICOS_ADMIN;
GRANT ALL ON PAIS TO OLIMPICOS_ADMIN;
GRANT ALL ON PARTICIPAR_COMPETENCIA TO OLIMPICOS_ADMIN;
GRANT ALL ON PARTICIPAR_PRECOMPETENCIA TO OLIMPICOS_ADMIN;
GRANT ALL ON PERTENECER TO OLIMPICOS_ADMIN;
GRANT ALL ON PRECOMPETENCIA TO OLIMPICOS_ADMIN;
GRANT ALL ON TIPOS_DEPORTES TO OLIMPICOS_ADMIN;

-- Crear el rol de lector y asignar permiso para leer desde todas las tablas
CREATE ROLE OLIMPICOS_LECTOR;
GRANT CREATE SESSION TO OLIMPICOS_LECTOR;
GRANT SELECT ON ATLETA TO OLIMPICOS_LECTOR;
GRANT SELECT ON CAPITAL TO OLIMPICOS_LECTOR;
GRANT SELECT ON CATEGORIA TO OLIMPICOS_LECTOR;
GRANT SELECT ON CIUDAD TO OLIMPICOS_LECTOR;
GRANT SELECT ON COMPETENCIA TO OLIMPICOS_LECTOR;
GRANT SELECT ON COMPETER_POR TO OLIMPICOS_LECTOR;
GRANT SELECT ON DELEGACION TO OLIMPICOS_LECTOR;
GRANT SELECT ON GANAR TO OLIMPICOS_LECTOR;
GRANT SELECT ON HOSPEDAR TO OLIMPICOS_LECTOR;
GRANT SELECT ON HOTEL TO OLIMPICOS_LECTOR;
GRANT SELECT ON LUGAR TO OLIMPICOS_LECTOR;
GRANT SELECT ON MEDALLA TO OLIMPICOS_LECTOR;
GRANT SELECT ON PAIS TO OLIMPICOS_LECTOR;
GRANT SELECT ON PARTICIPAR_COMPETENCIA TO OLIMPICOS_LECTOR;
GRANT SELECT ON PARTICIPAR_PRECOMPETENCIA TO OLIMPICOS_LECTOR;
GRANT SELECT ON PERTENECER TO OLIMPICOS_LECTOR;
GRANT SELECT ON PRECOMPETENCIA TO OLIMPICOS_LECTOR;
GRANT SELECT ON TIPOS_DEPORTES TO OLIMPICOS_LECTOR;

-- Crear un usuario admin y lector con claves
CREATE USER ADMIN IDENTIFIED BY "adminpass";
CREATE USER LECTOR IDENTIFIED BY "lectorpass";

-- Asignar el usuario admin a rol de admin y usuario lector a rol de lector
GRANT OLIMPICOS_ADMIN TO ADMIN;
GRANT OLIMPICOS_LECTOR TO LECTOR;
