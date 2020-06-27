-- Parte 1 Crear una vista que trae la cantidad maxima de atletas asociados a un pais que compitan en Atletismo
CREATE OR REPLACE VIEW MAX_ATLETA_ATLETISMO_PAIS AS 
    SELECT P.ID_PAIS, P.NOMBRE, COUNT(*) AS CANTIDAD_ATLETA
    FROM COMPETENCIA C
    LEFT JOIN PARTICIPAR_COMPETENCIA PC ON (C.ID_COMPETENCIA = PC.ID_COMPETENCIA)
    LEFT JOIN ATLETA A ON A.ID_ATLETA = PC.ID_ATLETA
    INNER JOIN DELEGACION D ON (D.ATLETA = A.ID_ATLETA)
    INNER JOIN PAIS P ON (P.ID_PAIS = D.PAIS)
    WHERE TIPO = (SELECT TD.ID_TIPO FROM TIPOS_DEPORTES TD WHERE (UPPER(TD.DESCRIPCION) = 'ATLETISMO'))
    GROUP BY (P.ID_PAIS, P.NOMBRE);