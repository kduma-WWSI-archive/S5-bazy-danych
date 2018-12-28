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








PRINT 'Wersja 14: ''Utworzenie widoku z lista wszystkich najmow'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 13)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE VIEW lista_najmow
            AS
              SELECT nazwisko, imie, data_rozpoczecia, data_zakonczenia, nazwa nazwa_obiektu, koszt calkowity_koszt
                  FROM najmy n
                  JOIN uzytkownicy u on n.uzytkownik_id = u.id
                  JOIN obiekty o on n.obiekt_id = o.id;
        '
    
        UPDATE db_status SET version = 14 WHERE version = 13;
        PRINT 'Wersja 14: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 14';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 13)
          BEGIN
            RAISERROR ('Wersja 14: Baza danych jest w za niskiej wersji (wymagana jest wersja 13) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 14: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 14: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 15: ''Utworzenie widoku z lista popularnosci obiektow'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 14)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE VIEW lista_popularnosci_obiektow
            AS
              SELECT id, nazwa, adres, (SELECT COUNT(*) FROM najmy WHERE najmy.obiekt_id = obiekty.id) liczba_najmow
              FROM obiekty;
        '
    
        UPDATE db_status SET version = 15 WHERE version = 14;
        PRINT 'Wersja 15: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 15';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 14)
          BEGIN
            RAISERROR ('Wersja 15: Baza danych jest w za niskiej wersji (wymagana jest wersja 14) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 15: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 15: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 16: ''Utworzenie widoku z lista niewynajmowanych obiektow'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 15)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE VIEW lista_niepopularnych_obiektow
            AS
              SELECT id, nazwa, adres
                FROM lista_popularnosci_obiektow
                GROUP BY id, nazwa, adres
                HAVING SUM(liczba_najmow) = 0;
        '
    
        UPDATE db_status SET version = 16 WHERE version = 15;
        PRINT 'Wersja 16: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 16';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 15)
          BEGIN
            RAISERROR ('Wersja 16: Baza danych jest w za niskiej wersji (wymagana jest wersja 15) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 16: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 16: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 17: ''Utworzenie funkcji wyliczajacej koszt najmu obiektu'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 16)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE FUNCTION koszt_najmu_obiektu (@obiekt_id INT, @liczba_dni INT)
            RETURNS DECIMAL(15, 2)
            AS
            BEGIN
          		DECLARE @dzienna_stawka DECIMAL(10,2);
          
              SELECT @dzienna_stawka = dzienna_stawka_najmu
                FROM obiekty o
                WHERE id = @obiekt_id;
          
              RETURN @liczba_dni*@dzienna_stawka;
            END
        '
    
        UPDATE db_status SET version = 17 WHERE version = 16;
        PRINT 'Wersja 17: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 17';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 16)
          BEGIN
            RAISERROR ('Wersja 17: Baza danych jest w za niskiej wersji (wymagana jest wersja 16) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 17: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 17: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 18: ''Utworzenie funkcji wyliczajacej koszt konkretnego najmu'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 17)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE FUNCTION koszt_najmu (@najem_id INT)
            RETURNS DECIMAL(15, 2)
            AS
            BEGIN
          		DECLARE @koszt DECIMAL(15, 2);
          		DECLARE @liczba_dni INT;
          		DECLARE @obiekt_id INT;
          		DECLARE @data_rozpoczecia DATE;
          		DECLARE @data_zakonczenia DATE;
          
              SELECT @data_rozpoczecia = n.data_rozpoczecia,
                     @data_zakonczenia = n.data_zakonczenia,
                     @obiekt_id = o.id
                FROM najmy n
                JOIN obiekty o on n.obiekt_id = o.id
                WHERE n.id = @najem_id;
          
              IF @data_zakonczenia IS NULL
                RETURN NULL;
          
              SELECT @liczba_dni = (1+DATEDIFF(DAY, @data_rozpoczecia, @data_zakonczenia));
          
              SELECT @koszt = dbo.koszt_najmu_obiektu(@obiekt_id, @liczba_dni);
          
              RETURN @koszt;
            END
        '
    
        UPDATE db_status SET version = 18 WHERE version = 17;
        PRINT 'Wersja 18: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 18';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 17)
          BEGIN
            RAISERROR ('Wersja 18: Baza danych jest w za niskiej wersji (wymagana jest wersja 17) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 18: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 18: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 19: ''Utworzenie triggeru aktualizujacego koszt najmu'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 18)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE TRIGGER wylicz_koszt_najmu
            ON najmy
            AFTER INSERT, UPDATE
            AS
            BEGIN
              UPDATE najmy
                SET koszt = dbo.koszt_najmu(n.id)
                FROM najmy n
                JOIN inserted i ON n.id = i.id
                WHERE UPDATE (data_zakonczenia) OR NOT EXISTS(SELECT 1 FROM DELETED)
            END
        '
    
        UPDATE db_status SET version = 19 WHERE version = 18;
        PRINT 'Wersja 19: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 19';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 18)
          BEGIN
            RAISERROR ('Wersja 19: Baza danych jest w za niskiej wersji (wymagana jest wersja 18) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 19: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 19: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 20: ''Utworzenie funkcji wyswietlajacej adresowke uzytkownika'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 19)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE FUNCTION adresowka (@uzytkownik_id INT)
            RETURNS VARCHAR(333) -- 75+75+150+30+3 = 333 - suma długości łączonych pól
            AS
            BEGIN
              DECLARE @adresowka VARCHAR(330);
          
              SELECT @adresowka = nazwisko + '' '' + imie + CHAR(13) + telefon + CHAR(13) + adres
                FROM uzytkownicy
                WHERE id = @uzytkownik_id;
          
              RETURN @adresowka;
            END
        '
    
        UPDATE db_status SET version = 20 WHERE version = 19;
        PRINT 'Wersja 20: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 20';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 19)
          BEGIN
            RAISERROR ('Wersja 20: Baza danych jest w za niskiej wersji (wymagana jest wersja 19) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 20: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 20: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 21: ''Utworzenie funkcji wyswietlajacej spozniajacych sie uzytkownikow'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 20)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE FUNCTION opoznieni (@liczba_dni INT)
            RETURNS TABLE
            AS
              RETURN (
                SELECT n.id najem_id,
                       o.nazwa nazwa_obiektu,
                       DATEDIFF(DAY, n.data_rozpoczecia, getdate()) dni_od_wynajmu,
                       dbo.koszt_najmu_obiektu(o.id, DATEDIFF(DAY, n.data_rozpoczecia, getdate()) + 1) szacunkowy_koszt_najmu,
                       dbo.adresowka(u.id) etykieta
                  FROM najmy n
                  JOIN obiekty o on n.obiekt_id = o.id
                  JOIN uzytkownicy u on n.uzytkownik_id = u.id
                  WHERE DATEDIFF(DAY, n.data_rozpoczecia, getdate()) >= @liczba_dni
                        AND n.data_zakonczenia IS NULL
              )
        '
    
        UPDATE db_status SET version = 21 WHERE version = 20;
        PRINT 'Wersja 21: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 21';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 20)
          BEGIN
            RAISERROR ('Wersja 21: Baza danych jest w za niskiej wersji (wymagana jest wersja 20) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 21: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 21: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 22: ''Utworzenie roli administratora systemu'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 21)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE ROLE admini_systemu;
        '
    
        UPDATE db_status SET version = 22 WHERE version = 21;
        PRINT 'Wersja 22: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 22';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 21)
          BEGIN
            RAISERROR ('Wersja 22: Baza danych jest w za niskiej wersji (wymagana jest wersja 21) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 22: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 22: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 23: ''Nadanie uprawnien roli administratora systemu'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 22)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          GRANT SELECT, INSERT, UPDATE, DELETE ON kategorie TO admini_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          GRANT SELECT, INSERT, UPDATE, DELETE ON miasta TO admini_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          GRANT SELECT, INSERT, UPDATE, DELETE ON dzielnice TO admini_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          GRANT SELECT, INSERT, UPDATE, DELETE ON obiekty TO admini_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          GRANT SELECT, UPDATE, DELETE ON uzytkownicy TO admini_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          GRANT SELECT, INSERT, UPDATE ON najmy TO admini_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          GRANT SELECT ON lista_najmow TO admini_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          GRANT SELECT ON lista_niepopularnych_obiektow TO admini_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          GRANT SELECT ON lista_popularnosci_obiektow TO admini_systemu;
        '
    
        UPDATE db_status SET version = 23 WHERE version = 22;
        PRINT 'Wersja 23: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 23';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 22)
          BEGIN
            RAISERROR ('Wersja 23: Baza danych jest w za niskiej wersji (wymagana jest wersja 22) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 23: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 23: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 24: ''Utworzenie uzytkownika administracyjnego'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 23)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE USER admin WITH PASSWORD =''yourStrong(!)Password'';
        '
    
        UPDATE db_status SET version = 24 WHERE version = 23;
        PRINT 'Wersja 24: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 24';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 23)
          BEGIN
            RAISERROR ('Wersja 24: Baza danych jest w za niskiej wersji (wymagana jest wersja 23) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 24: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 24: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 25: ''Przypisanie uzytkownikowi administracyjnemu roli administratora systemu'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 24)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          EXEC sp_addrolemember ''admini_systemu'', ''admin'';
        '
    
        UPDATE db_status SET version = 25 WHERE version = 24;
        PRINT 'Wersja 25: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 25';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 24)
          BEGIN
            RAISERROR ('Wersja 25: Baza danych jest w za niskiej wersji (wymagana jest wersja 24) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 25: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 25: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 26: ''Utworzenie roli operatora systemu'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 25)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE ROLE operatorzy_systemu;
        '
    
        UPDATE db_status SET version = 26 WHERE version = 25;
        PRINT 'Wersja 26: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 26';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 25)
          BEGIN
            RAISERROR ('Wersja 26: Baza danych jest w za niskiej wersji (wymagana jest wersja 25) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 26: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 26: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 27: ''Nadanie uprawnien roli operatora systemu'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 26)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          GRANT SELECT ON kategorie TO operatorzy_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          GRANT SELECT ON miasta TO operatorzy_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          GRANT SELECT ON dzielnice TO operatorzy_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          GRANT SELECT ON obiekty TO operatorzy_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          GRANT SELECT ON uzytkownicy TO operatorzy_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          GRANT SELECT, INSERT, UPDATE ON najmy TO operatorzy_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          GRANT SELECT ON lista_najmow TO operatorzy_systemu;
        '
    
        UPDATE db_status SET version = 27 WHERE version = 26;
        PRINT 'Wersja 27: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 27';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 26)
          BEGIN
            RAISERROR ('Wersja 27: Baza danych jest w za niskiej wersji (wymagana jest wersja 26) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 27: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 27: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 28: ''Utworzenie uzytkownika operatora'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 27)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE USER operator WITH PASSWORD =''yourStrong(!)Password'';
        '
    
        UPDATE db_status SET version = 28 WHERE version = 27;
        PRINT 'Wersja 28: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 28';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 27)
          BEGIN
            RAISERROR ('Wersja 28: Baza danych jest w za niskiej wersji (wymagana jest wersja 27) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 28: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 28: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 29: ''Przypisanie uzytkownikowi operatora roli operatora systemu'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 28)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          EXEC sp_addrolemember ''operatorzy_systemu'', ''operator'';
        '
    
        UPDATE db_status SET version = 29 WHERE version = 28;
        PRINT 'Wersja 29: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 29';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 28)
          BEGIN
            RAISERROR ('Wersja 29: Baza danych jest w za niskiej wersji (wymagana jest wersja 28) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 29: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 29: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 30: ''Utworzenie roli uzytkownika systemu'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 29)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE ROLE uzytkownicy_systemu;
        '
    
        UPDATE db_status SET version = 30 WHERE version = 29;
        PRINT 'Wersja 30: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 30';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 29)
          BEGIN
            RAISERROR ('Wersja 30: Baza danych jest w za niskiej wersji (wymagana jest wersja 29) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 30: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 30: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 31: ''Utworzenie procedury skladowanej wynajmowania obiektow'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 30)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE PROCEDURE wynajmij_obiekt
            @obiekt_id INT
            WITH EXECUTE AS OWNER
            AS
              IF NOT EXISTS(SELECT * FROM obiekty WHERE id = @obiekt_id)
                RETURN 2;
          
              IF EXISTS(SELECT * FROM obiekty WHERE id = @obiekt_id AND obecnie_wynajete = ''t'')
                RETURN 3;
          
              EXECUTE AS CALLER;
              DECLARE @login VARCHAR(75);
              SELECT @login = CURRENT_USER;
              REVERT;
          
              BEGIN TRANSACTION;
              INSERT INTO najmy (uzytkownik_id, obiekt_id, data_rozpoczecia, data_zakonczenia, koszt)
                VALUES ((SELECT u.id FROM dbo.uzytkownicy u WHERE u.login COLLATE SQL_Latin1_General_CP1_CS_AS = @login COLLATE SQL_Latin1_General_CP1_CS_AS), @obiekt_id, DEFAULT, NULL, NULL);
          
              IF @@ERROR<>0
                GOTO BLAD;
          
              COMMIT TRANSACTION;
              RETURN 0;
          
              BLAD:
                ROLLBACK TRANSACTION;
                RETURN 1;
        '

        EXEC dbo.sp_executesql @statement = N'
          GRANT EXECUTE ON wynajmij_obiekt TO uzytkownicy_systemu;
        '
    
        UPDATE db_status SET version = 31 WHERE version = 30;
        PRINT 'Wersja 31: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 31';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 30)
          BEGIN
            RAISERROR ('Wersja 31: Baza danych jest w za niskiej wersji (wymagana jest wersja 30) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 31: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 31: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 32: ''Utworzenie procedury skladowanej do tworzenia uzytkownikow'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 31)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE PROCEDURE utworz_uzytkownika
            @login VARCHAR(75),
            @nazwisko VARCHAR(75),
            @imie VARCHAR(75),
            @wiek INT,
            @adres VARCHAR(150),
            @telefon VARCHAR(30),
            @plec CHAR(1),
            @haslo VARCHAR(30)
            AS
              IF EXISTS(SELECT * FROM uzytkownicy WHERE login = @login)
                RETURN 2;
          
              EXEC sp_addlogin @login, @haslo;
              EXEC sp_adduser @login;
              EXEC sp_addrolemember ''uzytkownicy_systemu'', @login;
          
              BEGIN TRANSACTION;
          
              INSERT INTO uzytkownicy (login, nazwisko, imie, wiek, adres, telefon, plec)
                VALUES (@login, @nazwisko, @imie, @wiek, @adres, @telefon, @plec);
          
              IF @@ERROR<>0
                GOTO BLAD;
          
              COMMIT TRANSACTION
              RETURN 0;
          
              BLAD:
                ROLLBACK TRANSACTION
                RETURN 1;
        '
    
        UPDATE db_status SET version = 32 WHERE version = 31;
        PRINT 'Wersja 32: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 32';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 31)
          BEGIN
            RAISERROR ('Wersja 32: Baza danych jest w za niskiej wersji (wymagana jest wersja 31) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 32: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 32: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 33: ''Nadanie uprawnien roli uzytkownika systemu'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 32)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          GRANT SELECT ON kategorie TO uzytkownicy_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          GRANT SELECT ON miasta TO uzytkownicy_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          GRANT SELECT ON dzielnice TO uzytkownicy_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          GRANT SELECT ON obiekty TO uzytkownicy_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          GRANT SELECT, UPDATE(nazwisko, imie, wiek, adres, telefon, plec) ON uzytkownicy TO uzytkownicy_systemu;
        '

        EXEC dbo.sp_executesql @statement = N'
          GRANT SELECT, INSERT, UPDATE(data_zakonczenia) ON najmy TO uzytkownicy_systemu;
        '
    
        UPDATE db_status SET version = 33 WHERE version = 32;
        PRINT 'Wersja 33: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 33';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 32)
          BEGIN
            RAISERROR ('Wersja 33: Baza danych jest w za niskiej wersji (wymagana jest wersja 32) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 33: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 33: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 34: ''Nadanie uprawnien wiersza w tabeli uzytkownicy'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 33)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE FUNCTION fn_securitypredicate_uzytkownicy (@login_field SYSNAME)
            RETURNS TABLE
            WITH SCHEMABINDING
            AS
              RETURN SELECT 1 AS fn_securitypredicate_uzytkownicy_result
                FROM dbo.uzytkownicy
                WHERE (
                  @login_field = user_name()
                  OR IS_ROLEMEMBER(''admini_systemu'', user_name()) = 1
                  OR IS_ROLEMEMBER(''operatorzy_systemu'', user_name()) = 1
                  OR user_name() = ''dbo''
                )
        '

        EXEC dbo.sp_executesql @statement = N'
          CREATE SECURITY POLICY fn_security_uzytkownicy
            ADD FILTER PREDICATE
            dbo.fn_securitypredicate_uzytkownicy(login)
            ON dbo.uzytkownicy
        '

        EXEC dbo.sp_executesql @statement = N'
          ALTER SECURITY POLICY fn_security_uzytkownicy WITH (state = on);
        '
    
        UPDATE db_status SET version = 34 WHERE version = 33;
        PRINT 'Wersja 34: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 34';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 33)
          BEGIN
            RAISERROR ('Wersja 34: Baza danych jest w za niskiej wersji (wymagana jest wersja 33) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 34: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 34: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 35: ''Nadanie uprawnien wiersza w tabeli najmy'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 34)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE FUNCTION fn_securitypredicate_najmy (@login_field SYSNAME)
            RETURNS TABLE
            WITH SCHEMABINDING
            AS
              RETURN SELECT 1 AS fn_securitypredicate_najmy_result
                FROM dbo.najmy n
                WHERE (
                  @login_field = (SELECT u.id FROM dbo.uzytkownicy u WHERE u.login COLLATE SQL_Latin1_General_CP1_CS_AS = CURRENT_USER COLLATE SQL_Latin1_General_CP1_CS_AS)
                  OR IS_ROLEMEMBER(''admini_systemu'', user_name()) = 1
                  OR IS_ROLEMEMBER(''operatorzy_systemu'', user_name()) = 1
                  OR user_name() = ''dbo''
                )
        '

        EXEC dbo.sp_executesql @statement = N'
          CREATE SECURITY POLICY fn_security_najmy
            ADD FILTER PREDICATE
            dbo.fn_securitypredicate_najmy(uzytkownik_id)
            ON dbo.najmy
        '

        EXEC dbo.sp_executesql @statement = N'
          ALTER SECURITY POLICY fn_security_najmy WITH (state = on);
        '
    
        UPDATE db_status SET version = 35 WHERE version = 34;
        PRINT 'Wersja 35: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 35';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 34)
          BEGIN
            RAISERROR ('Wersja 35: Baza danych jest w za niskiej wersji (wymagana jest wersja 34) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 35: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 35: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
  END








PRINT 'Wersja 36: ''Utworzenie triggeru aktualizujacego stan obiekty'''
IF EXISTS(SELECT * FROM sys.tables WHERE name = N'db_status')
  BEGIN
    IF EXISTS(SELECT * FROM db_status WHERE version = 35)
      BEGIN
        EXEC dbo.sp_executesql @statement = N'
          CREATE TRIGGER aktualizuj_stan_obiektu
            ON najmy
            AFTER INSERT, UPDATE
            AS
            BEGIN
              UPDATE obiekty
                SET obecnie_wynajete = IIF(i.data_zakonczenia IS NULL, ''T'', ''N'')
                FROM obiekty o
                JOIN najmy n ON o.id = n.obiekt_id
                JOIN inserted i ON n.id = i.id
            END
        '
    
        UPDATE db_status SET version = 36 WHERE version = 35;
        PRINT 'Wersja 36: Migracja zostala zainstalowana pomyslnie - teraz baza jest w wersji 36';
      END
    ELSE
      BEGIN
        IF EXISTS(SELECT * FROM db_status WHERE version < 35)
          BEGIN
            RAISERROR ('Wersja 36: Baza danych jest w za niskiej wersji (wymagana jest wersja 35) aby zainstalowac migracje', 11, 2);
          END
        ELSE
          BEGIN
            PRINT 'Wersja 36: Migracja już zostala zainstalowana wczesniej';
          END
      END
  END
ELSE
  BEGIN
    RAISERROR ('Wersja 36: Nie znaleziono tabeli wersjonowania bazy danych', 11, 1);
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