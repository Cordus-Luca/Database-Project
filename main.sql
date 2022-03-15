
CREATE TABLE restaurant (
    cod_restaurant   NUMBER(5)
        CONSTRAINT pk_res PRIMARY KEY,
    nume_restaurant  VARCHAR2(50) UNIQUE,
    numar_angajati   NUMBER(5),
    cod_locatie      NUMBER(5) NOT NULL,
    cod_depozit      NUMBER(5) NOT NULL
);

CREATE TABLE client (
    cod_client   NUMBER(5)
        CONSTRAINT pk_cli PRIMARY KEY,
    nume         VARCHAR2(50),
    prenume      VARCHAR(50),
    telefon      NUMBER(11),
    data         DATE,
    cod_comanda  NUMBER(5) NOT NULL
);

CREATE TABLE comanda (
    cod_comanda  NUMBER(5)
        CONSTRAINT pk_com PRIMARY KEY,
    pret         NUMBER(5),
    cod_meniu    NUMBER(5) NOT NULL
);

CREATE TABLE meniu (
    cod_meniu       NUMBER(5)
        CONSTRAINT pk_men PRIMARY KEY,
    cod_restaurant  NUMBER(5)
);

CREATE TABLE joburi (
    cod_job    NUMBER(5)
        CONSTRAINT pk_job PRIMARY KEY,
    job_title  VARCHAR2(50),
    salariu    NUMBER(15)
);

CREATE TABLE angajat (
    cod_ang         NUMBER(5)
        CONSTRAINT pk_ang PRIMARY KEY,
    nume            VARCHAR2(50),
    prenume         VARCHAR2(50),
    email           VARCHAR2(50),
    numar_telefon   VARCHAR2(50),
    cod_job         NUMBER(5),
    cod_restaurant  NUMBER(5)
);

CREATE TABLE locatii (
    cod_locatie  NUMBER(5)
        CONSTRAINT pk_loc PRIMARY KEY,
    adresa       VARCHAR2(50),
    cod_postal   NUMBER(7),
    cod_tara     NUMBER(5)
);

CREATE TABLE tari (
    cod_tara     NUMBER(5)
        CONSTRAINT pk_tar PRIMARY KEY,
    nume_tara    VARCHAR2(50),
    populatie    NUMBER(10),
    cod_regiune  NUMBER(5)
);

CREATE TABLE regiuni (
    cod_regiune   NUMBER(5)
        CONSTRAINT pk_reg PRIMARY KEY,
    nume_regiune  VARCHAR2(50)
);

CREATE TABLE furnizori (
    cod_furnizor   NUMBER(5)
        CONSTRAINT pk_fur PRIMARY KEY,
    nume_furnizor  VARCHAR2(50),
    tip_produs     VARCHAR2(50)
);

CREATE TABLE depozite (
    cod_depozit   NUMBER(5)
        CONSTRAINT pk_dep PRIMARY KEY,
    nume_depozit  VARCHAR2(50),
    dimensiune    NUMBER(5),
    cod_locatie   NUMBER(5),
    cod_furnizor  NUMBER(5)
);

CREATE TABLE transporta (
    cod_furnizor   NUMBER(5)
        REFERENCES furnizori ( cod_furnizor ),
    cod_depozit    NUMBER(5)
        REFERENCES depozite ( cod_depozit ),
    tip_transport  VARCHAR2(50)
);

CREATE TABLE atasate_la (
    cod_restaurant  NUMBER(5)
        REFERENCES restaurant ( cod_restaurant ),
    cod_depozit     NUMBER(5)
        REFERENCES depozite ( cod_depozit ),
    tip_atasament   VARCHAR2(50)
);

ALTER TABLE client
    ADD CONSTRAINT fk_cli_com FOREIGN KEY ( cod_comanda )
        REFERENCES comanda ( cod_comanda );

ALTER TABLE comanda
    ADD CONSTRAINT fk_com_men FOREIGN KEY ( cod_meniu )
        REFERENCES meniu ( cod_meniu );

ALTER TABLE meniu
    ADD CONSTRAINT fk_men_res FOREIGN KEY ( cod_restaurant )
        REFERENCES restaurant ( cod_restaurant );

ALTER TABLE restaurant
    ADD CONSTRAINT fk_res_loc FOREIGN KEY ( cod_locatie )
        REFERENCES locatii ( cod_locatie );

ALTER TABLE restaurant
    ADD CONSTRAINT fk_res_dep FOREIGN KEY ( cod_depozit )
        REFERENCES depozite ( cod_depozit );

ALTER TABLE angajat
    ADD CONSTRAINT fk_ang_job FOREIGN KEY ( cod_job )
        REFERENCES joburi ( cod_job );

ALTER TABLE angajat
    ADD CONSTRAINT fk_ang_res FOREIGN KEY ( cod_restaurant )
        REFERENCES restaurant ( cod_restaurant );

ALTER TABLE depozite
    ADD CONSTRAINT fk_dep_fur FOREIGN KEY ( cod_furnizor )
        REFERENCES furnizori ( cod_furnizor );

ALTER TABLE depozite
    ADD CONSTRAINT fk_dep_loc FOREIGN KEY ( cod_locatie )
        REFERENCES locatii ( cod_locatie );

ALTER TABLE locatii
    ADD CONSTRAINT fk_loc_tar FOREIGN KEY ( cod_tara )
        REFERENCES tari ( cod_tara );

ALTER TABLE tari
    ADD CONSTRAINT fk_tar_reg FOREIGN KEY ( cod_regiune )
        REFERENCES regiuni ( cod_regiune );

ALTER TABLE transporta ADD CONSTRAINT pk_tra PRIMARY KEY ( cod_furnizor,
                                                           cod_depozit );

ALTER TABLE atasate_la ADD CONSTRAINT pk_ata PRIMARY KEY ( cod_restaurant,
                                                           cod_depozit );

INSERT INTO joburi VALUES (1, 'OSPATAR', 1500);
INSERT INTO joburi VALUES (2, 'JANITOR', 1600);
INSERT INTO joburi VALUES (3, 'CASIER', 1700);
INSERT INTO joburi VALUES (4, 'MANAGER', 1900);
INSERT INTO joburi VALUES (5, 'CHEF', 3500);
INSERT INTO joburi VALUES (6, 'SEF', 4500);
SELECT * FROM joburi;

INSERT INTO regiuni VALUES (10, 'Europa');
INSERT INTO regiuni VALUES (11, 'Asia');
INSERT INTO regiuni VALUES (12, 'Australia');
INSERT INTO regiuni VALUES (13, 'America de Nord');
INSERT INTO regiuni VALUES (14, 'America de Sud');
SELECT * FROM regiuni;

INSERT INTO tari VALUES (20, 'Romania', 18000, 10);
INSERT INTO tari VALUES (21, 'China', 19000, 11);
INSERT INTO tari VALUES (22, 'SUA', 10000, 13);
INSERT INTO tari VALUES (23, 'Argentina', 20000, 14);
INSERT INTO tari VALUES (24, 'Mexic', 25000, 14);
SELECT * FROM tari;

INSERT INTO locatii VALUES (30, 'Suceava', 300, 20);
INSERT INTO locatii VALUES (31, 'Bucuresti', 310, 20);
INSERT INTO locatii VALUES (32, 'Beijing', 320, 21);
INSERT INTO locatii VALUES (33, 'New York', 330, 22);
INSERT INTO locatii VALUES (34, 'Los Angeles', 340, 22);
INSERT INTO locatii (cod_locatie, adresa, cod_tara) VALUES (35, 'Bucuresti', 22);
INSERT INTO locatii (cod_locatie, adresa, cod_tara) VALUES (36, 'Cluj', 20);
INSERT INTO locatii (cod_locatie, adresa, cod_tara) VALUES (37, 'Targoviste', 20);
SELECT * FROM locatii;

INSERT INTO furnizori VALUES (40,'FUR_UNU','Lactate');
INSERT INTO furnizori VALUES (41,'FUR_DOI','Mezeluri');
INSERT INTO furnizori VALUES (42,'FUR_TREI','Cereale');
INSERT INTO furnizori VALUES (43,'FUR_PATRU','Mezeluri');
INSERT INTO furnizori VALUES (44,'FUR_CINCI','Condimente');
SELECT * FROM furnizori;

INSERT INTO depozite VALUES (50,'DEP_UNU',500,30,40);
INSERT INTO depozite VALUES (51,'DEP_DOI',510,31,41);
INSERT INTO depozite VALUES (52,'DEP_TREI',520,33,43);
INSERT INTO depozite VALUES (53,'DEP_PATRU',530,34,44);
INSERT INTO depozite VALUES (54,'DEP_CINCI',540,32,42);
INSERT INTO depozite VALUES (55,'DEP_SASE',500,30,40);
INSERT INTO depozite VALUES (56,'DEP_SAPTE',510,31,41);
INSERT INTO depozite VALUES (57,'DEP_OPT',520,33,43);
INSERT INTO depozite VALUES (58,'DEP_NOUA',530,34,44);
INSERT INTO depozite VALUES (59,'DEP_ZECE',540,32,42);
SELECT * FROM depozite;

INSERT INTO restaurant VALUES (60,'RES_UNU',100,30,50);
INSERT INTO restaurant VALUES (61,'RES_DOI',120,31,51);
INSERT INTO restaurant VALUES (62,'RES_TREI',140,34,53);
INSERT INTO restaurant VALUES (63,'RES_PATRU',160,31,52);
INSERT INTO restaurant VALUES (64,'RES_CINCI',180,33,50);
SELECT * FROM restaurant;

INSERT INTO angajat VALUES (70,'Gigel','Popescu','gigelpopescu@gmail.com','0712349078',1,62);
INSERT INTO angajat VALUES (71,'Andrei','Andreiut','andreiandreiut@gmail.com','0772345678',2,60);
INSERT INTO angajat VALUES (72,'Alex','Ciocan','alexciocan@yahoo.com','0712348678',3,61);
INSERT INTO angajat VALUES (73,'Alexandra','Ciocan','alexandraciocan@yahoo.com','06712345678',4,64);
INSERT INTO angajat VALUES (74,'Stefan','Ciocan','stefanciocan@gmail.com','0754345678',5,63);
SELECT * FROM angajat;

INSERT INTO meniu VALUES (80,60);
INSERT INTO meniu VALUES (81,61);
INSERT INTO meniu VALUES (82,62);
INSERT INTO meniu VALUES (83,63);
INSERT INTO meniu VALUES (84,64);
SELECT * FROM meniu;

INSERT INTO comanda VALUES (90,50,80);
INSERT INTO comanda VALUES (91,60,80);
INSERT INTO comanda VALUES (92,150,81);
INSERT INTO comanda VALUES (93,250,82);
INSERT INTO comanda VALUES (94,40,83);
INSERT INTO comanda VALUES (95,40,84);
INSERT INTO comanda VALUES (96,50,84);
INSERT INTO comanda VALUES (97,80,84);
INSERT INTO comanda VALUES (98,90,84);
INSERT INTO comanda VALUES (99,10,84);
SELECT * FROM comanda;

UPDATE comanda SET pret = 200 WHERE cod_comanda = 99;
UPDATE comanda SET pret = 120 WHERE cod_comanda = 92;
UPDATE comanda SET pret = 90 WHERE cod_comanda = 97;

INSERT INTO client VALUES (100,'Gica','Petrica',0723145410,'23-MAR-2015',90);
INSERT INTO client VALUES (101,'Andrei','Petrica',0709435410,'19-DEC-2020',91);
INSERT INTO client VALUES (102,'Alex','Gica',0723835410,'23-MAR-2017',92);
INSERT INTO client VALUES (103,'Marcel','Ciocan',0723435410,'2-JUL-2019',93);
INSERT INTO client VALUES (104,'Stefania','Popescu',0723345410,'22-NOV-2016',94);
INSERT INTO client VALUES (105,'Max','Popa',0723725410,'12-MAY-2015',90);
INSERT INTO client VALUES (106,'Sabina','Ciuran',0723535410,'2-JAN-2019',93);
INSERT INTO client (cod_client,nume,prenume,data,cod_comanda) VALUES (107,'Alexandra','Gigi','10-JUL-2021',92);
INSERT INTO client (cod_client,nume,prenume,data,cod_comanda) VALUES (108,'Alex','Gigi','10-JUN-2021',93);
INSERT INTO client (cod_client,nume,prenume,data,cod_comanda) VALUES (109,'Popescu','Lenuta','16-DEC-2021',91);
SELECT * FROM client;

INSERT INTO transporta VALUES (40,50,'Autocar');
INSERT INTO transporta VALUES (41,51,'Autocar');
INSERT INTO transporta VALUES (43,52,'TIR');
INSERT INTO transporta VALUES (44,53,'TIR');
INSERT INTO transporta VALUES (42,54,'Camion');
INSERT INTO transporta VALUES (40,55,'Autocar');
INSERT INTO transporta VALUES (41,56,'Autocar');
INSERT INTO transporta VALUES (43,57,'TIR');
INSERT INTO transporta VALUES (44,58,'TIR');
INSERT INTO transporta VALUES (42,59,'Camion');
SELECT * FROM transporta;

INSERT INTO atasate_la VALUES (60, 50, 'Colaborare');
INSERT INTO atasate_la VALUES (60, 52, 'Colaborare');
INSERT INTO atasate_la VALUES (61, 51, 'Colaborare');
INSERT INTO atasate_la VALUES (61, 55, 'Colaborare');
INSERT INTO atasate_la VALUES (62, 52, 'Colaborare');
INSERT INTO atasate_la VALUES (62, 53, 'Parteneriat');
INSERT INTO atasate_la VALUES (63, 57, 'Parteneriat');
INSERT INTO atasate_la VALUES (63, 58, 'Parteneriat');
INSERT INTO atasate_la VALUES (64, 59, 'Parteneriat');
INSERT INTO atasate_la VALUES (64, 53, 'Parteneriat');
SELECT * FROM atasate_la;
COMMIT;

--13.
CREATE OR REPLACE PACKAGE PROIECT AS
    PROCEDURE LOC_RESTAURANTE (CodLocatie NUMBER);   --6.
    PROCEDURE Salariu_mai_mare (SalariuComp NUMBER); --7.
    FUNCTION SAL_MEDIU(numeRestaurant String)
        RETURN NUMBER;                               --8.
    PROCEDURE COD_J_REGIUNE (cod NUMBER);            --9.
END PROIECT;
    
CREATE OR REPLACE PACKAGE BODY PROIECT AS
--6. Afisati codurile si numarul de angajati al restaurantelor care se afla la locatia cu codul introdus in apel
PROCEDURE LOC_RESTAURANTE (CodLocatie NUMBER) AS
    TYPE colectieCOD IS TABLE OF NUMBER;
    TYPE colectieANG IS VARRAY(20) OF NUMBER;
    i INTEGER;
    coduri colectieCOD;
    ang colectieANG;
    COD_LOCATIE RESTAURANT.COD_LOCATIE%TYPE;
BEGIN
    SELECT COD_RESTAURANT
    BULK COLLECT INTO coduri
    FROM RESTAURANT
    WHERE COD_LOCATIE LIKE CodLocatie;
    SELECT NUMAR_ANGAJATI
    BULK COLLECT INTO ANG
    FROM RESTAURANT
    WHERE COD_LOCATIE LIKE CodLocatie;
    DBMS_OUTPUT.PUT('Coduri: ');
    FOR i IN coduri.FIRST..coduri.LAST LOOP
        DBMS_OUTPUT.PUT(coduri(i) || ' ');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT('Numar angajati: ');
    FOR i IN ang.FIRST..ang.LAST LOOP
        DBMS_OUTPUT.PUT(ang(i) || ' ');
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');
END;


--7. Afisati numele, prenumele, jobul si salariul persoanelor cu salariul mai mare decat cel apelat
PROCEDURE Salariu_mai_mare (SalariuComp NUMBER) AS
    CURSOR ang is
        SELECT a.NUME, a.PRENUME, j.JOB_TITLE, j.SALARIU
        FROM ANGAJAT a JOIN JOBURI j ON (a.COD_JOB = j.COD_JOB)
        WHERE j.SALARIU > SalariuComp;
    nume ANGAJAT.NUME%TYPE;
    prenume ANGAJAT.PRENUME%TYPE;
    j_titlu JOBURI.JOB_TITLE%TYPE;
    salariu JOBURI.SALARIU%TYPE;
    BEGIN
    DBMS_OUTPUT.PUT_LINE('Persoanele cu salariul mai mare decat ' || SalariuComp || ' sunt:');
        OPEN ang;
        LOOP
            FETCH ang into nume, prenume, j_titlu, salariu;
            EXIT WHEN ang%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(nume || ' ' || prenume || ' ' || j_titlu || ' ' || salariu);
        END LOOP;
        CLOSE ang;
    END;

--8. Afisati media salarilor de la restaurantul cu numele apelat
FUNCTION SAL_MEDIU(numeRestaurant String)
RETURN NUMBER IS
    MEDIE JOBURI.SALARIU%TYPE;
BEGIN
    SELECT COD_RESTAURANT
    INTO MEDIE
    FROM RESTAURANT
    WHERE NUME_RESTAURANT = numeRestaurant;
    
    SELECT AVG(SALARIU)
    INTO MEDIE
    FROM JOBURI j, ANGAJAT a, RESTAURANT r  
    WHERE r.NUME_RESTAURANT = numeRestaurant AND (a.COD_RESTAURANT = r.COD_RESTAURANT) AND (j.COD_JOB = a.COD_JOB);
    RETURN MEDIE;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20001,'Nu exista restaurante cu numele dat');
END;


--9. Afisati in ce regiune se afla angajatul cu codul de job dat.

PROCEDURE COD_J_REGIUNE (cod NUMBER) AS
    reg REGIUNI.NUME_REGIUNE%TYPE;
BEGIN
    SELECT r.NUME_REGIUNE
    INTO reg
    FROM REGIUNI r, TARI t, LOCATII l, RESTAURANT re, ANGAJAT a
    WHERE   a.COD_JOB = cod
    AND a.COD_RESTAURANT = re.COD_RESTAURANT
    AND re.COD_LOCATIE = l.COD_LOCATIE
    AND l.COD_TARA = t.COD_TARA
    AND t.COD_REGIUNE = r.COD_REGIUNE;
    DBMS_OUTPUT.PUT_LINE('Angajatul cu codul de job ' || cod || ' se afla in regiunea ' || reg);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Nu exista angajati cu codul de job dat');
    WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20003, 'Exista mai multi angajati cu codul de job dat');
END;

END PROIECT;

set serveroutput on;
-- TESTARE 6
EXEC PROIECT.LOC_RESTAURANTE(31);

-- TESTARE 7
EXEC PROIECT.Salariu_mai_mare(1600);

-- TESTARE 8
BEGIN
    DBMS_OUTPUT.PUT_LINE(PROIECT.SAL_MEDIU('RES_UNU'));
END;

BEGIN
    DBMS_OUTPUT.PUT_LINE(PROIECT.SAL_MEDIU('test'));
END;

-- TESTARE 9
EXEC PROIECT.COD_J_REGIUNE (2);

-- INTRODUCERE FACUT PENTRU TEST EXCEPTIE TOO_MANY_ROWS
INSERT INTO ANGAJAT VALUES(75, 'TEST', 'EXCEPTIE', 'A@B', 0, 2, 61);
DELETE FROM ANGAJAT WHERE COD_ANG = 75;

-- TOO_MANY_ROWS
EXEC PROIECT.COD_J_REGIUNE (2);

-- NO_DATA_FOUND
EXEC PROIECT.COD_J_REGIUNE (10);

--10. Trigger de tip LMD la nivel de comanda
CREATE OR REPLACE PACKAGE PACK AS
    SAL_MIN JOBURI.SALARIU%type;
    SAL_MAX JOBURI.SALARIU%type;
END PACK;

CREATE OR REPLACE TRIGGER TRIG_1
BEFORE INSERT OR UPDATE OF SALARIU ON JOBURI
BEGIN
     SELECT MIN(SALARIU), MAX(SALARIU)
     INTO PACK.SAL_MIN, PACK.SAL_MAX
     FROM JOBURI;
END;

DROP TRIGGER TRIG_1;
--11. Trigger de tip LMD la nivel de linie
CREATE OR REPLACE TRIGGER TRIG_2
    BEFORE INSERT OR UPDATE ON JOBURI
    FOR EACH ROW
BEGIN
    IF (:NEW.SALARIU NOT BETWEEN PACK.SAL_MIN AND PACK.SAL_MAX)
        THEN
        RAISE_APPLICATION_ERROR(-20001,'Tabelul nu poate fi actualizat, deoarece noul salariu este in afara grilei salariale');
    END IF;
END;
    
INSERT INTO JOBURI VALUES (7, 'SOUS CHEF', 6000);
DELETE FROM JOBURI WHERE COD_JOB =7;

DROP TRIGGER TRIG_2;

--12. Trigger de tip LDD

CREATE TABLE DB_LOGS
     (USR VARCHAR2(30),
     EVENT VARCHAR2(20),
     OBJ VARCHAR2(30),
     DATA DATE);
     
CREATE OR REPLACE TRIGGER TRIG_3
     AFTER CREATE OR DROP OR ALTER ON SCHEMA
BEGIN
     INSERT INTO DB_LOGS
     VALUES (SYS.LOGIN_USER, SYS.SYSEVENT, 
     SYS.DICTIONARY_OBJ_NAME, SYSDATE);
END;

CREATE TABLE TEST_TRIG_3(
    NUMAR NUMBER(5,0));

DROP TRIGGER TRIG_3;
DROP TABLE DB_LOGS;
DROP TABLE TEST;
DELETE FROM DB_LOGS WHERE USR = 'NUMEUSER';

SELECT * FROM DB_LOGS;
