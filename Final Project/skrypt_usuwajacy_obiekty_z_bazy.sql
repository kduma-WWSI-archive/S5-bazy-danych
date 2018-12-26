BEGIN TRY



PRINT 'Wersja 2: ''To jest drugi test'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 2)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          DROP TABLE obiekty;
        '
    
        UPDATE db_status SET version = 1 WHERE version = 2;
        PRINT 'Wersja 2: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 1';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 2)
          BEGIN
            RAISERROR ('Wersja 2: Baza danych jest w za wysokiej wersji (wymagana jest wersja 2) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 2: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 2: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 1: ''To jest test'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 1)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          DROP TABLE klienci;
        '
    
        UPDATE db_status SET version = 0 WHERE version = 1;
        PRINT 'Wersja 1: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 0';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 1)
          BEGIN
            RAISERROR ('Wersja 1: Baza danych jest w za wysokiej wersji (wymagana jest wersja 1) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 1: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 1: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








-- Usunięcie tabeli do przechowywania statusu (wersji) bazy danych
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 0)
      BEGIN
        DROP TABLE db_status;
        PRINT 'Tabela wersjonowania zostala skasowana';
      END
    ELSE
      BEGIN
        RAISERROR ('Nie mozna usunac tabeli wersjonowania poniewaz ma niezerowa wersje', 11, 2);
      END
  END



END TRY
BEGIN CATCH

  DECLARE @ErrorMessage NVARCHAR(4000);
  DECLARE @ErrorSeverity INT;
  DECLARE @ErrorState INT;

  SELECT
    ERROR_NUMBER() AS ErrorNumber,
    ERROR_SEVERITY() AS ErrorSeverity,
    ERROR_STATE() AS ErrorState,
    ERROR_PROCEDURE() AS ErrorProcedure,
    ERROR_LINE() AS ErrorLine,
    ERROR_MESSAGE() AS ErrorMessage;

END CATCH;