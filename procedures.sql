-- Stored procedure 1
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


/* Stored procedure 2 */
/* Busca los Lugares una id, suma todas las coincidencias de Precompetencia y Competencia y devuelve la suma */
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


/* Ordena los lugares en base a las condiciones dadas */
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
