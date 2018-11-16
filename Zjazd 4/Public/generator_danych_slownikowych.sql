DROP TABLE NOWA
GO
DROP TABLE NOWA1
GO
DECLARE @T1 TABLE (imie varchar(20))
DECLARE @T2 TABLE (nazwisko varchar(20))
DECLARE @T3 TABLE (miasto varchar(20))
insert INTO @T1  VALUES ('Jan'),('Anna'),('Kamil')
SELECT * FROM @T1
INSERT INTO @T2 VALUES ('Kot'),('Lis'),('Ptak')
SELECT * FROM @T2
INSERT INTO @T3 VALUES ('Warszawa'),('Kraków')
SELECT * FROM @T3
SELECT * into NOWA  FROM @T1 CROSS JOIN @T2 CROSS JOIN @T3
ALTER table NOWA ADD ID INT IDENTITY(1,1)
GO
SELECT ID,imie,nazwisko,miasto into NOWA1 from NOWA