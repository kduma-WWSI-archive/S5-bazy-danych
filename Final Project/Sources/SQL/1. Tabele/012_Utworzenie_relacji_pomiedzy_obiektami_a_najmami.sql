ALTER TABLE najmy
  ADD CONSTRAINT najmy_obiekty_fk
  FOREIGN KEY (obiekt_id)
  REFERENCES obiekty(id);
GO;

---~~~

ALTER TABLE najmy DROP CONSTRAINT najmy_obiekty_fk;
GO;