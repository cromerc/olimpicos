-- Trigger 3
CREATE OR REPLACE TRIGGER CORRELATIVE_INCREMENT_CIUDAD
BEFORE INSERT
ON CIUDAD

FOR EACH ROW
DECLARE
    v_id_ciudad CIUDAD.ID_CIUDAD%TYPE;

BEGIN
    SELECT MAX(ID_CIUDAD) INTO v_id_ciudad FROM CIUDAD;

    IF v_id_ciudad IS NULL THEN 
        :NEW.ID_CIUDAD := 1;
    ELSE
        :NEW.ID_CIUDAD := v_id_ciudad + 1;
    END IF;
END;

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
            DBMS_OUTPUT.PUT_LINE('EL ATLETA HA PARTICIPADO EN PRECOMPETENCIAS ASOCIADAS');
        ELSE
            RAISE_APPLICATION_ERROR(-20120, 'NO SE PUEDE INSERTAR, EL ATLETA NO POSEE PRECOMPETENCIAS ASOCIADAS A LA COMPETENCIA');
        END IF;
    CLOSE PARTICIPAR_PRECO;
END;

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
