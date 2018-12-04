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
		GO
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

SELECT * FROM dbo.kasety_danego_filmu(1) GO

SELECT dbo.pelna_nazwa_osoby(1)
	GO