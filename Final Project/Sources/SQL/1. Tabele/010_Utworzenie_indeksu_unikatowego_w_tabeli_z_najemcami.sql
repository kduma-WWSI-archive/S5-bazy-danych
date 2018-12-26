CREATE UNIQUE INDEX najemcy_ui
   ON najmy (uzytkownik_id, obiekt_id, data_rozpoczecia);
GO;

---~~~

DROP INDEX najmy.najemcy_ui;
GO;