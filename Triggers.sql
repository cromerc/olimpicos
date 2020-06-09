CREATE OR REPLACE TRIGGER correlative_increment BEFORE INSERT ON ciudad FOR EACH ROW

DECLARE
    
    idCiudad number;

BEGIN
    
    SELECT MAX(id_ciudad) INTO idCiudad FROM ciudad;
    :new.id_ciudad := idCiudad + 1;
END;