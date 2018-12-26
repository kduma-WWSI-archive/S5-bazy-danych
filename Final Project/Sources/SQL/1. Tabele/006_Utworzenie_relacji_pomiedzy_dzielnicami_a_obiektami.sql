ALTER TABLE obiekty
  ADD CONSTRAINT obiekty_dzielnice_fk
  FOREIGN KEY (dzielnica_id)
  REFERENCES dzielnice(id);
GO;

---~~~

ALTER TABLE obiekty DROP CONSTRAINT obiekty_dzielnice_fk;
GO;