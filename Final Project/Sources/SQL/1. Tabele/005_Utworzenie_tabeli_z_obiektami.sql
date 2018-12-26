CREATE TABLE obiekty (
  id INT PRIMARY KEY NOT NULL IDENTITY (1, 1),

  dzielnica_id INT NOT NULL,
  kategoria_id INT NOT NULL,

  nazwa VARCHAR(150) NOT NULL,
  adres VARCHAR(150) NOT NULL DEFAULT 'Brak Danych',
  dzienna_stawka_najmu DECIMAL(10, 2) NOT NULL CHECK (dzienna_stawka_najmu > 0),

  obecnie_wynajete CHAR(1) NOT NULL DEFAULT 'N' CHECK (obecnie_wynajete IN ('T', 'N')),
);
GO;

---~~~

DROP TABLE obiekty;
GO;