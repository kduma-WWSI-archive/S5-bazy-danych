CREATE FUNCTION koszt_najmu_obiektu (@obiekt_id INT, @liczba_dni INT)
  RETURNS DECIMAL(15, 2)
  AS
  BEGIN
		DECLARE @dzienna_stawka DECIMAL(10,2);

    SELECT @dzienna_stawka = dzienna_stawka_najmu
      FROM obiekty o
      WHERE id = @obiekt_id;

    RETURN @liczba_dni*@dzienna_stawka;
  END
GO;

---~~~

DROP FUNCTION koszt_najmu_obiektu;
GO;