-- CREATE DATABASE KASETY_501_03
-- GO

USE kasety_501_03;
GO

CREATE TABLE osoby
(
  ido      INT PRIMARY KEY,
  nazwisko CHAR(30),
  imie     CHAR(30)
);
GO

CREATE TABLE hobby
(
  idh   INT PRIMARY KEY,
  nazwa CHAR(15)
);
GO

CREATE TABLE o_h
(
  ido INT,
  idh INT
);
GO