-- Zmienna do przechowywania liczby dodanych wierszy
SET NOCOUNT ON;
DECLARE @liczba_wierszy INTEGER


-- Przygotowanie danych testowych
DECLARE @MIASTA TABLE (nazwa VARCHAR(20));
INSERT INTO @MIASTA VALUES ('Miasto 1'),('Miasto 2'),('Miasto 3'),('Miasto 4');

DECLARE @DZIELNICE TABLE (nazwa VARCHAR(20));
INSERT INTO @DZIELNICE VALUES ('Dzielnica 1'),('Dzielnica 2'),('Dzielnica 3'),('Dzielnica 4');

DECLARE @KATEGORIE TABLE (nazwa VARCHAR(20));
INSERT INTO @KATEGORIE VALUES ('Kategoria 1'),('Kategoria 2'),('Kategoria 3'),('Kategoria 4');

DECLARE @LOGINY TABLE (login VARCHAR(20));
INSERT INTO @LOGINY VALUES ('login_1'),('login_2'),('login_3'),('login_4');

DECLARE @IMIONA TABLE (imie VARCHAR(20));
INSERT INTO @IMIONA  VALUES ('Imię 1'),('Imię 2'),('Imię 3'),('Imię 4');

DECLARE @NAZWISKA TABLE (nazwisko VARCHAR(20));
INSERT INTO @NAZWISKA VALUES ('Nazwisko 1'),('Nazwisko 2'),('Nazwisko 3'),('Nazwisko 4');

DECLARE @ADRESY TABLE (adres VARCHAR(20));
INSERT INTO @ADRESY VALUES ('Adres 1'),('Adres 2'),('Adres 3'),('Adres 4');

DECLARE @TELEFONY TABLE (telefon VARCHAR(40));
INSERT INTO @TELEFONY VALUES ('+48 500 349 239'),('+48 234 567 890'),('+48 987 543 123'),('+48 999 444 666');

DECLARE @PLCI TABLE (plec CHAR(1));
INSERT INTO @PLCI VALUES ('M'),('K');

DECLARE @NAZWY TABLE (nazwa VARCHAR(20));
INSERT INTO @NAZWY VALUES ('Nazwa 1'),('Nazwa 2'),('Nazwa 3'),('Nazwa 4');

DECLARE @STAWKI TABLE (stawka DECIMAL(10, 2));
INSERT INTO @STAWKI VALUES (120),(149.99),(64.05),(25.35);

DECLARE @WIEKI TABLE (wiek INT);
INSERT INTO @WIEKI VALUES (18),(35),(64),(89);



-- Wstawianie danych do tabeli 'miasta'
INSERT INTO miasta (nazwa)
  SELECT m.nazwa
  FROM @MIASTA m;

SELECT @liczba_wierszy = @@ROWCOUNT;
PRINT 'Do tabeli miasta dodano '+CAST(@liczba_wierszy AS VARCHAR)+' wiersz(y).';

-- Wstawianie danych do tabeli 'dzielnice'
INSERT INTO dzielnice (miasto_id, nazwa)
  SELECT m.id miasto_id, d.nazwa
  FROM miasta m
  CROSS JOIN @DZIELNICE d;

SELECT @liczba_wierszy = @@ROWCOUNT;
PRINT 'Do tabeli dzielnice dodano '+CAST(@liczba_wierszy AS VARCHAR)+' wiersz(y).';

-- Wstawianie danych do tabeli 'kategorie'
INSERT INTO kategorie (nazwa)
  SELECT k.nazwa
  FROM @KATEGORIE k;

SELECT @liczba_wierszy = @@ROWCOUNT;
PRINT 'Do tabeli kategorie dodano '+CAST(@liczba_wierszy AS VARCHAR)+' wiersz(y).';

-- Wstawianie danych do tabeli 'uzytkownicy'
INSERT INTO uzytkownicy (login, nazwisko, imie, wiek, adres, telefon, plec)
  SELECT l.login login,
    (SELECT TOP 1 nazwisko from @NAZWISKA WHERE l.login IS NOT NULL ORDER BY NewID()) nazwisko,
    (SELECT TOP 1 imie from @IMIONA WHERE l.login IS NOT NULL ORDER BY NewID()) imie,
    (SELECT TOP 1 wiek from @WIEKI WHERE l.login IS NOT NULL ORDER BY NewID()) wiek,
    (SELECT TOP 1 adres from @ADRESY WHERE l.login IS NOT NULL ORDER BY NewID()) adres,
    (SELECT TOP 1 telefon from @TELEFONY WHERE l.login IS NOT NULL ORDER BY NewID()) telefon,
    (SELECT TOP 1 plec from @PLCI WHERE l.login IS NOT NULL ORDER BY NewID()) plec
  FROM @LOGINY l;

SELECT @liczba_wierszy = @@ROWCOUNT;
PRINT 'Do tabeli uzytkownicy dodano '+CAST(@liczba_wierszy AS VARCHAR)+' wiersz(y).';

-- Wstawianie danych do tabeli 'obiekty'
INSERT INTO obiekty (dzielnica_id, kategoria_id, nazwa, adres, dzienna_stawka_najmu, obecnie_wynajete)
  SELECT d.id dzielnica_id,
    k.id kategoria_id,
    (SELECT TOP 1 nazwa from @NAZWY WHERE d.id IS NOT NULL AND k.id IS NOT NULL ORDER BY NewID()) nazwa,
    (SELECT TOP 1 adres from @ADRESY WHERE d.id IS NOT NULL AND k.id IS NOT NULL ORDER BY NewID()) adres,
    (SELECT TOP 1 stawka from @STAWKI WHERE d.id IS NOT NULL AND k.id IS NOT NULL ORDER BY NewID()) dzienna_stawka_najmu,
    'N' obecnie_wynajete
  FROM dzielnice d
  CROSS JOIN kategorie k;

SELECT @liczba_wierszy = @@ROWCOUNT;
PRINT 'Do tabeli obiekty dodano '+CAST(@liczba_wierszy AS VARCHAR)+' wiersz(y).';

-- Wstawianie danych do tabeli 'najmy'
INSERT INTO najmy (uzytkownik_id, obiekt_id, data_rozpoczecia, data_zakonczenia, koszt)
  SELECT TOP 50 PERCENT
    (SELECT TOP 1 id from uzytkownicy WHERE o.id IS NOT NULL ORDER BY NewID()) uzytkownik_id,
    o.id obiekt_id,
    DATEADD(DAY, (ABS(CHECKSUM(NewId())) % 15 + 15) * -1, GETDATE()) data_rozpoczecia,
    DATEADD(DAY, (ABS(CHECKSUM(NewId())) % 8 + 1) * -1, GETDATE()) data_zakonczenia,
    NULL koszt
  FROM obiekty o
  ORDER BY NewID();

SELECT @liczba_wierszy = @@ROWCOUNT;

INSERT INTO najmy (uzytkownik_id, obiekt_id, data_rozpoczecia, data_zakonczenia, koszt)
  SELECT TOP 25 PERCENT
    (SELECT TOP 1 id from uzytkownicy WHERE o.id IS NOT NULL ORDER BY NewID()) uzytkownik_id,
    o.id obiekt_id,
    DATEADD(DAY, (ABS(CHECKSUM(NewId())) % 5) * -1, GETDATE()) data_rozpoczecia,
    NULL data_zakonczenia,
    NULL koszt
  FROM obiekty o
  ORDER BY NewID();

SELECT @liczba_wierszy = @liczba_wierszy + @@ROWCOUNT;
PRINT 'Do tabeli najmy dodano '+CAST(@liczba_wierszy AS VARCHAR)+' wiersz(y).';