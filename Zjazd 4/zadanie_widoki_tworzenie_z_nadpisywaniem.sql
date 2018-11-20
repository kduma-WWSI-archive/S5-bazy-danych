USE kasety_501_03
;

-- W1: nazwisko i imię klienta, datę wypożyczenia i datę zwrotu kasety oraz tytuł filmu. Wynik prezentacji
-- widoku ustawić rosnąco według nazwiska, imienia i daty wypożyczenia.

IF EXISTS(SELECT *
              FROM dbo.sysobjects
              WHERE id = object_id(N'lista_wypozyczen'))
  BEGIN
    PRINT 'lista_wypozyczen: usuwam'
    DROP VIEW lista_wypozyczen
    ;

  END
GO ;

CREATE VIEW lista_wypozyczen
  AS
    SELECT nazwisko, imie, data_wypozyczenia, data_zwrotu, tytul
        FROM wypozyczenia w
               JOIN klienci k ON w.klient_id = k.id
               JOIN kasety k2 ON w.kaseta_id = k2.id
               JOIN filmy f ON k2.film_id = f.id
;

GO ;

SELECT *
    FROM lista_wypozyczen
    ORDER BY nazwisko, imie, data_wypozyczenia
;
GO ;

-- W2: Identyfikator Kasety, Tytuł filmu na tej kasecie i ilość wypożyczeń tej kasety, Wynik prezentacji
-- widoku ustawić malejąco według identyfikatora kasety

IF EXISTS(SELECT *
              FROM dbo.sysobjects
              WHERE id = object_id(N'kasety_wypozyczenia'))
  BEGIN
    PRINT 'kasety_wypozyczenia: usuwam'
    DROP VIEW kasety_wypozyczenia
    ;

  END
GO ;

CREATE VIEW kasety_wypozyczenia
  AS
    SELECT k.id, tytul, ( SELECT COUNT(*) FROM wypozyczenia w WHERE w.kaseta_id = k.id ) liczba_wypozyczen
        FROM kasety k
               JOIN filmy f ON k.film_id = f.id
;

GO ;

SELECT *
    FROM kasety_wypozyczenia
    ORDER BY id DESC
;
GO ;

-- Klienci ktorzy nic nie wypozyczyli

IF EXISTS(SELECT *
              FROM dbo.sysobjects
              WHERE id = object_id(N'klienci_duchy'))
  BEGIN
    PRINT 'klienci_duchy: usuwam'
    DROP VIEW klienci_duchy
    ;

  END
GO ;

CREATE VIEW klienci_duchy
  AS
    SELECT nazwisko, imie
        FROM klienci k
        WHERE ( SELECT COUNT(*) FROM wypozyczenia w WHERE w.klient_id = k.id ) = 0
;

GO ;

SELECT *
    FROM klienci_duchy
;
GO ;

-- Klienciktorzy wyporzyczyli cos wczesniej niz miesiac temu

IF EXISTS(SELECT *
              FROM dbo.sysobjects
              WHERE id = object_id(N'klienci_nieaktywni'))
  BEGIN
    PRINT 'klienci_nieaktywni: usuwam'
    DROP VIEW klienci_nieaktywni
    ;

  END
GO ;

CREATE VIEW klienci_nieaktywni
  AS
    SELECT nazwisko,
           imie,
           CAST(( SELECT MAX(data_wypozyczenia) data_wypozyczenia FROM wypozyczenia w WHERE w.klient_id = k.id ) AS
                DATE) ostatnie_wypozyczenie
        FROM klienci k
        WHERE ( SELECT MAX(data_wypozyczenia) data_wypozyczenia FROM wypozyczenia w WHERE w.klient_id = k.id ) <
              dateadd(MONTH, -1, getdate())
;

GO ;

SELECT *
    FROM klienci_nieaktywni
;
GO ;

-- Filmy ktorych nikt nie wypozyczyl

IF EXISTS(SELECT *
              FROM dbo.sysobjects
              WHERE id = object_id(N'nieruszane_filmy'))
  BEGIN
    PRINT 'nieruszane_filmy: usuwam'
    DROP VIEW nieruszane_filmy
    ;

  END
GO ;

CREATE VIEW nieruszane_filmy
  AS
    SELECT tytul
        FROM kasety_wypozyczenia w
        GROUP BY tytul
        HAVING SUM(liczba_wypozyczen) = 0
;

GO ;

SELECT *
    FROM nieruszane_filmy
;

GO;