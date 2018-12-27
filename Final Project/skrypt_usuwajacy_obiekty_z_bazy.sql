BEGIN TRY



PRINT 'Wersja 21: ''Utworzenie funkcji wyswietlajacej spozniajacych sie uzytkownikow'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 21)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          DROP FUNCTION opoznieni;
        '
    
        UPDATE db_status SET version = 20 WHERE version = 21;
        PRINT 'Wersja 21: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 20';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 21)
          BEGIN
            RAISERROR ('Wersja 21: Baza danych jest w za wysokiej wersji (wymagana jest wersja 21) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 21: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 21: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 20: ''Utworzenie funkcji wyswietlajacej adresowke uzytkownika'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 20)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          DROP FUNCTION adresowka;
        '
    
        UPDATE db_status SET version = 19 WHERE version = 20;
        PRINT 'Wersja 20: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 19';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 20)
          BEGIN
            RAISERROR ('Wersja 20: Baza danych jest w za wysokiej wersji (wymagana jest wersja 20) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 20: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 20: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 19: ''Utworzenie triggeru aktualizujacego koszt najmu'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 19)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          DROP TRIGGER wylicz_koszt_najmu;
        '
    
        UPDATE db_status SET version = 18 WHERE version = 19;
        PRINT 'Wersja 19: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 18';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 19)
          BEGIN
            RAISERROR ('Wersja 19: Baza danych jest w za wysokiej wersji (wymagana jest wersja 19) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 19: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 19: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 18: ''Utworzenie funkcji wyliczajacej koszt konkretnego najmu'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 18)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          DROP FUNCTION koszt_najmu;
        '
    
        UPDATE db_status SET version = 17 WHERE version = 18;
        PRINT 'Wersja 18: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 17';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 18)
          BEGIN
            RAISERROR ('Wersja 18: Baza danych jest w za wysokiej wersji (wymagana jest wersja 18) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 18: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 18: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 17: ''Utworzenie funkcji wyliczajacej koszt najmu obiektu'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 17)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          DROP FUNCTION koszt_najmu_obiektu;
        '
    
        UPDATE db_status SET version = 16 WHERE version = 17;
        PRINT 'Wersja 17: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 16';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 17)
          BEGIN
            RAISERROR ('Wersja 17: Baza danych jest w za wysokiej wersji (wymagana jest wersja 17) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 17: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 17: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 16: ''Utworzenie widoku z lista niewynajmowanych obiektow'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 16)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          DROP VIEW lista_niepopularnych_obiektow;
        '
    
        UPDATE db_status SET version = 15 WHERE version = 16;
        PRINT 'Wersja 16: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 15';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 16)
          BEGIN
            RAISERROR ('Wersja 16: Baza danych jest w za wysokiej wersji (wymagana jest wersja 16) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 16: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 16: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 15: ''Utworzenie widoku z lista popularnosci obiektow'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 15)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          DROP VIEW lista_popularnosci_obiektow;
        '
    
        UPDATE db_status SET version = 14 WHERE version = 15;
        PRINT 'Wersja 15: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 14';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 15)
          BEGIN
            RAISERROR ('Wersja 15: Baza danych jest w za wysokiej wersji (wymagana jest wersja 15) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 15: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 15: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 14: ''Utworzenie widoku z lista wszystkich najmow'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 14)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          DROP VIEW lista_najmow;
        '
    
        UPDATE db_status SET version = 13 WHERE version = 14;
        PRINT 'Wersja 14: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 13';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 14)
          BEGIN
            RAISERROR ('Wersja 14: Baza danych jest w za wysokiej wersji (wymagana jest wersja 14) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 14: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 14: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








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