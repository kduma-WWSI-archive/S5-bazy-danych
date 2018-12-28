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
    EXEC sp_addrolemember 'uzytkownicy_systemu', @login;

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
GO;

---~~~

DROP PROCEDURE utworz_uzytkownika;
GO;