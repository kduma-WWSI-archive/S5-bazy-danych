CREATE TABLE osoby (
  id            INT PRIMARY KEY                                         IDENTITY (1, 1),
  nazwisko      CHAR(30) NOT NULL,
  imie          CHAR(15) NOT NULL,
  adres         CHAR(30) NULL                                           DEFAULT ('brak danych'),
  stan_cywilny  CHAR(30) NULL,
  telefon_dom   CHAR(15) NULL,
  telefon_praca CHAR(15) NULL,
  zarobki       DECIMAL(8, 2) CHECK (zarobki BETWEEN 100 AND 2000),
  plec_osoby    CHAR(1)  NOT NULL,
  kolor_oczu    CHAR(1)  NOT NULL CHECK (kolor_oczu IN ('z', 'n', 'c')) DEFAULT ('z')
);
GO ;

CREATE RULE plec_xyz AS @x IN ('m', 'k')
GO ;

EXEC SP_BINDRULE plec_xyz, 'osoby.plec_osoby'
GO ;

CREATE DEFAULT brak_inf AS 'Brak Informacji'
GO ;

EXEC SP_BINDEFAULT brak_inf, 'osoby.stan_cywilny'
GO ;

INSERT INTO osoby
  VALUES ('kowal', 'jan', NULL, NULL, NULL, NULL, 200, 'm', 'z');
INSERT INTO osoby
  VALUES ('robot', 'anna', DEFAULT, NULL, '(22)123456', NULL, 1000, 'k', 'n');
-- SELECT *
--   FROM osoby;
GO ;

TRUNCATE TABLE osoby;
GO ;

DROP TABLE osoby;
GO ;

DROP RULE plec_xyz;
GO ;

DROP DEFAULT brak_inf;
GO ;

INSERT INTO kraje VALUES ('Polska'),
                         ('Rosja'),
                         ('USA'),
                         ('Wielka Brytania'),
                         ('Niemcy'),
                         ('Ukraina');
GO;


-- SELECT TOP 1 * FROM kraje ORDER BY NEWID();
-- GO;


DECLARE @T1 TABLE (imie varchar(20))
DECLARE @T2 TABLE (nazwisko varchar(20))
DECLARE @T3 TABLE (miasto varchar(20))
insert INTO @T1  VALUES ('Jan'),('Anna'),('Kamil')
-- SELECT * FROM @T1
INSERT INTO @T2 VALUES ('Kot'),('Lis'),('Ptak')
-- SELECT * FROM @T2
INSERT INTO @T3 VALUES ('Warszawa'),('Kraków')
-- SELECT * FROM @T3
SELECT * into NOWA  FROM @T1 CROSS JOIN @T2 CROSS JOIN @T3
ALTER table NOWA ADD ID INT IDENTITY(1,1)
GO
SELECT ID,imie,nazwisko,miasto into NOWA1 from NOWA

-- SELECT * FROM nowa1;

-- SELECT * INTO nowa FROM @t1 CROSS JOIN @t2 CROSS JOIN @t3;

DROP TABLE NOWA
GO
DROP TABLE NOWA1
GO;

SELECT getdate();