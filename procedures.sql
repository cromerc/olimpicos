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
