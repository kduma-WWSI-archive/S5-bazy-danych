USE kasety_501_03;

IF EXISTS(SELECT *
            FROM dbo.sysobjects
            WHERE id = object_id(N'klienci'))
  BEGIN
    PRINT 'klienci: istnieje!'
  END
ELSE
  BEGIN
    PRINT 'klienci: tworze'
    CREATE TABLE klienci (
      id       INT PRIMARY KEY NOT NULL IDENTITY (1, 1),
      nazwisko CHAR(30)        NOT NULL,
      imie     CHAR(15)        NOT NULL,
      wiek     INT             NULL,
      adres    CHAR(30)        NULL,
      telefon  CHAR(15)        NULL,
      plec     CHAR(1)         NOT NULL,
    );
  END
GO;

IF EXISTS(SELECT *
            FROM dbo.sysobjects
            WHERE id = object_id(N'kraje'))
  BEGIN
    PRINT 'kraje: istnieje!'
  END
ELSE
  BEGIN
    PRINT 'kraje: tworze'
    CREATE TABLE kraje (
      id    INT PRIMARY KEY NOT NULL IDENTITY (1, 1),
      nazwa CHAR(30)        NOT NULL,
    );
  END
GO;

IF EXISTS(SELECT *
            FROM dbo.sysobjects
            WHERE id = object_id(N'rodzaje'))
  BEGIN
    PRINT 'rodzaje: istnieje!'
  END
ELSE
  BEGIN
    PRINT 'rodzaje: tworze'
    CREATE TABLE rodzaje (
      id    INT PRIMARY KEY NOT NULL IDENTITY (1, 1),
      nazwa CHAR(30)        NOT NULL,
    );
  END
GO;

IF EXISTS(SELECT *
            FROM dbo.sysobjects
            WHERE id = object_id(N'rezyser'))
  BEGIN
    PRINT 'rezyser: istnieje!'
  END
ELSE
  BEGIN
    PRINT 'rezyser: tworze'
    CREATE TABLE rezyser (
      id       INT PRIMARY KEY NOT NULL IDENTITY (1, 1),
      nazwisko CHAR(30)        NOT NULL,
      imie     CHAR(15)        NOT NULL,
    );
  END
GO;

IF EXISTS(SELECT *
            FROM dbo.sysobjects
            WHERE id = object_id(N'filmy'))
  BEGIN
    PRINT 'filmy: istnieje!'
  END
ELSE
  BEGIN
    PRINT 'filmy: tworze'
    CREATE TABLE filmy (
      id         INT PRIMARY KEY NOT NULL IDENTITY (1, 1),
      tytul      CHAR(25)        NOT NULL,
      imie       CHAR(15)        NOT NULL,
      rezyser_id INT             NOT NULL,
      cena       DECIMAL(6, 2)   NOT NULL,
      kolor      CHAR(1)         NOT NULL,
      opis       CHAR(40)        NULL,
      CONSTRAINT fk_film_rezyser FOREIGN KEY (rezyser_id) REFERENCES rezyser (id)
    );
  END
GO;

IF EXISTS(SELECT *
            FROM dbo.sysobjects
            WHERE id = object_id(N'kasety'))
  BEGIN
    PRINT 'kasety: istnieje!'
  END
ELSE
  BEGIN
    PRINT 'kasety: tworze'
    CREATE TABLE kasety (
      id      INT PRIMARY KEY NOT NULL IDENTITY (1, 1),
      film_id INT             NOT NULL,
      status  CHAR(1)         NOT NULL,
      CONSTRAINT fk_kaseta_film FOREIGN KEY (film_id) REFERENCES filmy (id)
    );
  END
GO;

IF EXISTS(SELECT *
            FROM dbo.sysobjects
            WHERE id = object_id(N'wypozyczenia'))
  BEGIN
    PRINT 'wypozyczenia: istnieje!'
  END
ELSE
  BEGIN
    PRINT 'wypozyczenia: tworze'
    CREATE TABLE wypozyczenia (
      klient_id         INT           NOT NULL,
      kaseta_id         INT           NOT NULL,
      data_wypozyczenia SMALLDATETIME NOT NULL,
      data_zwrotu       SMALLDATETIME NULL,
      kwota             DECIMAL(7, 2) NULL,
      CONSTRAINT fk_wypozyczenie_klient FOREIGN KEY (klient_id) REFERENCES klienci (id),
      CONSTRAINT fk_wypozyczenie_kasety FOREIGN KEY (kaseta_id) REFERENCES kasety (id),
    );
  END
GO;

IF EXISTS(SELECT *
            FROM dbo.sysobjects
            WHERE id = object_id(N'filmy_kraje'))
  BEGIN
    PRINT 'filmy_kraje: istnieje!'
  END
ELSE
  BEGIN
    PRINT 'filmy_kraje: tworze'
    CREATE TABLE filmy_kraje (
      film_id INT NOT NULL,
      kraj_id INT NOT NULL,
      CONSTRAINT fk_filmy_kraje_film FOREIGN KEY (film_id) REFERENCES filmy (id),
      CONSTRAINT fk_filmy_kraje_kraj FOREIGN KEY (kraj_id) REFERENCES kraje (id),
    );
  END
GO;

IF EXISTS(SELECT *
            FROM dbo.sysobjects
            WHERE id = object_id(N'filmy_rodzaje'))
  BEGIN
    PRINT 'filmy_rodzaje: istnieje!'
  END
ELSE
  BEGIN
    PRINT 'filmy_rodzaje: tworze'
    CREATE TABLE filmy_rodzaje (
      film_id   INT NOT NULL,
      rodzaj_id INT NOT NULL,
      CONSTRAINT fk_filmy_rodzaje_film FOREIGN KEY (film_id) REFERENCES filmy (id),
      CONSTRAINT fk_filmy_rodzaje_rodzaj FOREIGN KEY (rodzaj_id) REFERENCES rodzaje (id),
    );
  END
GO;