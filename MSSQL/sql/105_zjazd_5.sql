-- Utworzyć tabele komunikatywyzwalaczy

IF EXISTS(SELECT * FROM sys.tables WHERE name = 'komunikaty_wyzwalaczy')
	BEGIN
	PRINT '+------------------------------------------+'
	PRINT '|Tabela już istnieje: komunikaty_wyzwalaczy|'
	PRINT '+------------------------------------------+'
	END
ELSE
	BEGIN
	CREATE TABLE komunikaty_wyzwalaczy
	(
		id INT IDENTITY(1,1),
		tabela VARCHAR(30),
		kolumna VARCHAR(15),
		operacja VARCHAR(10),
		stara_wartosc VARCHAR(255),
		nowa_wartosc VARCHAR(255),
		czas SMALLDATETIME DEFAULT (GETDATE()),
		uzytkownik VARCHAR(20) DEFAULT (USER)
	)

	PRINT '+----------------------------------------------+'
	PRINT '|Tabela została utwożona: komunikaty_wyzwalaczy|'
	PRINT '+----------------------------------------------+'
	END
GO

-- Utworzyć przykładowe (z prezentacji ) wyzwalacze i sprawdzić ich działanie

IF EXISTS(SELECT * FROM sys.triggers WHERE name = 'po_aktualizacji_rodzaju')
	BEGIN
	PRINT '+-----------------------------------------------+'
	PRINT '|Wyzwalacz już istnieje: po_aktualizacji_rodzaju|'
	PRINT '+-----------------------------------------------+'
	END
ELSE
	BEGIN
	EXEC dbo.sp_executesql @statement = N'
	CREATE TRIGGER po_aktualizacji_rodzaju
		ON rodzaje
		AFTER UPDATE
		AS
		INSERT INTO komunikaty_wyzwalaczy (tabela, kolumna, operacja, stara_wartosc, nowa_wartosc)
		VALUES (''rodzaje'', ''dowolna'', ''UPDATE'', ''Stary rodzaj'', ''Nowy rodzaj'')
	'
	PRINT '+--------------------------------------------------+'
	PRINT '|Wyzwalacz został utwożony: po_aktualizacji_rodzaju|'
	PRINT '+--------------------------------------------------+'
	END
GO

IF EXISTS(SELECT * FROM sys.triggers WHERE name = 'po_aktualizacji_klienta')
	BEGIN
	PRINT '+-----------------------------------------------+'
	PRINT '|Wyzwalacz już istnieje: po_aktualizacji_klienta|'
	PRINT '+-----------------------------------------------+'
	END
ELSE
	BEGIN
	EXEC dbo.sp_executesql @statement = N'
	CREATE TRIGGER po_aktualizacji_klienta
		ON klienci
		AFTER UPDATE
		AS
		BEGIN
			IF UPDATE (nazwisko)
				INSERT INTO komunikaty_wyzwalaczy (tabela, kolumna, operacja, stara_wartosc, nowa_wartosc)
				VALUES (''klienci'', ''nazwisko'', ''UPDATE'', ''Stare nazwisko'', ''Nowe nazwisko'')
			IF UPDATE (imie)
				INSERT INTO komunikaty_wyzwalaczy (tabela, kolumna, operacja, stara_wartosc, nowa_wartosc)
				VALUES (''klienci'', ''imie'', ''UPDATE'', ''Stare imie'', ''Nowe imie'')
		END
	'
	PRINT '+--------------------------------------------------+'
	PRINT '|Wyzwalacz został utwożony: po_aktualizacji_klienta|'
	PRINT '+--------------------------------------------------+'
	END
GO

IF EXISTS(SELECT * FROM sys.triggers WHERE name = 'po_aktualizacji_kraju')
	BEGIN
	PRINT '+---------------------------------------------+'
	PRINT '|Wyzwalacz już istnieje: po_aktualizacji_kraju|'
	PRINT '+---------------------------------------------+'
	END
ELSE
	BEGIN
	EXEC dbo.sp_executesql @statement = N'
	CREATE TRIGGER po_aktualizacji_kraju
		ON kraje
		AFTER UPDATE
		AS
		IF UPDATE (nazwa)
		BEGIN
			DECLARE @kraj_OLD VARCHAR(15), @kraj_NEW VARCHAR(15)
			SELECT @kraj_OLD = nazwa FROM deleted
			SELECT @kraj_NEW = nazwa FROM inserted
			INSERT INTO komunikaty_wyzwalaczy (tabela, kolumna, operacja, stara_wartosc, nowa_wartosc)
			VALUES (''kraje'', ''nazwa'', ''UPDATE'', @kraj_OLD, @kraj_NEW)
		END
	'
	PRINT '+------------------------------------------------+'
	PRINT '|Wyzwalacz został utwożony: po_aktualizacji_kraju|'
	PRINT '+------------------------------------------------+'
	END
GO

IF EXISTS(SELECT * FROM sys.triggers WHERE name = 'po_wstawieniu_kraju')
	BEGIN
	PRINT '+-------------------------------------------+'
	PRINT '|Wyzwalacz już istnieje: po_wstawieniu_kraju|'
	PRINT '+-------------------------------------------+'
	END
ELSE
	BEGIN
	EXEC dbo.sp_executesql @statement = N'
	CREATE TRIGGER po_wstawieniu_kraju
		ON kraje
		AFTER INSERT
		AS
		IF UPDATE (nazwa)
		BEGIN
			DECLARE @kraj_NEW VARCHAR(15)
			SELECT @kraj_NEW = nazwa FROM inserted
			INSERT INTO komunikaty_wyzwalaczy (tabela, kolumna, operacja, stara_wartosc, nowa_wartosc)
			VALUES (''kraje'', ''nazwa'', ''INSERT'', NULL, @kraj_NEW)
		END
	'
	PRINT '+----------------------------------------------+'
	PRINT '|Wyzwalacz został utwożony: po_wstawieniu_kraju|'
	PRINT '+----------------------------------------------+'
	END
GO

IF EXISTS(SELECT * FROM sys.triggers WHERE name = 'po_usunieciu_kraju')
	BEGIN
	PRINT '+------------------------------------------+'
	PRINT '|Wyzwalacz już istnieje: po_usunieciu_kraju|'
	PRINT '+------------------------------------------+'
	END
ELSE
	BEGIN
	EXEC dbo.sp_executesql @statement = N'
	CREATE TRIGGER po_usunieciu_kraju
		ON kraje
		AFTER DELETE
		AS
		BEGIN
			DECLARE @kraj_OLD VARCHAR(15)
			SELECT @kraj_OLD = nazwa FROM deleted
			INSERT INTO komunikaty_wyzwalaczy (tabela, kolumna, operacja, stara_wartosc, nowa_wartosc)
			VALUES (''kraje'', ''nazwa'', ''DELETE'', @kraj_OLD, NULL)
		END
	'
	PRINT '+---------------------------------------------+'
	PRINT '|Wyzwalacz został utwożony: po_usunieciu_kraju|'
	PRINT '+---------------------------------------------+'
	END
GO

-- Utworzyć trigger obliczający kwotę do zapłaty za wypożyczenie

IF EXISTS(SELECT * FROM sys.triggers WHERE name = 'wylicz_kwote_do_zaplaty')
	BEGIN
	PRINT '+-----------------------------------------------+'
	PRINT '|Wyzwalacz już istnieje: wylicz_kwote_do_zaplaty|'
	PRINT '+-----------------------------------------------+'
	END
ELSE
	BEGIN
	EXEC dbo.sp_executesql @statement = N'
		CREATE TRIGGER wylicz_kwote_do_zaplaty
			ON wypozyczenia
			AFTER UPDATE
			AS
			BEGIN
				DECLARE @klient_id int,
				  @kaseta_id int,
				  @data_wypozyczenia SMALLDATETIME,
				  @data_zwrotu_OLD SMALLDATETIME,
				  @data_zwrotu_NEW SMALLDATETIME,
				  @cena_kasety DECIMAL(6,2)

				IF UPDATE (data_zwrotu)
				  BEGIN
						SELECT @klient_id = klient_id, @kaseta_id = kaseta_id,
						       @data_wypozyczenia = data_wypozyczenia,
						       @data_zwrotu_old = data_zwrotu
				    FROM deleted

				    SELECT @data_zwrotu_new = data_zwrotu FROM inserted

				    SELECT @cena_kasety = cena FROM kasety k
				      JOIN filmy f ON k.film_id = f.id
				    WHERE k.id = @kaseta_id

				    UPDATE wypozyczenia
				    	SET kwota = DATEDIFF(DAY, @data_wypozyczenia, @data_zwrotu_new)*@cena_kasety
							WHERE klient_id = @klient_id
							AND kaseta_id = @kaseta_id
							AND data_wypozyczenia = @data_wypozyczenia
					END
			END
	'
	PRINT '+--------------------------------------------------+'
	PRINT '|Wyzwalacz został utwożony: wylicz_kwote_do_zaplaty|'
	PRINT '+--------------------------------------------------+'
	END
GO

-- Wykonać przykładowe (z prezentacji) ćwiczenie na funkcje skalarną i sprawdzić jej działanie

IF OBJECT_ID('pelna_nazwa_osoby', 'FN') IS NOT NULL
	BEGIN
	PRINT '+---------------------------------------+'
	PRINT '|Funkcja już istnieje: pelna_nazwa_osoby|'
	PRINT '+---------------------------------------+'
	END
ELSE
	BEGIN
	EXEC dbo.sp_executesql @statement = N'
		CREATE FUNCTION pelna_nazwa_osoby (@klient_id int)
		RETURNS NVARCHAR(70)
			AS
			BEGIN
				DECLARE @pelna_nazwa NVARCHAR(70)

				SELECT @pelna_nazwa = nazwisko + '' '' + imie + '' - '' + adres
					FROM klienci
					WHERE id = @klient_id

				RETURN (@pelna_nazwa)
			END
	'
	PRINT '+-------------------------------------------+'
	PRINT '|Funkcja została utwożona: pelna_nazwa_osoby|'
	PRINT '+-------------------------------------------+'
	END
GO

-- Wykonać przykładowe (z prezentacji) ćwiczenie na funkcję tabelarną i sprawdzić jej działanie

IF OBJECT_ID('kasety_danego_filmu', 'IF') IS NOT NULL
	BEGIN
	PRINT '+-----------------------------------------+'
	PRINT '|Funkcja już istnieje: kasety_danego_filmu|'
	PRINT '+-----------------------------------------+'
	END
ELSE
	BEGIN
	EXEC dbo.sp_executesql @statement = N'
		CREATE FUNCTION kasety_danego_filmu (@film_id int)
			RETURNS TABLE
			  AS
				RETURN (
					SELECT k.id, tytul
						FROM kasety k
				  	JOIN filmy f ON k.film_id = f.id
				  	WHERE f.id = @film_id
				)
	'
	PRINT '+---------------------------------------------+'
	PRINT '|Funkcja została utwożona: kasety_danego_filmu|'
	PRINT '+---------------------------------------------+'
	END
GO

-- Napisać trigger zmieniający status kasety w zależności od tego czy jest wypożyczenie czy zwrot do wypożyczalni kasety

IF EXISTS(SELECT * FROM sys.triggers WHERE name = 'po_wstawieniu_wypozyczenia')
	BEGIN
	PRINT '+--------------------------------------------------+'
	PRINT '|Wyzwalacz już istnieje: po_wstawieniu_wypozyczenia|'
	PRINT '+--------------------------------------------------+'
	END
ELSE
	BEGIN
	EXEC dbo.sp_executesql @statement = N'
		CREATE TRIGGER po_wstawieniu_wypozyczenia
			ON wypozyczenia
			AFTER INSERT
			AS
			BEGIN
				DECLARE @klient_id int,
					@kaseta_id int,
					@data_wypozyczenia SMALLDATETIME,
					@data_zwrotu SMALLDATETIME

				IF UPDATE (data_zwrotu)
					BEGIN
						SELECT @kaseta_id = kaseta_id,
									 @data_zwrotu = data_zwrotu
						FROM inserted

						UPDATE kasety
							SET status = IIF(@data_zwrotu IS NULL, ''W'', ''K'')
							WHERE id = @kaseta_id
					END
			END
	'
	PRINT '+-----------------------------------------------------+'
	PRINT '|Wyzwalacz został utwożony: po_wstawieniu_wypozyczenia|'
	PRINT '+-----------------------------------------------------+'
	END
GO

IF EXISTS(SELECT * FROM sys.triggers WHERE name = 'po_aktualizacji_wypozyczenia')
	BEGIN
	PRINT '+----------------------------------------------------+'
	PRINT '|Wyzwalacz już istnieje: po_aktualizacji_wypozyczenia|'
	PRINT '+----------------------------------------------------+'
	END
ELSE
	BEGIN
	EXEC dbo.sp_executesql @statement = N'
		CREATE TRIGGER po_aktualizacji_wypozyczenia
					ON wypozyczenia
					AFTER UPDATE
					AS
					BEGIN
						DECLARE @klient_id int,
							@kaseta_id int,
							@data_wypozyczenia SMALLDATETIME,
							@data_zwrotu SMALLDATETIME

						IF UPDATE (data_zwrotu)
							BEGIN
								SELECT @kaseta_id = kaseta_id,
											 @data_zwrotu = data_zwrotu
								FROM inserted

								UPDATE kasety
									SET status = IIF(@data_zwrotu IS NULL, ''W'', ''K'')
									WHERE id = @kaseta_id
							END
					END
	'
	PRINT '+-------------------------------------------------------+'
	PRINT '|Wyzwalacz został utwożony: po_aktualizacji_wypozyczenia|'
	PRINT '+-------------------------------------------------------+'
	END
GO

-- Napisać funkcję
-- wejście -> tytuł filmu,
-- wynik funkcji -> ile krajów wykonało ten film

IF OBJECT_ID('kraje_filmu', 'FN') IS NOT NULL
  BEGIN
    PRINT '+---------------------------------+'
    PRINT '|Funkcja już istnieje: kraje_filmu|'
    PRINT '+---------------------------------+'
  END
ELSE
  BEGIN
    EXEC dbo.sp_executesql @statement = N'
		CREATE FUNCTION kraje_filmu (@tytul_filmu NVARCHAR(70))
		RETURNS NVARCHAR(70)
			AS
			BEGIN
				DECLARE @liczba_krajow int

        SELECT @liczba_krajow = count(*)
          FROM filmy f
          JOIN filmy_kraje k on f.id = k.film_id
          WHERE f.tytul = @tytul_filmu

				RETURN (@liczba_krajow)
			END
	'
    PRINT '+-------------------------------------+'
    PRINT '|Funkcja została utwożona: kraje_filmu|'
    PRINT '+-------------------------------------+'
  END
GO

-- Napisać funkcję:
-- wejście -> nr kasety (idkasety),
-- wynik funkcji -> tytuł filmu na tej kasecie

IF OBJECT_ID('film_na_kasecie', 'FN') IS NOT NULL
  BEGIN
    PRINT '+-------------------------------------+'
    PRINT '|Funkcja już istnieje: film_na_kasecie|'
    PRINT '+-------------------------------------+'
  END
ELSE
  BEGIN
    EXEC dbo.sp_executesql @statement = N'
		CREATE FUNCTION film_na_kasecie (@numer_kasety int)
		RETURNS NVARCHAR(70)
			AS
			BEGIN
				DECLARE @tytul_filmu NVARCHAR(70)

        SELECT @tytul_filmu = tytul
          FROM filmy f
          JOIN kasety k on f.id = k.film_id
          WHERE k.id = @numer_kasety

				RETURN (@tytul_filmu)
			END
	'
    PRINT '+-----------------------------------------+'
    PRINT '|Funkcja została utwożona: film_na_kasecie|'
    PRINT '+-----------------------------------------+'
  END
GO

-- Napisać funkcję:
-- wejście -> nazwisko reżysera,
-- wynik funkcji -> tytuły filmów (w bazie) tego reżysera

IF OBJECT_ID('filmy_danego_rezysera', 'IF') IS NOT NULL
  BEGIN
    PRINT '+-------------------------------------------+'
    PRINT '|Funkcja już istnieje: filmy_danego_rezysera|'
    PRINT '+-------------------------------------------+'
  END
ELSE
  BEGIN
    EXEC dbo.sp_executesql @statement = N'
		CREATE FUNCTION filmy_danego_rezysera (@nazwisko_rezysera nvarchar(70))
			RETURNS TABLE
			  AS
				RETURN (
          SELECT tytul
            FROM rezyser r
            JOIN filmy f on r.id = f.rezyser_id
            WHERE r.nazwisko = @nazwisko_rezysera
				)
	'
    PRINT '+-----------------------------------------------+'
    PRINT '|Funkcja została utwożona: filmy_danego_rezysera|'
    PRINT '+-----------------------------------------------+'
  END
GO

-- Napisać funkcję:
-- wejście -> nazwisko klienta,
-- wynik funkcji -> wszystkie wypożyczenia klienta (data wypożyczenia i data zwrotu kasety)

IF OBJECT_ID('wypozyczenia_danego_klienta', 'IF') IS NOT NULL
  BEGIN
    PRINT '+-------------------------------------------------+'
    PRINT '|Funkcja już istnieje: wypozyczenia_danego_klienta|'
    PRINT '+-------------------------------------------------+'
  END
ELSE
  BEGIN
    EXEC dbo.sp_executesql @statement = N'
		CREATE FUNCTION wypozyczenia_danego_klienta (@nazwisko_klienta nvarchar(70))
			RETURNS TABLE
			  AS
				RETURN (
          SELECT data_wypozyczenia, data_zwrotu
            FROM wypozyczenia w
            JOIN klienci k on w.klient_id = k.id
            WHERE k.nazwisko = @nazwisko_klienta
				)
	'
    PRINT '+-----------------------------------------------------+'
    PRINT '|Funkcja została utwożona: wypozyczenia_danego_klienta|'
    PRINT '+-----------------------------------------------------+'
  END
GO

-- Napisać własną funkcję tabelarną (napisać czego dotyczy i uruchomić)
--
-- Funkcja zwraca filmy danego rodzaju

IF OBJECT_ID('filmy_danego_rodzaju', 'IF') IS NOT NULL
  BEGIN
    PRINT '+------------------------------------------+'
    PRINT '|Funkcja już istnieje: filmy_danego_rodzaju|'
    PRINT '+------------------------------------------+'
  END
ELSE
  BEGIN
    EXEC dbo.sp_executesql @statement = N'
		CREATE FUNCTION filmy_danego_rodzaju (@nazwa_rodzaju nvarchar(70))
			RETURNS TABLE
			  AS
				RETURN (
          SELECT tytul
            FROM rodzaje r
            JOIN filmy_rodzaje fr on r.id = fr.rodzaj_id
            JOIN filmy f on fr.film_id = f.id
            WHERE r.nazwa = @nazwa_rodzaju
				)
	'
    PRINT '+----------------------------------------------+'
    PRINT '|Funkcja została utwożona: filmy_danego_rodzaju|'
    PRINT '+----------------------------------------------+'
  END
GO

-- Napisać własną funkcję skalarną (napisać czego dotyczy i uruchomić)
--
-- Funkcja zwraca liczbę filmów danego rodzaju

IF OBJECT_ID('liczba_filmow_danego_rodzaju', 'FN') IS NOT NULL
  BEGIN
    PRINT '+--------------------------------------------------+'
    PRINT '|Funkcja już istnieje: liczba_filmow_danego_rodzaju|'
    PRINT '+--------------------------------------------------+'
  END
ELSE
  BEGIN
    EXEC dbo.sp_executesql @statement = N'
		CREATE FUNCTION liczba_filmow_danego_rodzaju (@nazwa_rodzaju NVARCHAR(70))
		RETURNS NVARCHAR(70)
			AS
			BEGIN
				DECLARE @liczba_filmow int

        SELECT @liczba_filmow = count(*)
          FROM dbo.filmy_danego_rodzaju(@nazwa_rodzaju)

				RETURN (@liczba_filmow)
			END
	'
    PRINT '+------------------------------------------------------+'
    PRINT '|Funkcja została utwożona: liczba_filmow_danego_rodzaju|'
    PRINT '+------------------------------------------------------+'
  END
GO











SELECT * FROM wypozyczenia
GO

SELECT * FROM kasety
GO

INSERT INTO wypozyczenia (klient_id, kaseta_id, data_wypozyczenia, data_zwrotu, kwota)
VALUES (1, 1, GETDATE(), NULL, NULL)
GO

SELECT * FROM wypozyczenia
GO

SELECT * FROM kasety
GO

UPDATE wypozyczenia
  SET data_zwrotu = DATEADD(day, 1, GETDATE())
  WHERE klient_id = 1 AND kaseta_id = 1
GO

SELECT * FROM wypozyczenia
GO

SELECT * FROM kasety
GO

SELECT dbo.kraje_filmu('The Magnificent Seven')
GO

SELECT dbo.film_na_kasecie(1)
GO

SELECT * FROM dbo.filmy_danego_rezysera('Zucker')
GO

SELECT * FROM dbo.wypozyczenia_danego_klienta('Hale')
GO

SELECT * FROM dbo.filmy_danego_rodzaju('Komedia')
GO

SELECT dbo.liczba_filmow_danego_rodzaju('Komedia')
GO














SELECT * FROM komunikaty_wyzwalaczy
GO

UPDATE rodzaje SET nazwa = 'Film Komediowy' WHERE id = 1
GO

SELECT * FROM komunikaty_wyzwalaczy
GO

UPDATE klienci SET imie = 'Herald', nazwisko = 'Cunning''s' WHERE id = 2
GO

SELECT * FROM komunikaty_wyzwalaczy
GO

UPDATE kraje SET nazwa = 'Stany Zjednoczone' WHERE id = 1
GO

SELECT * FROM komunikaty_wyzwalaczy
GO

INSERT INTO kraje (nazwa) VALUES ('Portugalia')
GO

SELECT * FROM komunikaty_wyzwalaczy
GO

DELETE FROM kraje WHERE nazwa = 'Portugalia'
GO

SELECT * FROM komunikaty_wyzwalaczy
GO





SELECT * FROM wypozyczenia
GO

INSERT INTO wypozyczenia (klient_id, kaseta_id, data_wypozyczenia, data_zwrotu, kwota)
VALUES (2, 2, GETDATE(), NULL, NULL)
GO

SELECT * FROM wypozyczenia
GO

SELECT * FROM kasety
GO

UPDATE wypozyczenia
  SET data_zwrotu = DATEADD(day, 1, GETDATE())
  WHERE klient_id = 2 AND kaseta_id = 2
GO

SELECT * FROM wypozyczenia
GO





SELECT * FROM dbo.kasety_danego_filmu(1)
--SELECT * FROM z501_03.kasety_danego_filmu(1)
GO





SELECT dbo.pelna_nazwa_osoby(1)
--SELECT z501_03.pelna_nazwa_osoby(1)
GO