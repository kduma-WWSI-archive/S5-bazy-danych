CREATE TRIGGER wylicz_koszt_najmu
  ON najmy
  AFTER INSERT, UPDATE
  AS
  BEGIN
    UPDATE najmy
      SET koszt = dbo.koszt_najmu(n.id)
      FROM najmy n
      JOIN inserted i ON n.id = i.id
      WHERE UPDATE (data_zakonczenia) OR NOT EXISTS(SELECT 1 FROM DELETED)
  END
GO;

---~~~

DROP TRIGGER wylicz_koszt_najmu;
GO;