IF EXISTS(SELECT *
              FROM sys.tables
              WHERE name = N'klienci')
  BEGIN
    PRINT '+----------------------------+'
    PRINT '|Tabela już istnieje: klienci|'
    PRINT '+----------------------------+'
  END
ELSE
  BEGIN
    CREATE TABLE klienci (
      id       INT PRIMARY KEY NOT NULL IDENTITY (1, 1),
      nazwisko CHAR(30)        NOT NULL,
      imie     CHAR(15)        NOT NULL,
      wiek     INT             NULL,
      adres    CHAR(50)        NULL     DEFAULT 'Brak Danych',
      telefon  CHAR(15)        NULL,
      plec     CHAR(1)         NOT NULL CHECK (plec IN ('K', 'M')),
    )
    
    PRINT '+--------------------------------+'
    PRINT '|Tabela została utwożona: klienci|'
    PRINT '+--------------------------------+'

  END
GO 

IF EXISTS(SELECT *
              FROM sys.tables
              WHERE name = N'kraje')
  BEGIN
    PRINT '+--------------------------+'
    PRINT '|Tabela już istnieje: kraje|'
    PRINT '+--------------------------+'
  END
ELSE
  BEGIN
    CREATE TABLE kraje (
      id    INT PRIMARY KEY NOT NULL IDENTITY (1, 1),
      nazwa CHAR(30)        NOT NULL,

      UNIQUE (nazwa),
    )
    
    PRINT '+------------------------------+'
    PRINT '|Tabela została utwożona: kraje|'
    PRINT '+------------------------------+'
    
  END
GO 

IF EXISTS(SELECT *
              FROM sys.tables
              WHERE name = N'rodzaje')
  BEGIN
    PRINT '+----------------------------+'
    PRINT '|Tabela już istnieje: rodzaje|'
    PRINT '+----------------------------+'
  END
ELSE
  BEGIN
    CREATE TABLE rodzaje (
      id    INT PRIMARY KEY NOT NULL IDENTITY (1, 1),
      nazwa CHAR(30)        NOT NULL,

      UNIQUE (nazwa),
    )
    
    PRINT '+--------------------------------+'
    PRINT '|Tabela została utwożona: rodzaje|'
    PRINT '+--------------------------------+'
    
  END
GO 

IF EXISTS(SELECT *
              FROM sys.tables
              WHERE name = N'rezyser')
  BEGIN
    PRINT '+----------------------------+'
    PRINT '|Tabela już istnieje: rezyser|'
    PRINT '+----------------------------+'
  END
ELSE
  BEGIN
    CREATE TABLE rezyser (
      id       INT PRIMARY KEY NOT NULL IDENTITY (1, 1),
      nazwisko CHAR(30)        NOT NULL,
      imie     CHAR(15)        NOT NULL,

      UNIQUE (nazwisko, imie),
    )
    
    PRINT '+--------------------------------+'
    PRINT '|Tabela została utwożona: rezyser|'
    PRINT '+--------------------------------+'
    
  END
GO 

IF EXISTS(SELECT *
              FROM sys.tables
              WHERE name = N'filmy')
  BEGIN
    PRINT '+--------------------------+'
    PRINT '|Tabela już istnieje: filmy|'
    PRINT '+--------------------------+'
  END
ELSE
  BEGIN
    CREATE TABLE filmy (
      id         INT PRIMARY KEY NOT NULL IDENTITY (1, 1),
      tytul      VARCHAR(75)     NOT NULL,
      rezyser_id INT             NOT NULL,
      cena       DECIMAL(6, 2)   NOT NULL CHECK (cena BETWEEN 1 AND 20),
      kolor      CHAR(1)         NOT NULL CHECK (kolor IN ('K', 'C')),
      opis       VARCHAR(255)    NULL     DEFAULT 'Brak Danych',


      UNIQUE (tytul, rezyser_id),

      CONSTRAINT fk_film_rezyser FOREIGN KEY (rezyser_id) REFERENCES rezyser (id)
    )
    
    PRINT '+------------------------------+'
    PRINT '|Tabela została utwożona: filmy|'
    PRINT '+------------------------------+'

  END
GO 

IF EXISTS(SELECT *
              FROM sys.tables
              WHERE name = N'kasety')
  BEGIN
    PRINT '+---------------------------+'
    PRINT '|Tabela już istnieje: kasety|'
    PRINT '+---------------------------+'
  END
ELSE
  BEGIN
    CREATE TABLE kasety (
      id      INT PRIMARY KEY NOT NULL IDENTITY (1, 1),
      film_id INT             NOT NULL,
      status  CHAR(1)         NOT NULL CHECK (status IN ('K', 'W')),
      CONSTRAINT fk_kaseta_film FOREIGN KEY (film_id) REFERENCES filmy (id)
    )
    
    PRINT '+-------------------------------+'
    PRINT '|Tabela została utwożona: kasety|'
    PRINT '+-------------------------------+'

  END
GO 

IF EXISTS(SELECT *
              FROM sys.tables
              WHERE name = N'wypozyczenia')
  BEGIN
    PRINT '+---------------------------------+'
    PRINT '|Tabela już istnieje: wypozyczenia|'
    PRINT '+---------------------------------+'
  END
ELSE
  BEGIN
    CREATE TABLE wypozyczenia (
      klient_id         INT           NOT NULL,
      kaseta_id         INT           NOT NULL,
      data_wypozyczenia SMALLDATETIME NOT NULL DEFAULT getdate(),
      data_zwrotu       SMALLDATETIME NULL,
      kwota             DECIMAL(7, 2) NULL,

      UNIQUE (klient_id, kaseta_id, data_wypozyczenia),

      CONSTRAINT fk_wypozyczenie_klient FOREIGN KEY (klient_id) REFERENCES klienci (id),
      CONSTRAINT fk_wypozyczenie_kasety FOREIGN KEY (kaseta_id) REFERENCES kasety (id),
    )
    
    PRINT '+-------------------------------------+'
    PRINT '|Tabela została utwożona: wypozyczenia|'
    PRINT '+-------------------------------------+'

  END
GO 

IF EXISTS(SELECT *
              FROM sys.tables
              WHERE name = N'filmy_kraje')
  BEGIN
    PRINT '+--------------------------------+'
    PRINT '|Tabela już istnieje: filmy_kraje|'
    PRINT '+--------------------------------+'
  END
ELSE
  BEGIN
    CREATE TABLE filmy_kraje (
      film_id INT NOT NULL,
      kraj_id INT NOT NULL,

      UNIQUE (film_id, kraj_id),

      CONSTRAINT fk_filmy_kraje_film FOREIGN KEY (film_id) REFERENCES filmy (id),
      CONSTRAINT fk_filmy_kraje_kraj FOREIGN KEY (kraj_id) REFERENCES kraje (id)
        ON DELETE CASCADE,
    )
    
    PRINT '+------------------------------------+'
    PRINT '|Tabela została utwożona: filmy_kraje|'
    PRINT '+------------------------------------+'

  END
GO 

IF EXISTS(SELECT *
              FROM sys.tables
              WHERE name = N'filmy_rodzaje')
  BEGIN
    PRINT '+----------------------------------+'
    PRINT '|Tabela już istnieje: filmy_rodzaje|'
    PRINT '+----------------------------------+'
  END
ELSE
  BEGIN
    CREATE TABLE filmy_rodzaje (
      film_id   INT NOT NULL,
      rodzaj_id INT NOT NULL,

      UNIQUE (film_id, rodzaj_id),

      CONSTRAINT fk_filmy_rodzaje_film FOREIGN KEY (film_id) REFERENCES filmy (id),
      CONSTRAINT fk_filmy_rodzaje_rodzaj FOREIGN KEY (rodzaj_id) REFERENCES rodzaje (id)
        ON DELETE CASCADE,
    )
    
    PRINT '+--------------------------------------+'
    PRINT '|Tabela została utwożona: filmy_rodzaje|'
    PRINT '+--------------------------------------+'

  END
GO 


