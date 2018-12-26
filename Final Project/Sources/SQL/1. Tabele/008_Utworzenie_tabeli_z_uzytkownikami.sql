CREATE TABLE uzytkownicy (
  id INT PRIMARY KEY NOT NULL IDENTITY (1, 1),

  login VARCHAR(75) NOT NULL,

  nazwisko VARCHAR(75) NOT NULL,
  imie VARCHAR(75) NOT NULL,
  wiek INT NOT NULL CHECK (wiek BETWEEN 1 AND 100),
  adres VARCHAR(150) NOT NULL DEFAULT 'Brak Danych',
  telefon VARCHAR(30) NOT NULL DEFAULT 'Brak Danych',
  plec CHAR(1) NOT NULL CHECK (plec IN ('K', 'M')),
);
GO;

---~~~

DROP TABLE uzytkownicy;
GO;