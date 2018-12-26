CREATE VIEW lista_popularnosci_obiektow
  AS
    SELECT id, nazwa, adres, (SELECT COUNT(*) FROM najmy WHERE najmy.obiekt_id = obiekty.id) liczba_najmow
    FROM obiekty;
GO;

---~~~

DROP VIEW lista_popularnosci_obiektow;
GO;