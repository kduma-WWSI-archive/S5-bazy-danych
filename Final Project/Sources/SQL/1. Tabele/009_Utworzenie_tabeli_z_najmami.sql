CREATE TABLE najmy (
  id INT PRIMARY KEY NOT NULL IDENTITY (1, 1),

  uzytkownik_id INT NOT NULL,
  obiekt_id INT NOT NULL,

  data_rozpoczecia DATE NOT NULL DEFAULT getdate(),
  data_zakonczenia DATE NULL,
  koszt DECIMAL(15, 2) NULL,
);
GO;

---~~~

DROP TABLE najmy;
GO;