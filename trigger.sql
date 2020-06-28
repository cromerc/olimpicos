-- Trigger 3
CREATE OR REPLACE TRIGGER CORRELATIVE_INCREMENT_CIUDAD
BEFORE INSERT
ON CIUDAD

FOR EACH ROW
DECLARE
    v_id_ciudad CIUDAD.ID_CIUDAD%TYPE;
    v_id_ciudad_busqueda CIUDAD.ID_CIUDAD%TYPE;

BEGIN
    SELECT MAX(ID_CIUDAD) INTO v_id_ciudad FROM CIUDAD;

    IF (:NEW.ID_CIUDAD IS NOT NULL) AND (v_id_ciudad IS NOT NULL) THEN 
        IF (v_id_ciudad+1) < :NEW.ID_CIUDAD THEN
            RAISE_APPLICATION_ERROR(-20000, 'No se puede insertar! El ID ingresado es mayor al ID maximo de la tabla!');
        END IF;
    ELSE
        IF v_id_ciudad IS NULL THEN  
            :NEW.ID_CIUDAD := 1;
        ELSE
            IF :NEW.ID_CIUDAD IS NOT NULL THEN
                SELECT ID_CIUDAD INTO v_id_ciudad_busqueda
                FROM CIUDAD WHERE (ID_CIUDAD = :NEW.ID_CIUDAD);
                
                IF v_id_ciudad_busqueda IS NOT NULL THEN
                    RAISE_APPLICATION_ERROR(-20001, 'No se puede insertar! El ID ingresado ya existe!');
                END IF;
            ELSE
                :NEW.ID_CIUDAD := v_id_ciudad + 1;
            END IF;
        END IF;
    END IF;
END;
/

-- Trigger 4
CREATE OR REPLACE TRIGGER VALIDACION_PRE_COMPETENCIA
BEFORE INSERT
ON PARTICIPAR_COMPETENCIA

FOR EACH ROW
DECLARE
    CURSOR PARTICIPAR_PRECO IS
        SELECT PPC.ID_PRECOMPETENCIA
        FROM PARTICIPAR_PRECOMPETENCIA PPC
        LEFT JOIN PRECOMPETENCIA PC ON (PC.ID_PRECOMPETENCIA = PPC.ID_PRECOMPETENCIA)
        WHERE (PPC.ID_ATLETA = :NEW.ID_ATLETA AND PC.COMPETENCIA = :NEW.ID_COMPETENCIA);
        
        v_id_precompetencia PARTICIPAR_PRECOMPETENCIA.ID_PRECOMPETENCIA%TYPE;
        
BEGIN
    OPEN PARTICIPAR_PRECO;
        FETCH PARTICIPAR_PRECO INTO v_id_precompetencia;
        IF PARTICIPAR_PRECO%FOUND THEN 
            DBMS_OUTPUT.PUT_LINE('El atleta ha participado en precompetencias asociadas.');
        ELSE
            RAISE_APPLICATION_ERROR(-20002, 'No se puede insertar! El atleta no posee precompetencias asociadas a la competencia!');
        END IF;
    CLOSE PARTICIPAR_PRECO;
END;
/

-- Trigger 5
CREATE OR REPLACE TRIGGER CALCULAR_VALOR_DELEGACION
BEFORE INSERT OR UPDATE
ON HOSPEDAR

FOR EACH ROW
DECLARE
    v_atletas DELEGACION.CANTIDAD_ATLETAS%TYPE;

BEGIN
    IF INSERTING THEN
        SELECT CANTIDAD_ATLETAS INTO v_atletas
        FROM DELEGACION WHERE (ID_DELEGACION = :NEW.ID_DELEGACION);

        :NEW.PRECIO_DELEGACION := v_atletas * :NEW.PRECIO_ATLETA;
    ELSIF UPDATING THEN
        SELECT CANTIDAD_ATLETAS INTO v_atletas
        FROM DELEGACION WHERE (ID_DELEGACION = :NEW.ID_DELEGACION);

        :NEW.PRECIO_DELEGACION := v_atletas * :NEW.PRECIO_ATLETA;
    END IF;
END;
