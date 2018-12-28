BEGIN TRY



PRINT 'Wersja 36: ''Utworzenie triggeru aktualizujacego stan obiekty'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 36)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          DROP TRIGGER aktualizuj_stan_obiektu;
        '
    
        UPDATE db_status SET version = 35 WHERE version = 36;
        PRINT 'Wersja 36: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 35';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 36)
          BEGIN
            RAISERROR ('Wersja 36: Baza danych jest w za wysokiej wersji (wymagana jest wersja 36) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 36: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 36: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 35: ''Nadanie uprawnien wiersza w tabeli najmy'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 35)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          ALTER SECURITY POLICY fn_security_najmy WITH (state = off);
        '

        EXEC dbo.sp_executesql @statement = N'
          DROP SECURITY POLICY fn_security_najmy;
        '

        EXEC dbo.sp_executesql @statement = N'
          DROP FUNCTION fn_securitypredicate_najmy;
        '
    
        UPDATE db_status SET version = 34 WHERE version = 35;
        PRINT 'Wersja 35: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 34';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 35)
          BEGIN
            RAISERROR ('Wersja 35: Baza danych jest w za wysokiej wersji (wymagana jest wersja 35) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 35: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 35: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 34: ''Nadanie uprawnien wiersza w tabeli uzytkownicy'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 34)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          ALTER SECURITY POLICY fn_security_uzytkownicy WITH (state = off);
        '

        EXEC dbo.sp_executesql @statement = N'
          DROP SECURITY POLICY fn_security_uzytkownicy;
        '

        EXEC dbo.sp_executesql @statement = N'
          DROP FUNCTION fn_securitypredicate_uzytkownicy;
        '
    
        UPDATE db_status SET version = 33 WHERE version = 34;
        PRINT 'Wersja 34: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 33';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 34)
          BEGIN
            RAISERROR ('Wersja 34: Baza danych jest w za wysokiej wersji (wymagana jest wersja 34) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 34: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 34: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 33: ''Nadanie uprawnien roli uzytkownika systemu'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 33)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          REVOKE SELECT ON kategorie TO uzytkownicy_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          REVOKE SELECT ON miasta TO uzytkownicy_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          REVOKE SELECT ON dzielnice TO uzytkownicy_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          REVOKE SELECT ON obiekty TO uzytkownicy_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          REVOKE SELECT, UPDATE(nazwisko, imie, wiek, adres, telefon, plec) ON uzytkownicy TO uzytkownicy_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          REVOKE SELECT, INSERT, UPDATE(data_zakonczenia) ON najmy TO uzytkownicy_systemu;
        '
    
        UPDATE db_status SET version = 32 WHERE version = 33;
        PRINT 'Wersja 33: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 32';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 33)
          BEGIN
            RAISERROR ('Wersja 33: Baza danych jest w za wysokiej wersji (wymagana jest wersja 33) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 33: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 33: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 32: ''Utworzenie procedury skladowanej do tworzenia uzytkownikow'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 32)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          DROP PROCEDURE utworz_uzytkownika;
        '
    
        UPDATE db_status SET version = 31 WHERE version = 32;
        PRINT 'Wersja 32: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 31';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 32)
          BEGIN
            RAISERROR ('Wersja 32: Baza danych jest w za wysokiej wersji (wymagana jest wersja 32) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 32: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 32: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 31: ''Utworzenie procedury skladowanej wynajmowania obiektow'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 31)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          REVOKE EXECUTE ON wynajmij_obiekt TO uzytkownicy_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          DROP PROCEDURE wynajmij_obiekt;
        '
    
        UPDATE db_status SET version = 30 WHERE version = 31;
        PRINT 'Wersja 31: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 30';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 31)
          BEGIN
            RAISERROR ('Wersja 31: Baza danych jest w za wysokiej wersji (wymagana jest wersja 31) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 31: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 31: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 30: ''Utworzenie roli uzytkownika systemu'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 30)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          DROP ROLE uzytkownicy_systemu;
        '
    
        UPDATE db_status SET version = 29 WHERE version = 30;
        PRINT 'Wersja 30: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 29';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 30)
          BEGIN
            RAISERROR ('Wersja 30: Baza danych jest w za wysokiej wersji (wymagana jest wersja 30) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 30: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 30: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 29: ''Przypisanie uzytkownikowi operatora roli operatora systemu'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 29)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          EXEC sp_droprolemember ''operatorzy_systemu'', ''operator'';
        '
    
        UPDATE db_status SET version = 28 WHERE version = 29;
        PRINT 'Wersja 29: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 28';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 29)
          BEGIN
            RAISERROR ('Wersja 29: Baza danych jest w za wysokiej wersji (wymagana jest wersja 29) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 29: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 29: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 28: ''Utworzenie uzytkownika operatora'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 28)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          DROP USER operator;
        '
    
        UPDATE db_status SET version = 27 WHERE version = 28;
        PRINT 'Wersja 28: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 27';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 28)
          BEGIN
            RAISERROR ('Wersja 28: Baza danych jest w za wysokiej wersji (wymagana jest wersja 28) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 28: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 28: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 27: ''Nadanie uprawnien roli operatora systemu'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 27)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          REVOKE SELECT ON kategorie TO operatorzy_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          REVOKE SELECT ON miasta TO operatorzy_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          REVOKE SELECT ON dzielnice TO operatorzy_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          REVOKE SELECT ON obiekty TO operatorzy_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          REVOKE SELECT ON uzytkownicy TO operatorzy_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          REVOKE SELECT, INSERT, UPDATE ON najmy TO operatorzy_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          REVOKE SELECT ON lista_najmow TO operatorzy_systemu;
        '
    
        UPDATE db_status SET version = 26 WHERE version = 27;
        PRINT 'Wersja 27: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 26';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 27)
          BEGIN
            RAISERROR ('Wersja 27: Baza danych jest w za wysokiej wersji (wymagana jest wersja 27) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 27: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 27: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 26: ''Utworzenie roli operatora systemu'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 26)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          DROP ROLE operatorzy_systemu;
        '
    
        UPDATE db_status SET version = 25 WHERE version = 26;
        PRINT 'Wersja 26: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 25';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 26)
          BEGIN
            RAISERROR ('Wersja 26: Baza danych jest w za wysokiej wersji (wymagana jest wersja 26) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 26: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 26: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 25: ''Przypisanie uzytkownikowi administracyjnemu roli administratora systemu'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 25)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          EXEC sp_droprolemember ''admini_systemu'', ''admin'';
        '
    
        UPDATE db_status SET version = 24 WHERE version = 25;
        PRINT 'Wersja 25: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 24';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 25)
          BEGIN
            RAISERROR ('Wersja 25: Baza danych jest w za wysokiej wersji (wymagana jest wersja 25) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 25: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 25: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 24: ''Utworzenie uzytkownika administracyjnego'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 24)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          DROP USER admin;
        '
    
        UPDATE db_status SET version = 23 WHERE version = 24;
        PRINT 'Wersja 24: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 23';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 24)
          BEGIN
            RAISERROR ('Wersja 24: Baza danych jest w za wysokiej wersji (wymagana jest wersja 24) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 24: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 24: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 23: ''Nadanie uprawnien roli administratora systemu'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 23)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          REVOKE SELECT, INSERT, UPDATE, DELETE ON kategorie TO admini_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          REVOKE SELECT, INSERT, UPDATE, DELETE ON miasta TO admini_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          REVOKE SELECT, INSERT, UPDATE, DELETE ON dzielnice TO admini_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          REVOKE SELECT, INSERT, UPDATE, DELETE ON obiekty TO admini_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          REVOKE SELECT, UPDATE, DELETE ON uzytkownicy TO admini_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          REVOKE SELECT, INSERT, UPDATE ON najmy TO admini_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          REVOKE SELECT ON lista_najmow TO admini_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          REVOKE SELECT ON lista_niepopularnych_obiektow TO admini_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          REVOKE SELECT ON lista_popularnosci_obiektow TO admini_systemu;
        '
    
        UPDATE db_status SET version = 22 WHERE version = 23;
        PRINT 'Wersja 23: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 22';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 23)
          BEGIN
            RAISERROR ('Wersja 23: Baza danych jest w za wysokiej wersji (wymagana jest wersja 23) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 23: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 23: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 22: ''Utworzenie roli administratora systemu'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 22)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          DROP ROLE admini_systemu;
        '
    
        UPDATE db_status SET version = 21 WHERE version = 22;
        PRINT 'Wersja 22: Migracja zostala odinstalowana pomyslnie - teraz baza jest w wersji 21';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version > 22)
          BEGIN
            RAISERROR ('Wersja 22: Baza danych jest w za wysokiej wersji (wymagana jest wersja 22) aby odinstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 22: Migracja nie była wczesniej zainstalowana lub zostala juz odinstalowana';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 22: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








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