CREATE PROCEDURE wynajmij_obiekt
  @obiekt_id INT
  WITH EXECUTE AS OWNER
  AS
    IF NOT EXISTS(SELECT * FROM obiekty WHERE id = @obiekt_id)
      RETURN 2;

    IF EXISTS(SELECT * FROM obiekty WHERE id = @obiekt_id AND obecnie_wynajete = 't')
      RETURN 3;

    EXECUTE AS CALLER;
    DECLARE @login VARCHAR(75);
    SELECT @login = CURRENT_USER;
    REVERT;

    BEGIN TRANSACTION;
    INSERT INTO najmy (uzytkownik_id, obiekt_id, data_rozpoczecia, data_zakonczenia, koszt)
      VALUES ((SELECT u.id FROM dbo.uzytkownicy u WHERE u.login COLLATE SQL_Latin1_General_CP1_CS_AS = @login COLLATE SQL_Latin1_General_CP1_CS_AS), @obiekt_id, DEFAULT, NULL, NULL);

    IF @@ERROR<>0
      GOTO BLAD;

    COMMIT TRANSACTION;
    RETURN 0;

    BLAD:
      ROLLBACK TRANSACTION;
      RETURN 1;
GO;

GRANT EXECUTE ON wynajmij_obiekt TO uzytkownicy_systemu;
GO;

---~~~

REVOKE EXECUTE ON wynajmij_obiekt TO uzytkownicy_systemu;
GO;

DROP PROCEDURE wynajmij_obiekt;
GO;