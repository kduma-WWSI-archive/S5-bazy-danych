GRANT EXECUTE ON utworz_uzytkownika TO admini_systemu;
GO;

GRANT EXECUTE ON utworz_uzytkownika TO operatorzy_systemu;
GO;

---~~~

REVOKE EXECUTE ON utworz_uzytkownika TO admini_systemu;
GO;

REVOKE EXECUTE ON utworz_uzytkownika TO operatorzy_systemu;
GO;