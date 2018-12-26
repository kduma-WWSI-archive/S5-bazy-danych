ALTER TABLE obiekty
  ADD CONSTRAINT obiekty_kategorie_fk
  FOREIGN KEY (kategoria_id)
  REFERENCES kategorie(id);
GO;

---~~~

ALTER TABLE obiekty DROP CONSTRAINT obiekty_kategorie_fk;
GO;