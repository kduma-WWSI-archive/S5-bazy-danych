-- W1: nazwisko i imię klienta, datę wypożyczenia i datę zwrotu kasety oraz tytuł filmu. Wynik prezentacji
-- widoku ustawić rosnąco według nazwiska, imienia i daty wypożyczenia.

IF EXISTS(SELECT *
              FROM sys.views
              WHERE name = N'lista_wypozyczen')
  BEGIN
    PRINT '+---------------------------------+'
    PRINT '|Odświeżam widok: lista_wypozyczen|'
    PRINT '+---------------------------------+'
    DROP VIEW lista_wypozyczen
  END
ELSE
  BEGIN
    PRINT '+------------------------------+'
    PRINT '|Tworzę widok: lista_wypozyczen|'
    PRINT '+------------------------------+'
  END
GO 

CREATE VIEW lista_wypozyczen	
  AS
    SELECT nazwisko, imie, data_wypozyczenia, data_zwrotu, tytul
        FROM wypozyczenia w
               JOIN klienci k ON w.klient_id = k.id
               JOIN kasety k2 ON w.kaseta_id = k2.id
               JOIN filmy f ON k2.film_id = f.id
GO

-- W2: Identyfikator Kasety, Tytuł filmu na tej kasecie i ilość wypożyczeń tej kasety, Wynik prezentacji
-- widoku ustawić malejąco według identyfikatora kasety

IF EXISTS(SELECT *
              FROM sys.views
              WHERE name = N'kasety_wypozyczenia')
  BEGIN
    PRINT '+------------------------------------+'
    PRINT '|Odświeżam widok: kasety_wypozyczenia|'
    PRINT '+------------------------------------+'
    DROP VIEW kasety_wypozyczenia
  END
ELSE
  BEGIN
    PRINT '+---------------------------------+'
    PRINT '|Tworzę widok: kasety_wypozyczenia|'
    PRINT '+---------------------------------+'
  END
GO 

CREATE VIEW kasety_wypozyczenia
  AS
    SELECT k.id, tytul, ( SELECT COUNT(*) FROM wypozyczenia w WHERE w.kaseta_id = k.id ) liczba_wypozyczen
        FROM kasety k
               JOIN filmy f ON k.film_id = f.id
GO

-- Klienci ktorzy nic nie wypozyczyli

IF EXISTS(SELECT *
              FROM sys.views
              WHERE name = N'klienci_duchy')
  BEGIN
    PRINT '+------------------------------+'
    PRINT '|Odświeżam widok: klienci_duchy|'
    PRINT '+------------------------------+'
    DROP VIEW klienci_duchy
  END
ELSE
  BEGIN
    PRINT '+---------------------------+'
    PRINT '|Tworzę widok: klienci_duchy|'
    PRINT '+---------------------------+'
  END
GO 

CREATE VIEW klienci_duchy
  AS
    SELECT nazwisko, imie
        FROM klienci k
        WHERE ( SELECT COUNT(*) FROM wypozyczenia w WHERE w.klient_id = k.id ) = 0
GO  

-- Klienciktorzy wyporzyczyli cos wczesniej niz miesiac temu

IF EXISTS(SELECT *
              FROM sys.views
              WHERE name = N'klienci_nieaktywni')
  BEGIN
    PRINT '+-----------------------------------+'
    PRINT '|Odświeżam widok: klienci_nieaktywni|'
    PRINT '+-----------------------------------+'
    DROP VIEW klienci_nieaktywni
  END
ELSE
  BEGIN
    PRINT '+--------------------------------+'
    PRINT '|Tworzę widok: klienci_nieaktywni|'
    PRINT '+--------------------------------+'
  END
GO 

CREATE VIEW klienci_nieaktywni
  AS
    SELECT nazwisko,
           imie,
           CAST(( SELECT MAX(data_wypozyczenia) data_wypozyczenia FROM wypozyczenia w WHERE w.klient_id = k.id ) AS
                DATE) ostatnie_wypozyczenie
        FROM klienci k
        WHERE ( SELECT MAX(data_wypozyczenia) data_wypozyczenia FROM wypozyczenia w WHERE w.klient_id = k.id ) <
              dateadd(MONTH, -1, getdate())


GO

-- Filmy ktorych nikt nie wypozyczyl

IF EXISTS(SELECT *
              FROM sys.views
              WHERE name = N'nieruszane_filmy')
  BEGIN
    PRINT '+---------------------------------+'
    PRINT '|Odświeżam widok: nieruszane_filmy|'
    PRINT '+---------------------------------+'
    DROP VIEW nieruszane_filmy
  END
ELSE
  BEGIN
    PRINT '+------------------------------+'
    PRINT '|Tworzę widok: nieruszane_filmy|'
    PRINT '+------------------------------+'
  END
GO 

CREATE VIEW nieruszane_filmy
  AS
    SELECT tytul
        FROM kasety_wypozyczenia w
        GROUP BY tytul
        HAVING SUM(liczba_wypozyczen) = 0
GO