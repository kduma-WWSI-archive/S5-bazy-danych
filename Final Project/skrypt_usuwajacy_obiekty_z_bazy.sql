BEGIN TRY



PRINT 'Wersja 13: ''Utworzenie indeksu unikatowego w tabeli z uzytkownikami'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 13)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          DROP INDEX uzytkownicy.najemcy_ui;
        '
    
        UPDATE db_status SET version = 12 WHERE version = 13;
        PRINT 'Wersja 13: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 12';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 13)
          BEGIN
            RAISERROR ('Wersja 13: Baza danych jest w za wysokiej wersji (wymagana jest wersja 13) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 13: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 13: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 12: ''Utworzenie relacji pomiedzy obiektami a najmami'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 12)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          ALTER TABLE najmy DROP CONSTRAINT najmy_obiekty_fk;
        '
    
        UPDATE db_status SET version = 11 WHERE version = 12;
        PRINT 'Wersja 12: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 11';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 12)
          BEGIN
            RAISERROR ('Wersja 12: Baza danych jest w za wysokiej wersji (wymagana jest wersja 12) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 12: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 12: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 11: ''Utworzenie relacji pomiedzy uzytkownikami a najmami'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 11)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          ALTER TABLE najmy DROP CONSTRAINT najmy_uzytkownicy_fk;
        '
    
        UPDATE db_status SET version = 10 WHERE version = 11;
        PRINT 'Wersja 11: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 10';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 11)
          BEGIN
            RAISERROR ('Wersja 11: Baza danych jest w za wysokiej wersji (wymagana jest wersja 11) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 11: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 11: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 10: ''Utworzenie indeksu unikatowego w tabeli z najemcami'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 10)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          DROP INDEX najmy.najemcy_ui;
        '
    
        UPDATE db_status SET version = 9 WHERE version = 10;
        PRINT 'Wersja 10: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 9';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 10)
          BEGIN
            RAISERROR ('Wersja 10: Baza danych jest w za wysokiej wersji (wymagana jest wersja 10) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 10: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 10: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 9: ''Utworzenie tabeli z najmami'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 9)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          DROP TABLE najmy;
        '
    
        UPDATE db_status SET version = 8 WHERE version = 9;
        PRINT 'Wersja 9: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 8';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 9)
          BEGIN
            RAISERROR ('Wersja 9: Baza danych jest w za wysokiej wersji (wymagana jest wersja 9) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 9: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 9: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 8: ''Utworzenie tabeli z uzytkownikami'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 8)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          DROP TABLE uzytkownicy;
        '
    
        UPDATE db_status SET version = 7 WHERE version = 8;
        PRINT 'Wersja 8: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 7';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 8)
          BEGIN
            RAISERROR ('Wersja 8: Baza danych jest w za wysokiej wersji (wymagana jest wersja 8) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 8: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 8: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 7: ''Utworzenie relacji pomiedzy kategoriami a obiektami'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 7)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          ALTER TABLE obiekty DROP CONSTRAINT obiekty_kategorie_fk;
        '
    
        UPDATE db_status SET version = 6 WHERE version = 7;
        PRINT 'Wersja 7: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 6';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 7)
          BEGIN
            RAISERROR ('Wersja 7: Baza danych jest w za wysokiej wersji (wymagana jest wersja 7) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 7: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 7: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 6: ''Utworzenie relacji pomiedzy dzielnicami a obiektami'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 6)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          ALTER TABLE obiekty DROP CONSTRAINT obiekty_dzielnice_fk;
        '
    
        UPDATE db_status SET version = 5 WHERE version = 6;
        PRINT 'Wersja 6: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 5';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 6)
          BEGIN
            RAISERROR ('Wersja 6: Baza danych jest w za wysokiej wersji (wymagana jest wersja 6) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 6: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 6: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 5: ''Utworzenie tabeli z obiektami'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 5)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          DROP TABLE obiekty;
        '
    
        UPDATE db_status SET version = 4 WHERE version = 5;
        PRINT 'Wersja 5: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 4';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 5)
          BEGIN
            RAISERROR ('Wersja 5: Baza danych jest w za wysokiej wersji (wymagana jest wersja 5) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 5: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 5: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 4: ''Utworzenie tabeli z kategoriami'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 4)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          DROP TABLE kategorie;
        '
    
        UPDATE db_status SET version = 3 WHERE version = 4;
        PRINT 'Wersja 4: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 3';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 4)
          BEGIN
            RAISERROR ('Wersja 4: Baza danych jest w za wysokiej wersji (wymagana jest wersja 4) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 4: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 4: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 3: ''Utworzenie relacji pomiedzy miastami a dzielnicami'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 3)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          ALTER TABLE dzielnice DROP CONSTRAINT dzielnice_miasta_fk;
        '
    
        UPDATE db_status SET version = 2 WHERE version = 3;
        PRINT 'Wersja 3: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 2';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 3)
          BEGIN
            RAISERROR ('Wersja 3: Baza danych jest w za wysokiej wersji (wymagana jest wersja 3) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 3: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 3: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 2: ''Utworzenie tabeli z dzielnicami'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 2)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          DROP TABLE dzielnice;
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








PRINT 'Wersja 1: ''Utworzenie tabeli z miastami'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 1)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          DROP TABLE miasta;
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

  SELECT
    ERROR_NUMBER() AS ErrorNumber,
    ERROR_SEVERITY() AS ErrorSeverity,
    ERROR_STATE() AS ErrorState,
    ERROR_PROCEDURE() AS ErrorProcedure,
    ERROR_LINE() AS ErrorLine,
    ERROR_MESSAGE() AS ErrorMessage;

END CATCH;