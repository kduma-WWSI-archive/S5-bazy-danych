CREATE FUNCTION opoznieni (@liczba_dni INT)
  RETURNS TABLE
  AS
    RETURN (
      SELECT n.id najem_id,
             o.nazwa nazwa_obiektu,
             DATEDIFF(DAY, n.data_rozpoczecia, getdate()) dni_od_wynajmu,
             dbo.koszt_najmu_obiektu(o.id, DATEDIFF(DAY, n.data_rozpoczecia, getdate()) + 1) szacunkowy_koszt_najmu,
             dbo.adresowka(u.id) etykieta
        FROM najmy n
        JOIN obiekty o on n.obiekt_id = o.id
        JOIN uzytkownicy u on n.uzytkownik_id = u.id
        WHERE DATEDIFF(DAY, n.data_rozpoczecia, getdate()) >= @liczba_dni
              AND n.data_zakonczenia IS NULL
    )
GO;

---~~~

DROP FUNCTION opoznieni;
GO;



