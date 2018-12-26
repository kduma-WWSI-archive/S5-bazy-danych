CREATE TABLE obiekty (
  id INT UNIQUE,
  klient_id INT,
  name VARCHAR(MAX)
);
GO;

---~~~

DROP TABLE obiekty;
GO;