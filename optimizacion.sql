SELECT P.ID_PAIS, P.NOMBRE, COUNT(A.ID_ATLETA) AS CANTIDAD_ATLETA
    FROM COMPETENCIA C
    LEFT JOIN PARTICIPAR_COMPETENCIA PC ON (C.ID_COMPETENCIA = PC.ID_COMPETENCIA)
    LEFT JOIN ATLETA A ON A.ID_ATLETA = PC.ID_ATLETA
    INNER JOIN DELEGACION D ON (D.ATLETA = A.ID_ATLETA)
    INNER JOIN PAIS P ON (P.ID_PAIS = D.PAIS)
    INNER JOIN TIPOS_DEPORTES TD ON (C.TIPO = TD.ID_TIPO AND (UPPER(TD.DESCRIPCION) = 'ATLETISMO'))
    GROUP BY (P.ID_PAIS, P.NOMBRE);
    
    
SELECT P.ID_PAIS, P.NOMBRE, COUNT(*) AS CANTIDAD_ATLETA
    FROM COMPETENCIA C
    LEFT JOIN PARTICIPAR_COMPETENCIA PC ON (C.ID_COMPETENCIA = PC.ID_COMPETENCIA)
    LEFT JOIN ATLETA A ON A.ID_ATLETA = PC.ID_ATLETA
    INNER JOIN DELEGACION D ON (D.ATLETA = A.ID_ATLETA)
    INNER JOIN PAIS P ON (P.ID_PAIS = D.PAIS)
    WHERE TIPO = (SELECT TD.ID_TIPO FROM TIPOS_DEPORTES TD WHERE (UPPER(TD.DESCRIPCION) = 'ATLETISMO'))
    GROUP BY (P.ID_PAIS, P.NOMBRE);
    