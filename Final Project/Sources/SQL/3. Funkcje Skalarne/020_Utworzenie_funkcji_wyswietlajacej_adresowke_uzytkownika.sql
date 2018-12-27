CREATE FUNCTION adresowka (@uzytkownik_id INT)
  RETURNS VARCHAR(333) -- 75+75+150+30+3 = 333 - suma długości łączonych pól
  AS
  BEGIN
    DECLARE @adresowka VARCHAR(330);

    SELECT @adresowka = nazwisko + ' ' + imie + CHAR(13) + telefon + CHAR(13) + adres
      FROM uzytkownicy
      WHERE id = @uzytkownik_id;

    RETURN @adresowka;
  END
GO;

---~~~

DROP FUNCTION adresowka;
GO;