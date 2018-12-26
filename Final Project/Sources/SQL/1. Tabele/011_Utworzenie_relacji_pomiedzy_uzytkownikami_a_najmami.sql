ALTER TABLE najmy
  ADD CONSTRAINT najmy_uzytkownicy_fk
  FOREIGN KEY (uzytkownik_id)
  REFERENCES uzytkownicy(id);
GO;

---~~~

ALTER TABLE najmy DROP CONSTRAINT najmy_uzytkownicy_fk;
GO;