-- Trigger 3
INSERT INTO CIUDAD (NOMBRE, PAIS) VALUES ('Quelite', 1);

INSERT INTO CIUDAD (NOMBRE, PAIS) VALUES ('Convien', 1);

INSERT INTO CIUDAD (NOMBRE, PAIS) VALUES ('Wingsi', 2);

INSERT INTO CIUDAD (ID_CIUDAD, NOMBRE, PAIS) VALUES (20, 'Dailys', 2);

-- Trigger 4
INSERT INTO PARTICIPAR_COMPETENCIA (ID_COMPETENCIA, ID_ATLETA, FECHA) VALUES (1, 5, TO_DATE('2020-07-09 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO PARTICIPAR_PRECOMPETENCIA (ID_PRECOMPETENCIA, ID_ATLETA, PUNTAJE, FECHA) VALUES (1, 5, 20, TO_DATE('2020-05-25 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO PARTICIPAR_COMPETENCIA (ID_COMPETENCIA, ID_ATLETA, FECHA) VALUES (1, 5, TO_DATE('2020-07-09 00:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- Trigger 5
INSERT INTO HOSPEDAR (ID_HOTEL, ID_DELEGACION, FECHA_INICIO, FECHA_FIN, PRECIO_DELEGACION, PRECIO_ATLETA) VALUES (1, 1, TO_DATE('2020-07-09 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2020-07-12 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 5, 50000);

UPDATE HOSPEDAR SET PRECIO_DELEGACION = 5 WHERE (ID_HOTEL = 1 AND ID_DELEGACION = 1 AND FECHA_INICIO = '2020-07-09 00:00:00');

UPDATE HOSPEDAR SET PRECIO_ATLETA = 50000 WHERE (ID_HOTEL = 1 AND ID_DELEGACION = 1 AND FECHA_INICIO = '2020-07-09 00:00:00');
