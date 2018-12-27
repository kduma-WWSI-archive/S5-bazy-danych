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

DECLARE @ADRESY TABLE (adres VARCHAR(20));
INSERT INTO @ADRESY VALUES ('Adres 1'),('Adres 2'),('Adres 3'),('Adres 4');

DECLARE @NAZWY TABLE (nazwa VARCHAR(20));
INSERT INTO @NAZWY VALUES ('Nazwa 1'),('Nazwa 2'),('Nazwa 3'),('Nazwa 4');

DECLARE @STAWKI TABLE (stawka DECIMAL(10, 2));
INSERT INTO @STAWKI VALUES (120),(149.99),(64.05),(25.35);



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
EXEC utworz_uzytkownika
  @login = 'login_1',
  @nazwisko = 'Jan',
  @imie = 'Kowalski',
  @wiek = 25,
  @adres = 'Ul. Kowalska 23, 02-001, Warszawa',
  @telefon = '+48 625 548 874',
  @plec = 'M',
  @haslo = 'yourStrong(!)Password';

EXEC utworz_uzytkownika
  @login = 'login_2',
  @nazwisko = 'Ewa',
  @imie = 'Nowak',
  @wiek = 45,
  @adres = 'Ul. Warszawska 23, 11-111, Kraków',
  @telefon = '+48 222 111 333',
  @plec = 'K',
  @haslo = 'yourStrong(!)Password';

EXEC utworz_uzytkownika
  @login = 'login_3',
  @nazwisko = 'Ignacy',
  @imie = 'Grzeszczak',
  @wiek = 45,
  @adres = 'Ul. Krakowska 23, 33-666, Kielce',
  @telefon = '+48 864 645 328',
  @plec = 'M',
  @haslo = 'yourStrong(!)Password';

EXEC utworz_uzytkownika
  @login = 'login_4',
  @nazwisko = 'Julia',
  @imie = 'Paderewska',
  @wiek = 45,
  @adres = 'Ul. Ostatnia 89, 67-125, Grudziądz',
  @telefon = '+48 852 147 993',
  @plec = 'K',
  @haslo = 'yourStrong(!)Password';

PRINT 'Do tabeli uzytkownicy dodano 4 wiersz(y).';

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