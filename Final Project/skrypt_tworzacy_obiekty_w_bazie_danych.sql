BEGIN TRY



-- Przygotowanie tabeli do przechowywania statusu (wersji) bazy danych
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    PRINT 'Tabela wersjonowania juz istnieje';
  END
ELSE
  BEGIN
    CREATE TABLE db_status (
      version INT NOT NULL DEFAULT (0)
    )

    INSERT INTO db_status (version) VALUES (0);

    PRINT 'Tabela wersjonowania zostala utworzona';
  END








PRINT 'Wersja 1: ''To jest test'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 0)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE TABLE klienci (
            id INT UNIQUE,
            name VARCHAR(MAX)
          );
        '
    
        UPDATE db_status SET version = 1 WHERE version = 0;
        PRINT 'Wersja 1: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 1';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 0)
          BEGIN
            RAISERROR ('Wersja 1: Baza danych jest w za niskiej wersji (wymagana jest wersja 0) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 1: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 1: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 2: ''To jest drugi test'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 1)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE TABLE obiekty (
            id INT UNIQUE,
            klient_id INT,
            name VARCHAR(MAX)
          );
        '
    
        UPDATE db_status SET version = 2 WHERE version = 1;
        PRINT 'Wersja 2: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 2';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 1)
          BEGIN
            RAISERROR ('Wersja 2: Baza danych jest w za niskiej wersji (wymagana jest wersja 1) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 2: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 2: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
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