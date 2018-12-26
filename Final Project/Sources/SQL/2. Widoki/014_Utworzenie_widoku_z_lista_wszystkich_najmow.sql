CREATE VIEW lista_najmow
  AS
    SELECT nazwisko, imie, data_rozpoczecia, data_zakonczenia, nazwa nazwa_obiektu, koszt calkowity_koszt
        FROM najmy n
        JOIN uzytkownicy u on n.uzytkownik_id = u.id
        JOIN obiekty o on n.obiekt_id = o.id;
GO;

---~~~

DROP VIEW lista_najmow;
GO;