
/* Pregunta 3*/
CREATE OR REPLACE TRIGGER correlative_increment BEFORE INSERT ON ciudad FOR EACH ROW

DECLARE
    
    idCiudad number;

BEGIN
    
    SELECT MAX(id_ciudad) INTO idCiudad FROM ciudad;
    :new.id_ciudad := idCiudad + 1;
END;

/* Pregunta 4 */

CREATE OR REPLACE TRIGGER Validacion_Pre_Competencia BEFORE INSERT ON PARTICIPAR_COMPETENCIA
FOR EACH ROW
DECLARE
    CURSOR participar_preco 
        IS SELECT PPC.id_precompetencia
        FROM PARTICIPAR_PRECOMPETENCIA PPC
        LEFT JOIN PRECOMPETENCIA PC ON PC.id_precompetencia = PPC.id_precompetencia
        WHERE PPC.id_atleta = :NEW.id_atleta AND pc.competencia = :NEW.id_competencia;
        
        id_precompetencia PARTICIPAR_PRECOMPETENCIA.id_precompetencia%TYPE;
        
BEGIN
                
    OPEN participar_preco;
        FETCH participar_preco into id_precompetencia;
        IF participar_preco%found THEN 
            dbms_output.put_line('EL ATLETA HA PARTICIPADO EN PRECOMPETENCIAS ASOCIADAS');
        ELSE Raise_Application_Error(-20120, 'NO SE PUEDE INSERTAR, EL ATLETA NO POSEE PRECOMPETENCIAS ASOCIADAS A LA COMPETENCIA');
        END IF;
    CLOSE participar_preco;

END;


INSERT INTO "PARTICIPAR_COMPETENCIA" (ID_COMPETENCIA, ID_ATLETA, FECHA) VALUES ('1', '21', TO_DATE('2020-07-09 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO "PARTICIPAR_PRECOMPETENCIA" (ID_PRECOMPETENCIA, ID_ATLETA, PUNTAJE, FECHA) VALUES ('3', '2', '100', TO_DATE('2020-06-27 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO "PARTICIPAR_COMPETENCIA" (ID_COMPETENCIA, ID_ATLETA, FECHA) VALUES ('1', '21', TO_DATE('2020-07-09 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));


/* Pregunta 5 */