-- Consulta 1 de la guia
SELECT CONCAT(A.NOMBRE, CONCAT(' ', A.APELLIDO)) AS NOMBRE_ATLETA
FROM PARTICIPAR_PRECOMPETENCIA PP
LEFT JOIN ATLETA A ON (PP.ID_ATLETA = A.ID_ATLETA)
WHERE A.ID_ATLETA NOT IN (
    SELECT PC.ID_ATLETA
    FROM PARTICIPAR_COMPETENCIA PC
    LEFT JOIN COMPETENCIA C ON (C.ID_COMPETENCIA = PC.ID_COMPETENCIA)
    LEFT JOIN PRECOMPETENCIA P ON (P.COMPETENCIA = C.ID_COMPETENCIA)
    LEFT JOIN PARTICIPAR_PRECOMPETENCIA PP2 ON (PP2.ID_PRECOMPETENCIA = P.ID_PRECOMPETENCIA)
    WHERE (PC.ID_ATLETA = PP2.ID_ATLETA)
);

-- Consulta 2 de la guia

/*Parte 1 Crear una vista que trae la cantidad maxima de atletas asociados a un pais que compitan en Atletismo*/
CREATE OR REPLACE VIEW MAX_ATLETA_ATLETISMO_PAIS AS 

    SELECT P.id_pais, P.nombre, COUNT(*) AS Cantidad_Atleta FROM competencia C
        LEFT JOIN 
            Participar_Competencia PC on C.id_competencia = PC.id_competencia
        LEFT JOIN
            Atleta A on A.id_atleta = PC.id_atleta
        INNER JOIN 
            Delegacion D on D.atleta = A.id_atleta
        INNER JOIN 
            PAIS P on p.id_pais = D.pais
        WHERE 
            tipo = (SELECT TD.id_tipo FROM tipos_deportes TD WHERE TD.descripcion = 'Atletismo')
        GROUP BY
            P.id_pais, P.nombre;
        


SELECT P.NOMBRE, M.CANTIDAD_ATLETA FROM MAX_ATLETA_ATLETISMO_PAIS M
LEFT JOIN PAIS P ON (P.ID_PAIS = M.ID_PAIS)
WHERE (M.CANTIDAD_ATLETA = (SELECT MAX(CANTIDAD_ATLETA) FROM MAX_ATLETA_ATLETISMO_PAIS))