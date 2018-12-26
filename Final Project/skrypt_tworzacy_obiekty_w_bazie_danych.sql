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








PRINT 'Wersja 1: ''Utworzenie tabeli z miastami'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 0)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE TABLE miasta (
            id INT PRIMARY KEY NOT NULL IDENTITY (1, 1),
            nazwa VARCHAR(75) NOT NULL
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








PRINT 'Wersja 2: ''Utworzenie tabeli z dzielnicami'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 1)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE TABLE dzielnice (
            id INT PRIMARY KEY NOT NULL IDENTITY (1, 1),
            miasto_id INT NOT NULL,
            nazwa VARCHAR(75) NOT NULL
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








PRINT 'Wersja 3: ''Utworzenie relacji pomiedzy miastami a dzielnicami'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 2)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          ALTER TABLE dzielnice
            ADD CONSTRAINT dzielnice_miasta_fk 
            FOREIGN KEY (miasto_id) 
            REFERENCES miasta(id);
        '
    
        UPDATE db_status SET version = 3 WHERE version = 2;
        PRINT 'Wersja 3: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 3';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 2)
          BEGIN
            RAISERROR ('Wersja 3: Baza danych jest w za niskiej wersji (wymagana jest wersja 2) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 3: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 3: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 4: ''Utworzenie tabeli z kategoriami'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 3)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE TABLE kategorie (
            id INT PRIMARY KEY NOT NULL IDENTITY (1, 1),
            nazwa VARCHAR(75) NOT NULL
          );
        '
    
        UPDATE db_status SET version = 4 WHERE version = 3;
        PRINT 'Wersja 4: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 4';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 3)
          BEGIN
            RAISERROR ('Wersja 4: Baza danych jest w za niskiej wersji (wymagana jest wersja 3) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 4: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 4: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 5: ''Utworzenie tabeli z obiektami'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 4)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE TABLE obiekty (
            id INT PRIMARY KEY NOT NULL IDENTITY (1, 1),
          
            dzielnica_id INT NOT NULL,
            kategoria_id INT NOT NULL,
          
            nazwa VARCHAR(150) NOT NULL,
            adres VARCHAR(150) NOT NULL DEFAULT ''Brak Danych'',
            dzienna_stawka_najmu DECIMAL(10, 2) NOT NULL CHECK (dzienna_stawka_najmu > 0),
          
            obecnie_wynajete CHAR(1) NOT NULL DEFAULT ''N'' CHECK (obecnie_wynajete IN (''T'', ''N'')),
          );
        '
    
        UPDATE db_status SET version = 5 WHERE version = 4;
        PRINT 'Wersja 5: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 5';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 4)
          BEGIN
            RAISERROR ('Wersja 5: Baza danych jest w za niskiej wersji (wymagana jest wersja 4) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 5: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 5: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 6: ''Utworzenie relacji pomiedzy dzielnicami a obiektami'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 5)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          ALTER TABLE obiekty
            ADD CONSTRAINT obiekty_dzielnice_fk
            FOREIGN KEY (dzielnica_id)
            REFERENCES dzielnice(id);
        '
    
        UPDATE db_status SET version = 6 WHERE version = 5;
        PRINT 'Wersja 6: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 6';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 5)
          BEGIN
            RAISERROR ('Wersja 6: Baza danych jest w za niskiej wersji (wymagana jest wersja 5) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 6: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 6: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 7: ''Utworzenie relacji pomiedzy kategoriami a obiektami'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 6)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          ALTER TABLE obiekty
            ADD CONSTRAINT obiekty_kategorie_fk
            FOREIGN KEY (kategoria_id)
            REFERENCES kategorie(id);
        '
    
        UPDATE db_status SET version = 7 WHERE version = 6;
        PRINT 'Wersja 7: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 7';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 6)
          BEGIN
            RAISERROR ('Wersja 7: Baza danych jest w za niskiej wersji (wymagana jest wersja 6) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 7: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 7: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 8: ''Utworzenie tabeli z uzytkownikami'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 7)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE TABLE uzytkownicy (
            id INT PRIMARY KEY NOT NULL IDENTITY (1, 1),
          
            login VARCHAR(75) NOT NULL,
          
            nazwisko VARCHAR(75) NOT NULL,
            imie VARCHAR(75) NOT NULL,
            wiek INT NOT NULL CHECK (wiek BETWEEN 1 AND 100),
            adres VARCHAR(150) NOT NULL DEFAULT ''Brak Danych'',
            telefon VARCHAR(30) NOT NULL DEFAULT ''Brak Danych'',
            plec CHAR(1) NOT NULL CHECK (plec IN (''K'', ''M'')),
          );
        '
    
        UPDATE db_status SET version = 8 WHERE version = 7;
        PRINT 'Wersja 8: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 8';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 7)
          BEGIN
            RAISERROR ('Wersja 8: Baza danych jest w za niskiej wersji (wymagana jest wersja 7) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 8: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 8: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 9: ''Utworzenie tabeli z najmami'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 8)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE TABLE najmy (
            id INT PRIMARY KEY NOT NULL IDENTITY (1, 1),
          
            uzytkownik_id INT NOT NULL,
            obiekt_id INT NOT NULL,
          
            data_rozpoczecia DATE NOT NULL DEFAULT getdate(),
            data_zakonczenia DATE NULL,
            koszt DECIMAL(15, 2) NULL,
          );
        '
    
        UPDATE db_status SET version = 9 WHERE version = 8;
        PRINT 'Wersja 9: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 9';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 8)
          BEGIN
            RAISERROR ('Wersja 9: Baza danych jest w za niskiej wersji (wymagana jest wersja 8) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 9: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 9: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 10: ''Utworzenie indeksu unikatowego w tabeli z najemcami'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 9)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE UNIQUE INDEX najemcy_ui
             ON najmy (uzytkownik_id, obiekt_id, data_rozpoczecia);
        '
    
        UPDATE db_status SET version = 10 WHERE version = 9;
        PRINT 'Wersja 10: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 10';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 9)
          BEGIN
            RAISERROR ('Wersja 10: Baza danych jest w za niskiej wersji (wymagana jest wersja 9) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 10: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 10: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 11: ''Utworzenie relacji pomiedzy uzytkownikami a najmami'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 10)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          ALTER TABLE najmy
            ADD CONSTRAINT najmy_uzytkownicy_fk
            FOREIGN KEY (uzytkownik_id)
            REFERENCES uzytkownicy(id);
        '
    
        UPDATE db_status SET version = 11 WHERE version = 10;
        PRINT 'Wersja 11: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 11';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 10)
          BEGIN
            RAISERROR ('Wersja 11: Baza danych jest w za niskiej wersji (wymagana jest wersja 10) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 11: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 11: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 12: ''Utworzenie relacji pomiedzy obiektami a najmami'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 11)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          ALTER TABLE najmy
            ADD CONSTRAINT najmy_obiekty_fk
            FOREIGN KEY (obiekt_id)
            REFERENCES obiekty(id);
        '
    
        UPDATE db_status SET version = 12 WHERE version = 11;
        PRINT 'Wersja 12: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 12';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 11)
          BEGIN
            RAISERROR ('Wersja 12: Baza danych jest w za niskiej wersji (wymagana jest wersja 11) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 12: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 12: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 13: ''Utworzenie indeksu unikatowego w tabeli z uzytkownikami'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 12)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE UNIQUE INDEX najemcy_ui
             ON uzytkownicy (login);
        '
    
        UPDATE db_status SET version = 13 WHERE version = 12;
        PRINT 'Wersja 13: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 13';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 12)
          BEGIN
            RAISERROR ('Wersja 13: Baza danych jest w za niskiej wersji (wymagana jest wersja 12) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 13: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 13: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
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