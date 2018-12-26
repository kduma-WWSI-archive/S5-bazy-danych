declare @liczba INT;

SELECT @liczba = COUNT(*)
FROM klienci

PRINT '-----------------------------------------------------------'
PRINT 'Łącznie w bazie jest: ' + convert(varchar, @liczba) + ' klientów'
PRINT '-----------------------------------------------------------'

declare @maksymalna INT;

WITH a AS (
  SELECT COUNT(*) c
  FROM wypozyczenia
  GROUP BY klient_id
)
SELECT @maksymalna = MAX(c)
FROM a;

declare @wiersz varchar(max);

DECLARE KurSor CURSOR LOCAL FOR
  SELECT CONCAT(
             imie, nazwisko,
             (SELECT COUNT(*) FROM wypozyczenia WHERE klient_id = klienci.id),
             iif(
                     (SELECT COUNT(*) FROM wypozyczenia WHERE klient_id = klienci.id) = @maksymalna, '    najwięcej', '')
           )
  FROM klienci

OPEN KurSor
FETCH KurSor INTO @wiersz
WHILE @@FETCH_STATUS = 0
BEGIN
  print @wiersz
  FETCH KurSor INTO @wiersz
END
CLOSE KurSor


PRINT '-----------------------------------------------------------'
SELECT @liczba = COUNT(*)
FROM wypozyczenia
PRINT 'Łącznie jest: ' + convert(varchar, @liczba) + ' wypożyczeń'
PRINT '-----------------------------------------------------------'