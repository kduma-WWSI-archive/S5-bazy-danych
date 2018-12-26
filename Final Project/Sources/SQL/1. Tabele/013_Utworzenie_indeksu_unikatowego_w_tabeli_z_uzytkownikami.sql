CREATE UNIQUE INDEX najemcy_ui
   ON uzytkownicy (login);
GO;

---~~~

DROP INDEX uzytkownicy.najemcy_ui;
GO;