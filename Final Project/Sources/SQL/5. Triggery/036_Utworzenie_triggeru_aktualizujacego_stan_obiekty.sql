CREATE TRIGGER aktualizuj_stan_obiektu
  ON najmy
  AFTER INSERT, UPDATE
  AS
  BEGIN
    UPDATE obiekty
      SET obecnie_wynajete = IIF(i.data_zakonczenia IS NULL, 'T', 'N')
      FROM obiekty o
      JOIN najmy n ON o.id = n.obiekt_id
      JOIN inserted i ON n.id = i.id
  END
GO;

---~~~

DROP TRIGGER aktualizuj_stan_obiektu;
GO;