CREATE TABLE medalla(
    id_medalla NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
    descripcion VARCHAR2(50),
    CONSTRAINT medalla_pk PRIMARY KEY (id_medalla)
);

INSERT INTO "IGNACIO"."MEDALLA" (DESCRIPCION) VALUES ('oro');
INSERT INTO "IGNACIO"."MEDALLA" (DESCRIPCION) VALUES ('plata ');
INSERT INTO "IGNACIO"."MEDALLA" (DESCRIPCION) VALUES ('bronce');

CREATE TABLE categoria(
    id_categoria NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
    descripcion VARCHAR(50),
    CONSTRAINT categoria_pk PRIMARY KEY (id_categoria)
);

INSERT INTO "IGNACIO"."CATEGORIA" (DESCRIPCION) VALUES ('100 Metros');
INSERT INTO "IGNACIO"."CATEGORIA" (DESCRIPCION) VALUES ('20 Metros');
INSERT INTO "IGNACIO"."CATEGORIA" (DESCRIPCION) VALUES ('30 Metros');
INSERT INTO "IGNACIO"."CATEGORIA" (DESCRIPCION) VALUES ('40 Metros');

CREATE TABLE atleta (
    id_atleta NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
    nombre VARCHAR2(50),
    apellido VARCHAR2(50),
    fecha_nacimiento DATE,
    nacionalidad VARCHAR2(50),
    CONSTRAINT atleta_pk PRIMARY KEY (id_atleta)
);


INSERT INTO "IGNACIO"."ATLETA" (NOMBRE, APELLIDO, FECHA_NACIMIENTO, NACIONALIDAD) VALUES ('Ignacio', 'Ortiz', TO_DATE('1998-04-24 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Chilena');
INSERT INTO "IGNACIO"."ATLETA" (NOMBRE, APELLIDO, FECHA_NACIMIENTO, NACIONALIDAD) VALUES ('Chris', 'Cromer', TO_DATE('1998-05-22 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Chilena');
INSERT INTO "IGNACIO"."ATLETA" (NOMBRE, APELLIDO, FECHA_NACIMIENTO, NACIONALIDAD) VALUES ('Benjamin', 'Perez', TO_DATE('1992-01-28 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Argentina');
INSERT INTO "IGNACIO"."ATLETA" (NOMBRE, APELLIDO, FECHA_NACIMIENTO, NACIONALIDAD) VALUES ('Diego', 'Perez', TO_DATE('1983-12-24 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Peruana');

CREATE TABLE pais(
    id_pais NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
    nombre VARCHAR(50),
    CONSTRAINT pais_pk PRIMARY KEY (id_pais)
);

INSERT INTO "IGNACIO"."PAIS" (NOMBRE) VALUES ('Chile');
INSERT INTO "IGNACIO"."PAIS" (NOMBRE) VALUES ('Peru');
INSERT INTO "IGNACIO"."PAIS" (NOMBRE) VALUES ('Argentina');
INSERT INTO "IGNACIO"."PAIS" (NOMBRE) VALUES ('Brazil');
INSERT INTO "IGNACIO"."PAIS" (NOMBRE) VALUES ('Berlin');
INSERT INTO "IGNACIO"."PAIS" (NOMBRE) VALUES ('Canada');
INSERT INTO "IGNACIO"."PAIS" (NOMBRE) VALUES ('Republica Checa');


CREATE TABLE tipos_deportes(
    id_tipo NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
    descripcion VARCHAR(50),
    CONSTRAINT tipo_pk PRIMARY KEY (id_tipo)
);

INSERT INTO "IGNACIO"."TIPOS_DEPORTES" (DESCRIPCION) VALUES ('Natacion');
INSERT INTO "IGNACIO"."TIPOS_DEPORTES" (DESCRIPCION) VALUES ('Carrera');
INSERT INTO "IGNACIO"."TIPOS_DEPORTES" (DESCRIPCION) VALUES ('Arqueria');
INSERT INTO "IGNACIO"."TIPOS_DEPORTES" (DESCRIPCION) VALUES ('Basketball');
INSERT INTO "IGNACIO"."TIPOS_DEPORTES" (DESCRIPCION) VALUES ('BMX');
INSERT INTO "IGNACIO"."TIPOS_DEPORTES" (DESCRIPCION) VALUES ('Boxeo');
INSERT INTO "IGNACIO"."TIPOS_DEPORTES" (DESCRIPCION) VALUES ('Football');
INSERT INTO "IGNACIO"."TIPOS_DEPORTES" (DESCRIPCION) VALUES ('Curling');
INSERT INTO "IGNACIO"."TIPOS_DEPORTES" (DESCRIPCION) VALUES ('Rugby');
INSERT INTO "IGNACIO"."TIPOS_DEPORTES" (DESCRIPCION) VALUES ('Disparo');

CREATE TABLE ciudad(
    id_ciudad NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
    nombre VARCHAR(50),
    pais NUMBER,
    CONSTRAINT ciudad_pk PRIMARY KEY (id_ciudad),
    CONSTRAINT ciudad_pais_fk FOREIGN KEY (pais) REFERENCES pais(id_pais)
);

INSERT INTO "IGNACIO"."CIUDAD" (NOMBRE, PAIS) VALUES ('Tome', '1');
INSERT INTO "IGNACIO"."CIUDAD" (NOMBRE, PAIS) VALUES ('Concepcion', '1');
INSERT INTO "IGNACIO"."CIUDAD" (NOMBRE, PAIS) VALUES ('Checa', '2');
INSERT INTO "IGNACIO"."CIUDAD" (NOMBRE, PAIS) VALUES ('Roma', '3');
INSERT INTO "IGNACIO"."CIUDAD" (NOMBRE, PAIS) VALUES ('Santiago de Compostela', '4');
INSERT INTO "IGNACIO"."CIUDAD" (NOMBRE, PAIS) VALUES ('Galicia', '5');
INSERT INTO "IGNACIO"."CIUDAD" (NOMBRE, PAIS) VALUES ('Costa Da Morte', '6');
INSERT INTO "IGNACIO"."CIUDAD" (NOMBRE, PAIS) VALUES ('Iquique', '6');
INSERT INTO "IGNACIO"."CIUDAD" (NOMBRE, PAIS) VALUES ('Orzan', '4');
INSERT INTO "IGNACIO"."CIUDAD" (NOMBRE, PAIS) VALUES ('Riazor', '3');

CREATE TABLE lugar (
    id_lugar NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
    nombre VARCHAR2(50),
    capacidad NUMBER,
    ciudad NUMBER,
    CONSTRAINT lugar_pk PRIMARY KEY (id_lugar),
    CONSTRAINT lugar_ciudad_fk FOREIGN KEY (ciudad) REFERENCES ciudad(id_ciudad)
);

INSERT INTO "IGNACIO"."LUGAR" (NOMBRE, CAPACIDAD, CIUDAD) VALUES ('BXKQ', '100', '1');
INSERT INTO "IGNACIO"."LUGAR" (NOMBRE, CAPACIDAD, CIUDAD) VALUES ('TELLONES', '120', '2');
INSERT INTO "IGNACIO"."LUGAR" (NOMBRE, CAPACIDAD, CIUDAD) VALUES ('TRELLIG', '80', '3');
INSERT INTO "IGNACIO"."LUGAR" (NOMBRE, CAPACIDAD, CIUDAD) VALUES ('DIRAKZ', '250', '3');
INSERT INTO "IGNACIO"."LUGAR" (NOMBRE, CAPACIDAD, CIUDAD) VALUES ('ZERINID', '400', '5');
INSERT INTO "IGNACIO"."LUGAR" (NOMBRE, CAPACIDAD, CIUDAD) VALUES ('CHIX', '150', '6');

CREATE TABLE hotel(
    id_hotel NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
    nombre VARCHAR2(50),
    ciudad NUMBER,
    CONSTRAINT hotel_pk PRIMARY KEY (id_hotel),
    CONSTRAINT hotel_ciudad_fk FOREIGN KEY (ciudad) REFERENCES ciudad(id_ciudad)
);

INSERT INTO "IGNACIO"."HOTEL" (NOMBRE, CIUDAD) VALUES ('SILENT', '1');
INSERT INTO "IGNACIO"."HOTEL" (NOMBRE, CIUDAD) VALUES ('ZRKAZ', '2');
INSERT INTO "IGNACIO"."HOTEL" (NOMBRE, CIUDAD) VALUES ('JBL', '3');
INSERT INTO "IGNACIO"."HOTEL" (NOMBRE, CIUDAD) VALUES ('KIZIP', '3');
INSERT INTO "IGNACIO"."HOTEL" (NOMBRE, CIUDAD) VALUES ('KIROTWE', '4');
INSERT INTO "IGNACIO"."HOTEL" (NOMBRE, CIUDAD) VALUES ('HILL', '5');
INSERT INTO "IGNACIO"."HOTEL" (NOMBRE, CIUDAD) VALUES ('RESIDENT', '6');
INSERT INTO "IGNACIO"."HOTEL" (NOMBRE, CIUDAD) VALUES ('ZERO', '1');

CREATE TABLE capital(
    id_pais NUMBER,
    id_ciudad NUMBER,
    CONSTRAINT capital_pk PRIMARY KEY (id_pais, id_ciudad),
    CONSTRAINT capital_pais_fk FOREIGN KEY (id_pais) REFERENCES pais(id_pais),
    CONSTRAINT capital_ciudad_fk FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad)
);

INSERT INTO "IGNACIO"."CAPITAL" (ID_PAIS, ID_CIUDAD) VALUES ('1', '1');
INSERT INTO "IGNACIO"."CAPITAL" (ID_PAIS, ID_CIUDAD) VALUES ('1', '2');
INSERT INTO "IGNACIO"."CAPITAL" (ID_PAIS, ID_CIUDAD) VALUES ('2', '3');
INSERT INTO "IGNACIO"."CAPITAL" (ID_PAIS, ID_CIUDAD) VALUES ('3', '4');
INSERT INTO "IGNACIO"."CAPITAL" (ID_PAIS, ID_CIUDAD) VALUES ('4', '5');
INSERT INTO "IGNACIO"."CAPITAL" (ID_PAIS, ID_CIUDAD) VALUES ('4', '6');
INSERT INTO "IGNACIO"."CAPITAL" (ID_PAIS, ID_CIUDAD) VALUES ('4', '7');
INSERT INTO "IGNACIO"."CAPITAL" (ID_PAIS, ID_CIUDAD) VALUES ('5', '8');
INSERT INTO "IGNACIO"."CAPITAL" (ID_PAIS, ID_CIUDAD) VALUES ('6', '9');

CREATE TABLE delegacion(
    id_delegacion NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
    nombre VARCHAR2(50),
    cantidad_atletas NUMBER,
    pais NUMBER,
    atleta NUMBER,
    CONSTRAINT delegacion_pk PRIMARY KEY (id_delegacion),
    CONSTRAINT delegacion_pais_fk FOREIGN KEY (pais) REFERENCES pais(id_pais),
    CONSTRAINT delegacion_atleta_fk FOREIGN KEY (atleta) REFERENCES atleta(id_atleta)
);

INSERT INTO "IGNACIO"."DELEGACION" (NOMBRE, CANTIDAD_ATLETAS, PAIS, ATLETA) VALUES ('SAMSU', '2', '1', '1');
INSERT INTO "IGNACIO"."DELEGACION" (NOMBRE, CANTIDAD_ATLETAS, PAIS, ATLETA) VALUES ('SUX', '3', '2', '2');
INSERT INTO "IGNACIO"."DELEGACION" (NOMBRE, CANTIDAD_ATLETAS, PAIS, ATLETA) VALUES ('SKT1', '4', '3', '3');
INSERT INTO "IGNACIO"."DELEGACION" (NOMBRE, CANTIDAD_ATLETAS, PAIS, ATLETA) VALUES ('SUPREME', '2', '4', '4');

CREATE TABLE competencia(
    id_competencia NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
    nombre VARCHAR2(50),
    categoria NUMBER,
    tipo NUMBER,
    lugar NUMBER,
    CONSTRAINT competencia_pk PRIMARY KEY (id_competencia),
    CONSTRAINT competencia_categoria_fk FOREIGN KEY (categoria) REFERENCES categoria(id_categoria),
    CONSTRAINT competencia_tipo_fk FOREIGN KEY (tipo) REFERENCES tipos_deportes(id_tipo),
    CONSTRAINT competencia_lugar_fk FOREIGN KEY (lugar) REFERENCES lugar(id_lugar)
);


INSERT INTO "IGNACIO"."COMPETENCIA" (NOMBRE, CATEGORIA, TIPO, LUGAR) VALUES ('Natacion', '1', '1', '1');
INSERT INTO "IGNACIO"."COMPETENCIA" (NOMBRE, CATEGORIA, TIPO, LUGAR) VALUES ('Natacion', '1', '1', '2');
INSERT INTO "IGNACIO"."COMPETENCIA" (NOMBRE, CATEGORIA, TIPO, LUGAR) VALUES ('Natacion', '1', '1', '3');
INSERT INTO "IGNACIO"."COMPETENCIA" (NOMBRE, CATEGORIA, TIPO, LUGAR) VALUES ('Natacion', '1', '1', '4');
INSERT INTO "IGNACIO"."COMPETENCIA" (NOMBRE, CATEGORIA, TIPO, LUGAR) VALUES ('Natacion', '1', '1', '5');
INSERT INTO "IGNACIO"."COMPETENCIA" (NOMBRE, CATEGORIA, TIPO, LUGAR) VALUES ('Natacion', '1', '1', '6');
INSERT INTO "IGNACIO"."COMPETENCIA" (NOMBRE, CATEGORIA, TIPO, LUGAR) VALUES ('Carrera', '4', '2', '1');
INSERT INTO "IGNACIO"."COMPETENCIA" (NOMBRE, CATEGORIA, TIPO, LUGAR) VALUES ('Carrera', '4', '3', '2');
INSERT INTO "IGNACIO"."COMPETENCIA" (NOMBRE, CATEGORIA, TIPO, LUGAR) VALUES ('Carrera', '4', '3', '1');
INSERT INTO "IGNACIO"."COMPETENCIA" (NOMBRE, CATEGORIA, TIPO, LUGAR) VALUES ('Carrera', '4', '1', '2');
INSERT INTO "IGNACIO"."COMPETENCIA" (NOMBRE, CATEGORIA, TIPO, LUGAR) VALUES ('Carrera', '4', '1', '3');
INSERT INTO "IGNACIO"."COMPETENCIA" (NOMBRE, CATEGORIA, TIPO, LUGAR) VALUES ('Carrera', '4', '2', '3');
INSERT INTO "IGNACIO"."COMPETENCIA" (NOMBRE, CATEGORIA, TIPO, LUGAR) VALUES ('Carrera', '4', '3', '5');

CREATE TABLE precompetencia(
    id_precompetencia NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
    fecha DATE,
    competencia NUMBER,
    lugar NUMBER,
    CONSTRAINT precompetencia_pk PRIMARY KEY (id_precompetencia),
    CONSTRAINT precompetencia_competencia_fk FOREIGN KEY (competencia) REFERENCES competencia(id_competencia),
    CONSTRAINT precompetencia_lugar_fk FOREIGN KEY (lugar) REFERENCES lugar(id_lugar)
);

INSERT INTO "IGNACIO"."PRECOMPETENCIA" (FECHA, COMPETENCIA, LUGAR) VALUES (TO_DATE('2020-06-06 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '1', '1');
INSERT INTO "IGNACIO"."PRECOMPETENCIA" (FECHA, COMPETENCIA, LUGAR) VALUES (TO_DATE('2020-06-12 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '1', '2');
INSERT INTO "IGNACIO"."PRECOMPETENCIA" (FECHA, COMPETENCIA, LUGAR) VALUES (TO_DATE('2020-07-25 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '1', '3');
INSERT INTO "IGNACIO"."PRECOMPETENCIA" (FECHA, COMPETENCIA, LUGAR) VALUES (TO_DATE('2020-06-06 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '2', '1');
INSERT INTO "IGNACIO"."PRECOMPETENCIA" (FECHA, COMPETENCIA, LUGAR) VALUES (TO_DATE('2020-07-25 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '2', '2');
INSERT INTO "IGNACIO"."PRECOMPETENCIA" (FECHA, COMPETENCIA, LUGAR) VALUES (TO_DATE('2020-08-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '2', '3');
INSERT INTO "IGNACIO"."PRECOMPETENCIA" (FECHA, COMPETENCIA, LUGAR) VALUES (TO_DATE('2020-09-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '3', '1');
INSERT INTO "IGNACIO"."PRECOMPETENCIA" (FECHA, COMPETENCIA, LUGAR) VALUES (TO_DATE('2020-10-28 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '4', '2');

CREATE TABLE hospedar(
    id_hotel NUMBER,
    id_delegacion NUMBER,
    fecha_inicio DATE,
    fecha_fin DATE,
    precio NUMBER,
    CONSTRAINT hospedar_pk PRIMARY KEY (id_hotel, id_delegacion),
    CONSTRAINT hospedar_hotel_fk FOREIGN KEY (id_hotel) REFERENCES hotel(id_hotel),
    CONSTRAINT hospedar_delegacion_fk FOREIGN KEY (id_delegacion) REFERENCES delegacion(id_delegacion)
);

INSERT INTO "IGNACIO"."HOSPEDAR" (ID_HOTEL, ID_DELEGACION, FECHA_INICIO, FECHA_FIN, PRECIO) VALUES ('1', '9', TO_DATE('2020-05-21 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-05-25 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '1500000');
INSERT INTO "IGNACIO"."HOSPEDAR" (ID_HOTEL, ID_DELEGACION, FECHA_INICIO, FECHA_FIN, PRECIO) VALUES ('1', '6', TO_DATE('2020-05-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-06-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '350000');
INSERT INTO "IGNACIO"."HOSPEDAR" (ID_HOTEL, ID_DELEGACION, FECHA_INICIO, FECHA_FIN, PRECIO) VALUES ('2', '7', TO_DATE('2020-05-08 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-05-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '280000');
INSERT INTO "IGNACIO"."HOSPEDAR" (ID_HOTEL, ID_DELEGACION, FECHA_INICIO, FECHA_FIN, PRECIO) VALUES ('3', '7', TO_DATE('2020-06-09 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-06-12 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '168000');
INSERT INTO "IGNACIO"."HOSPEDAR" (ID_HOTEL, ID_DELEGACION, FECHA_INICIO, FECHA_FIN, PRECIO) VALUES ('4', '8', TO_DATE('2020-09-12 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-10-15 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '178000');
INSERT INTO "IGNACIO"."HOSPEDAR" (ID_HOTEL, ID_DELEGACION, FECHA_INICIO, FECHA_FIN, PRECIO) VALUES ('5', '9', TO_DATE('2020-10-13 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-10-18 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '189000');

CREATE TABLE ganar(
    id_atleta NUMBER,
    id_competencia NUMBER,
    id_medalla NUMBER,
    fecha DATE,
    puntaje NUMBER,
    CONSTRAINT ganar_pk PRIMARY KEY (id_atleta, id_competencia, id_medalla),
    CONSTRAINT ganar_atleta_fk FOREIGN KEY (id_atleta) REFERENCES atleta(id_atleta),
    CONSTRAINT ganar_competencia_fk FOREIGN KEY (id_competencia) REFERENCES competencia(id_competencia),
    CONSTRAINT ganar_medalla_fk FOREIGN KEY (id_medalla) REFERENCES medalla(id_medalla)
);

no permite que la misma persona en la misma competencia y quede en el mismo lugar en diferente año

INSERT INTO "IGNACIO"."GANAR" (ID_ATLETA, ID_COMPETENCIA, ID_MEDALLA, FECHA, PUNTAJE) VALUES ('1', '1', '3', TO_DATE('2019-05-25 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '70');
INSERT INTO "IGNACIO"."GANAR" (ID_ATLETA, ID_COMPETENCIA, ID_MEDALLA, FECHA, PUNTAJE) VALUES ('1', '1', '1', TO_DATE('2020-05-25 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '99');
INSERT INTO "IGNACIO"."GANAR" (ID_ATLETA, ID_COMPETENCIA, ID_MEDALLA, FECHA, PUNTAJE) VALUES ('2', '2', '1', TO_DATE('2019-06-25 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '100');
INSERT INTO "IGNACIO"."GANAR" (ID_ATLETA, ID_COMPETENCIA, ID_MEDALLA, FECHA, PUNTAJE) VALUES ('3', '1', '2', TO_DATE('2019-05-25 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '78');
INSERT INTO "IGNACIO"."GANAR" (ID_ATLETA, ID_COMPETENCIA, ID_MEDALLA, FECHA, PUNTAJE) VALUES ('3', '1', '3', TO_DATE('2020-05-25 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), '89');

CREATE TABLE participar_competencia(
    id_competencia NUMBER,
    id_atleta NUMBER,
    fecha DATE,
    CONSTRAINT participar_competencia_pk PRIMARY KEY (id_competencia, id_atleta),
    CONSTRAINT participar_competencia_competencia_fk FOREIGN KEY (id_competencia) REFERENCES competencia(id_competencia),
    CONSTRAINT participar_competencia_atleta_fk FOREIGN KEY (id_atleta) REFERENCES atleta(id_atleta)
);

INSERT INTO "IGNACIO"."PARTICIPAR_PRECOMPETENCIA" (ID_PRECOMPETENCIA, ID_ATLETA, PUNTAJE, FECHA) VALUES ('1', '1', '70', TO_DATE('2020-05-25 00:00:00', 'YYYY-MM-DD HH24:MI:SS'))
INSERT INTO "IGNACIO"."PARTICIPAR_PRECOMPETENCIA" (ID_PRECOMPETENCIA, ID_ATLETA, PUNTAJE, FECHA) VALUES ('1', '2', '75', TO_DATE('2020-05-25 00:00:00', 'YYYY-MM-DD HH24:MI:SS'))
INSERT INTO "IGNACIO"."PARTICIPAR_PRECOMPETENCIA" (ID_PRECOMPETENCIA, ID_ATLETA, PUNTAJE, FECHA) VALUES ('1', '3', '80', TO_DATE('2020-05-25 00:00:00', 'YYYY-MM-DD HH24:MI:SS'))
INSERT INTO "IGNACIO"."PARTICIPAR_PRECOMPETENCIA" (ID_PRECOMPETENCIA, ID_ATLETA, PUNTAJE, FECHA) VALUES ('2', '1', '25', TO_DATE('2020-06-26 00:00:00', 'YYYY-MM-DD HH24:MI:SS'))
INSERT INTO "IGNACIO"."PARTICIPAR_PRECOMPETENCIA" (ID_PRECOMPETENCIA, ID_ATLETA, PUNTAJE, FECHA) VALUES ('3', '2', '100', TO_DATE('2020-06-27 00:00:00', 'YYYY-MM-DD HH24:MI:SS'))

CREATE TABLE participar_competencia(
    id_competencia NUMBER,
    id_atleta NUMBER,
    fecha DATE,
    CONSTRAINT participar_competencia_pk PRIMARY KEY (id_competencia, id_atleta),
    CONSTRAINT participar_competencia_competencia_fk FOREIGN KEY (id_competencia) REFERENCES competencia(id_competencia),
    CONSTRAINT participar_competencia_atleta_fk FOREIGN KEY (id_atleta) REFERENCES atleta(id_atleta)
);

INSERT INTO "IGNACIO"."PARTICIPAR_COMPETENCIA" (ID_COMPETENCIA, ID_ATLETA, FECHA) VALUES ('1', '1', TO_DATE('2020-06-06 00:00:00', 'YYYY-MM-DD HH24:MI:SS'))
INSERT INTO "IGNACIO"."PARTICIPAR_COMPETENCIA" (ID_COMPETENCIA, ID_ATLETA, FECHA) VALUES ('1', '2', TO_DATE('2020-06-06 00:00:00', 'YYYY-MM-DD HH24:MI:SS'))
INSERT INTO "IGNACIO"."PARTICIPAR_COMPETENCIA" (ID_COMPETENCIA, ID_ATLETA, FECHA) VALUES ('1', '3', TO_DATE('2020-06-06 00:00:00', 'YYYY-MM-DD HH24:MI:SS'))
INSERT INTO "IGNACIO"."PARTICIPAR_COMPETENCIA" (ID_COMPETENCIA, ID_ATLETA, FECHA) VALUES ('2', '1', TO_DATE('2020-07-08 00:00:00', 'YYYY-MM-DD HH24:MI:SS'))
INSERT INTO "IGNACIO"."PARTICIPAR_COMPETENCIA" (ID_COMPETENCIA, ID_ATLETA, FECHA) VALUES ('3', '2', TO_DATE('2020-07-09 00:00:00', 'YYYY-MM-DD HH24:MI:SS'))
