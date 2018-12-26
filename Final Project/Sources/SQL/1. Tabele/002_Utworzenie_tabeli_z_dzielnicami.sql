CREATE TABLE dzielnice (
  id INT PRIMARY KEY NOT NULL IDENTITY (1, 1),
  miasto_id INT NOT NULL,
  nazwa VARCHAR(75) NOT NULL
);
GO;

---~~~

DROP TABLE dzielnice;
GO;