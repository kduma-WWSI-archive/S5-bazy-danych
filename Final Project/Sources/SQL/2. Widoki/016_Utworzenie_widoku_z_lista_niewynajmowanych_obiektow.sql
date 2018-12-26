CREATE VIEW lista_niepopularnych_obiektow
  AS
    SELECT id, nazwa, adres
      FROM lista_popularnosci_obiektow
      GROUP BY id, nazwa, adres
      HAVING SUM(liczba_najmow) = 0
GO;

---~~~

DROP VIEW lista_niepopularnych_obiektow;
GO;