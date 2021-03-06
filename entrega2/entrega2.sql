-- Christopher Cromer - Sección 1
-- Ignacio Ortiz - Sección 2

-- 1
-- Se usa el año para mostrar los resultados en tal año
-- Si se pasa el valor 0 por el año se muestra por todos los años en vez de un año especifico
CREATE OR REPLACE PROCEDURE CUADRO_HONOR(ANO_IN INTEGER)
IS
    V_NOMBRE PAIS.NOMBRE%TYPE;
    V_PUNTAJE INTEGER;

    CURSOR C_GANAR IS
        SELECT
            P2.NOMBRE,
            SUM(
                CASE
                    WHEN LOWER(M.DESCRIPCION) = 'oro' THEN
                        3
                    WHEN LOWER(M.DESCRIPCION) = 'plata' THEN
                        2
                    WHEN LOWER(M.DESCRIPCION) = 'bronce' THEN
                        1
                    ELSE
                        0
                END
            ) AS PUNTAJE
        FROM GANAR G
        JOIN COMPETER_POR C ON (C.ID_ATLETA = G.ID_ATLETA)
        JOIN PERTENECER P ON (P.ID_DELEGACION = C.ID_DELEGACION)
        JOIN PAIS P2 ON (P2.ID_PAIS = P.ID_PAIS)
        JOIN MEDALLA M ON (M.ID_MEDALLA = G.ID_MEDALLA)
        WHERE (
            ANO_IN =
            CASE
                WHEN ANO_IN != 0 THEN
                    EXTRACT(YEAR FROM G.FECHA)
                ELSE
                    ANO_IN
            END
        )
        GROUP BY P2.NOMBRE
        ORDER BY PUNTAJE DESC;
BEGIN
    OPEN C_GANAR;
    FETCH C_GANAR INTO V_NOMBRE, V_PUNTAJE;
    DBMS_OUTPUT.PUT_LINE('País' || CHR(9) || CHR(9) || 'Puntaje');
    WHILE C_GANAR%FOUND
    LOOP
        DBMS_OUTPUT.PUT_LINE(V_NOMBRE || CHR(9) || CHR(9) || V_PUNTAJE);
        FETCH C_GANAR INTO V_NOMBRE, V_PUNTAJE;
    END LOOP;
    CLOSE C_GANAR;
END;
/

-- 2
-- Busca los Lugares una id, suma todas las coincidencias de Precompetencia y Competencia y devuelve la suma
CREATE OR REPLACE PROCEDURE OBTENER_CONTADOR(IDLUGAR IN INTEGER, SUMA OUT INTEGER)
IS
    V_ID_PAIS PAIS.ID_PAIS%TYPE;
    V_NOMBRE PAIS.NOMBRE%TYPE;
    V_CONTADOR INTEGER;
    V_SUMA INTEGER DEFAULT 0;
    
    CURSOR L_PC IS
            SELECT L.ID_LUGAR, L.NOMBRE, COUNT(*) AS CONTADOR_PRECOMPETENCIA 
                FROM PRECOMPETENCIA PC
                LEFT JOIN LUGAR L ON (PC.LUGAR = L.ID_LUGAR)
                WHERE L.ID_LUGAR = IDLUGAR
                GROUP BY (L.ID_LUGAR, L.NOMBRE);
                
    CURSOR L_C IS
        SELECT L.ID_LUGAR, L.NOMBRE, COUNT(*) AS CONTADOR_COMPETENCIA 
            FROM COMPETENCIA C
            LEFT JOIN LUGAR L ON (C.LUGAR = L.ID_LUGAR)
            WHERE L.ID_LUGAR = IDLUGAR
            GROUP BY (L.ID_LUGAR, L.NOMBRE);
            
BEGIN 

    OPEN L_PC;
    FETCH L_PC INTO V_ID_PAIS, V_NOMBRE, V_CONTADOR;
    
    WHILE L_PC%FOUND
    LOOP
        V_SUMA := V_SUMA + V_CONTADOR;
        FETCH L_PC INTO V_ID_PAIS, V_NOMBRE, V_CONTADOR;
    END LOOP;
    CLOSE L_PC;
    
    OPEN L_C;
    FETCH L_C INTO V_ID_PAIS, V_NOMBRE, V_CONTADOR;
    
    WHILE L_C%FOUND
    LOOP
        V_SUMA := V_SUMA + V_CONTADOR;
        FETCH L_C INTO V_ID_PAIS, V_NOMBRE, V_CONTADOR;
    END LOOP;
    CLOSE L_C;
    SUMA := V_SUMA;
END;


-- Ordena los lugares en base a las condiciones dadas
CREATE OR REPLACE PROCEDURE ORDENACION_LUGAR
    IS
        SUMA INTEGER;
        IDL LUGAR.ID_LUGAR%TYPE;
        NOMBREL LUGAR.NOMBRE%TYPE;
        CURSOR lugares IS
            SELECT L.ID_LUGAR, L.NOMBRE
            FROM LUGAR L;
BEGIN
    OPEN lugares;
    FETCH lugares INTO IDL, NOMBREL;
    WHILE lugares%FOUND LOOP    
        SUMA :=0;
        OBTENER_CONTADOR(IDL, SUMA);
        IF SUMA >= 10 THEN
            DBMS_OUTPUT.put_line('El lugar ' || NOMBREL || ' Es de Clasificacion "LUGAR PRINCIPAL" con una cantidad de: ' || SUMA);
        ELSIF SUMA >= 5 and SUMA < 9 THEN
            DBMS_OUTPUT.put_line('El lugar ' || NOMBREL || ' Es de Clasificacion "LUGAR PRIMARIO" con una cantidad de: ' || SUMA);
        ELSIF SUMA < 5 THEN
            DBMS_OUTPUT.put_line('El lugar ' || NOMBREL || ' Es de Clasificacion "LUGAR SECUNDARIO" con una cantidad de: ' || SUMA);
        END IF;
        FETCH lugares INTO IDL, NOMBREL;
    END LOOP;
END;
/

-- 3
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

-- 4
-- La consulta original
SELECT P.ID_PAIS, P.NOMBRE, COUNT(*) AS CANTIDAD_ATLETA
FROM COMPETENCIA C
LEFT JOIN PARTICIPAR_COMPETENCIA PC ON (C.ID_COMPETENCIA = PC.ID_COMPETENCIA)
LEFT JOIN ATLETA A ON A.ID_ATLETA = PC.ID_ATLETA
INNER JOIN DELEGACION D ON (D.ATLETA = A.ID_ATLETA)
INNER JOIN PAIS P ON (P.ID_PAIS = D.PAIS)
WHERE TIPO = (SELECT TD.ID_TIPO FROM TIPOS_DEPORTES TD WHERE (UPPER(TD.DESCRIPCION) = 'ATLETISMO'))
GROUP BY (P.ID_PAIS, P.NOMBRE);

-- La consulta optimizada
SELECT P.ID_PAIS, P.NOMBRE, COUNT(A.ID_ATLETA) AS CANTIDAD_ATLETA
FROM COMPETENCIA C
LEFT JOIN PARTICIPAR_COMPETENCIA PC ON (C.ID_COMPETENCIA = PC.ID_COMPETENCIA)
LEFT JOIN ATLETA A ON A.ID_ATLETA = PC.ID_ATLETA
INNER JOIN DELEGACION D ON (D.ATLETA = A.ID_ATLETA)
INNER JOIN PAIS P ON (P.ID_PAIS = D.PAIS)
INNER JOIN TIPOS_DEPORTES TD ON (C.TIPO = TD.ID_TIPO AND (UPPER(TD.DESCRIPCION) = 'ATLETISMO'))
GROUP BY (P.ID_PAIS, P.NOMBRE);
