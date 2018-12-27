CREATE FUNCTION koszt_najmu (@najem_id INT)
  RETURNS DECIMAL(15, 2)
  AS
  BEGIN
		DECLARE @koszt DECIMAL(15, 2);
		DECLARE @liczba_dni INT;
		DECLARE @obiekt_id INT;
		DECLARE @data_rozpoczecia DATE;
		DECLARE @data_zakonczenia DATE;

    SELECT @data_rozpoczecia = n.data_rozpoczecia,
           @data_zakonczenia = n.data_zakonczenia,
           @obiekt_id = o.id
      FROM najmy n
      JOIN obiekty o on n.obiekt_id = o.id
      WHERE n.id = @najem_id;

    IF @data_zakonczenia IS NULL
      RETURN NULL;

    SELECT @liczba_dni = (1+DATEDIFF(DAY, @data_rozpoczecia, @data_zakonczenia));

    SELECT @koszt = dbo.koszt_najmu_obiektu(@obiekt_id, @liczba_dni);

    RETURN @koszt;
  END
GO;

---~~~

DROP FUNCTION koszt_najmu;
GO;