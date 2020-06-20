CREATE TABLE medalla(
    id_medalla NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
    descripcion VARCHAR2(50),
    CONSTRAINT medalla_pk PRIMARY KEY (id_medalla)
);

CREATE TABLE categoria(
    id_categoria NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
    descripcion VARCHAR(50),
    CONSTRAINT categoria_pk PRIMARY KEY (id_categoria)
);

CREATE TABLE atleta (
    id_atleta NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
    nombre VARCHAR2(50),
    apellido VARCHAR2(50),
    fecha_nacimiento DATE,
    nacionalidad VARCHAR2(50),
    CONSTRAINT atleta_pk PRIMARY KEY (id_atleta)
);

CREATE TABLE pais(
    id_pais NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
    nombre VARCHAR(50),
    CONSTRAINT pais_pk PRIMARY KEY (id_pais)
);

CREATE TABLE tipos_deportes(
    id_tipo NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
    descripcion VARCHAR(50),
    CONSTRAINT tipo_pk PRIMARY KEY (id_tipo)
);

CREATE TABLE ciudad (
    id_ciudad NUMBER,
    nombre VARCHAR(50),
    pais NUMBER,
    CONSTRAINT ciudad_pk PRIMARY KEY (id_ciudad),
    CONSTRAINT ciudad_pais_fk FOREIGN KEY (pais) REFERENCES pais(id_pais)
);

CREATE TABLE lugar (
    id_lugar NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
    nombre VARCHAR2(50),
    capacidad NUMBER,
    ciudad NUMBER,
    CONSTRAINT lugar_pk PRIMARY KEY (id_lugar),
    CONSTRAINT lugar_ciudad_fk FOREIGN KEY (ciudad) REFERENCES ciudad(id_ciudad)
);

CREATE TABLE hotel(
    id_hotel NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
    nombre VARCHAR2(50),
    ciudad NUMBER,
    CONSTRAINT hotel_pk PRIMARY KEY (id_hotel),
    CONSTRAINT hotel_ciudad_fk FOREIGN KEY (ciudad) REFERENCES ciudad(id_ciudad)
);

CREATE TABLE capital(
    id_pais NUMBER,
    id_ciudad NUMBER,
    CONSTRAINT capital_pk PRIMARY KEY (id_pais, id_ciudad),
    CONSTRAINT capital_pais_fk FOREIGN KEY (id_pais) REFERENCES pais(id_pais),
    CONSTRAINT capital_ciudad_fk FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad)
);


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

CREATE TABLE precompetencia(
    id_precompetencia NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
    fecha DATE,
    competencia NUMBER,
    lugar NUMBER,
    CONSTRAINT precompetencia_pk PRIMARY KEY (id_precompetencia),
    CONSTRAINT precompetencia_competencia_fk FOREIGN KEY (competencia) REFERENCES competencia(id_competencia),
    CONSTRAINT precompetencia_lugar_fk FOREIGN KEY (lugar) REFERENCES lugar(id_lugar)
);

CREATE TABLE hospedar(
    id_hotel NUMBER,
    id_delegacion NUMBER,
    fecha_inicio DATE,
    fecha_fin DATE,
    precio_delegacion NUMBER,
    precio_atleta NUMBER,
    CONSTRAINT hospedar_hotel_fk FOREIGN KEY (id_hotel) REFERENCES hotel(id_hotel),
    CONSTRAINT hospedar_delegacion_fk FOREIGN KEY (id_delegacion) REFERENCES delegacion(id_delegacion)
);

CREATE TABLE ganar(
    id_atleta NUMBER,
    id_competencia NUMBER,
    id_medalla NUMBER,
    fecha DATE,
    puntaje NUMBER,
    CONSTRAINT ganar_atleta_fk FOREIGN KEY (id_atleta) REFERENCES atleta(id_atleta),
    CONSTRAINT ganar_competencia_fk FOREIGN KEY (id_competencia) REFERENCES competencia(id_competencia),
    CONSTRAINT ganar_medalla_fk FOREIGN KEY (id_medalla) REFERENCES medalla(id_medalla)
);

CREATE TABLE participar_competencia(
    id_competencia NUMBER,
    id_atleta NUMBER,
    fecha DATE,
    CONSTRAINT participar_competencia_competencia_fk FOREIGN KEY (id_competencia) REFERENCES competencia(id_competencia),
    CONSTRAINT participar_competencia_atleta_fk FOREIGN KEY (id_atleta) REFERENCES atleta(id_atleta)
);

CREATE TABLE participar_precompetencia(
    id_precompetencia NUMBER,
    id_atleta NUMBER,
    puntaje NUMBER,
    fecha DATE,
    CONSTRAINT participar_precompetencia_precompetencia_fk FOREIGN KEY (id_precompetencia) REFERENCES precompetencia(id_precompetencia),
    CONSTRAINT participar_precompetencia_atleta_fk FOREIGN KEY (id_atleta) REFERENCES atleta(id_atleta)
);
