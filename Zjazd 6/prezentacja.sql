CREATE TRIGGER tr_blogada_modyfikacji
  ON komunikaty_wyzwalaczy
  INSTEAD OF UPDATE, DELETE
  AS RAISERROR('Edycja i usuwanie wpisw jest zabronione', 16, 1)
GO

DROP TRIGGER tr_blogada_modyfikacji
GO



CREATE TRIGGER tr_blogada_modyfikacji
  ON komunikaty_wyzwalaczy
  INSTEAD OF UPDATE, DELETE
  AS
  THROW 60001, 'Edycja i usuwanie sa zabronione 2', 10
GO

CREATE PROCEDURE zapisz_nowy_kraj
--     @id_kraj INT,
    @krajprod CHAR(15)
  AS
--   IF EXISTS(SELECT * FROM kraje WHERE id=@id_kraj)
--     RETURN 1
  IF EXISTS(SELECT * FROM kraje WHERE nazwa=@krajprod)
      RETURN 1
  BEGIN TRANSACTION
--   INSERT INTO kraje(id, nazwa) VALUES (@id_kraj, @krajprod)
  INSERT INTO kraje(nazwa) VALUES (@krajprod)
  IF @@ERROR<>0
      GOTO BLAD
  COMMIT TRANSACTION
  RETURN 0
  BLAD:
  ROLLBACK TRANSACTION
  RETURN 3
GO

DROP PROCEDURE zapisz_nowy_kraj
GO

EXEC zapisz_nowy_kraj 'RRRS'
GO

DECLARE	@return_value int

EXEC	@return_value = [Z501_03].[zapisz_nowy_kraj]
-- 		@id_kraj = 123,
		@krajprod = N'Mozambik'

SELECT	'Return Value' = @return_value

GO


DECLARE @return_status INT
EXEC @return_status = zapisz_nowy_kraj 'Malta'
SELECT 'Return Status' = @return_status
GO










SELECT @@servername, @@version, @@language
GO



DECLARE @m INT, @k INT
SELECT @m = count(*)
    FROM klienci
    WHERE plec = 'M'
SELECT @k = count(*)
    FROM klienci
    WHERE plec = 'K'
SELECT 'kobiety', @k
SELECT 'mezczyzni', @m

IF @m > @k
  BEGIN
    PRINT 'Mezczyzn jest wiecej'
    SELECT 'Mezczyzn jest wiecej o', @m - @k
  END
ELSE IF @m = @k
  BEGIN
    PRINT 'Kobiet jest tyle samo co mezczyzn'
    SELECT 'Kobiet jest tyle samo co mezczyzn'
  END
ELSE
  BEGIN
    PRINT 'Kobiet jest wiecej'
    SELECT 'Kobiet jest wiecej o', @k - @m
  END
GO



SELECT nazwisko, imie, CASE plec
                         WHEN 'K' THEN 'Kobieta'
                         WHEN 'M' THEN 'Mezczyzna'
                         ELSE 'Ktos'
    END AS plec
    FROM klienci
    ORDER BY nazwisko
GO
















DECLARE ProstyKursor CURSOR
LOCAL
  FOR SELECT * FROM klienci
OPEN prostykursor
FETCH prostykursor
WHILE @@FETCH_STATUS = 0
  BEGIN
    PRINT 'POBRALEM'
    FETCH prostykursor
  END
CLOSE prostykursor
DEALLOCATE prostykursor
GO











































































































