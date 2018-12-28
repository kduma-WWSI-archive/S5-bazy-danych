DECLARE @liczba INT;

SELECT @liczba = COUNT(*)
  FROM uzytkownicy

PRINT '+' + REPLICATE('-', 28 + DATALENGTH(CONVERT(VARCHAR, @liczba))) + '+'
PRINT '| W bazie jest ' + CONVERT(VARCHAR, @liczba) + ' uzytkownikow |'
PRINT '+' + REPLICATE('-', 28 + DATALENGTH(CONVERT(VARCHAR, @liczba))) + '+'



DECLARE @etykieta VARCHAR(MAX);
DECLARE @id INT;
DECLARE @wiersz VARCHAR(MAX);
DECLARE @suma DECIMAL(15,2);

DECLARE uzytkownicy_kursor CURSOR LOCAL FOR
  SELECT u.id, dbo.adresowka(u.id) etykieta
  FROM uzytkownicy u;

OPEN uzytkownicy_kursor;
FETCH uzytkownicy_kursor INTO @id, @etykieta;
WHILE @@FETCH_STATUS = 0
BEGIN
  PRINT CHAR(12) + 'Klient: ' + CHAR(13) + @etykieta;

  DECLARE najmy_kursor CURSOR LOCAL FOR
    SELECT CONCAT(
    '| ',
      CAST(o.nazwa AS CHAR(30)),
      ' | ',
      CAST(n.data_rozpoczecia AS CHAR(20)),
      ' | ',
      CAST(n.data_zakonczenia AS CHAR(20)),
      ' | ',
      REPLICATE(' ', 10 - DATALENGTH(CAST(n.koszt AS VARCHAR))),
      CAST(n.koszt AS VARCHAR),
      ' |'
    )
    FROM najmy n
    JOIN obiekty o on n.obiekt_id = o.id
    WHERE uzytkownik_id = @id
          AND data_zakonczenia IS NOT NULL
    ORDER BY data_rozpoczecia;

  PRINT '+' + REPLICATE('-', 32) + '+' + REPLICATE('-', 22) + '+' + REPLICATE('-', 22) + '+' + REPLICATE('-', 12) + '+'
  PRINT '| Nazwa Obiektu' + REPLICATE(' ', 30-DATALENGTH('Nazwa Obiektu')) + ' | Od' + REPLICATE(' ', 20-DATALENGTH('Od')) + ' | Do' + REPLICATE(' ', 20-DATALENGTH('Do')) + ' | Koszt' + REPLICATE(' ', 10-DATALENGTH('Koszt')) + ' |'
  PRINT '+' + REPLICATE('-', 32) + '+' + REPLICATE('-', 22) + '+' + REPLICATE('-', 22) + '+' + REPLICATE('-', 12) + '+'
  OPEN najmy_kursor;
  FETCH najmy_kursor INTO @wiersz;
  WHILE @@FETCH_STATUS = 0
  BEGIN
    PRINT @wiersz;
    PRINT '+' + REPLICATE('-', 32) + '+' + REPLICATE('-', 22) + '+' + REPLICATE('-', 22) + '+' + REPLICATE('-', 12) + '+'
    FETCH najmy_kursor INTO @wiersz;
  END
  CLOSE najmy_kursor;
  DEALLOCATE najmy_kursor;

  SELECT @suma = SUM(koszt)
    FROM najmy n
    WHERE uzytkownik_id = @id
          AND data_zakonczenia IS NOT NULL

  PRINT '|' + REPLICATE(' ', 32) + ' ' + REPLICATE(' ', 22) + '|' + REPLICATE(' ', 22-DATALENGTH('Suma: ')) + 'Suma: | ' + REPLICATE(' ', 10 - DATALENGTH(CAST(@suma AS VARCHAR))) + CAST(@suma AS VARCHAR) + ' |'
  PRINT '|' + REPLICATE(' ', 32) + ' ' + REPLICATE(' ', 22) + '+' + REPLICATE('-', 22) + '+' + REPLICATE('-', 12) + '+'

  FETCH uzytkownicy_kursor INTO @id, @etykieta;
END
CLOSE uzytkownicy_kursor;