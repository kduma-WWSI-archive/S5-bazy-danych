CREATE FUNCTION koszt_najmu (@najem_id INT)
  RETURNS DECIMAL(15, 2)
  AS
  BEGIN
		DECLARE @dzienna_stawka DECIMAL(10,2);
		DECLARE @data_rozpoczecia DATE;
		DECLARE @data_zakonczenia DATE;

    SELECT @dzienna_stawka = o.dzienna_stawka_najmu,
           @data_rozpoczecia = n.data_rozpoczecia,
           @data_zakonczenia = data_zakonczenia
      FROM najmy n
      JOIN obiekty o on n.obiekt_id = o.id
      WHERE n.id = @najem_id;

    IF @data_zakonczenia IS NULL
      RETURN NULL;

    RETURN (1+DATEDIFF(DAY, @data_rozpoczecia, @data_zakonczenia))*@dzienna_stawka;
  END
GO;

---~~~

DROP FUNCTION koszt_najmu;
GO;