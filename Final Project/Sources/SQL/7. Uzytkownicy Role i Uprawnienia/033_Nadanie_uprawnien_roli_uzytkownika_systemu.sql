GRANT SELECT ON kategorie TO uzytkownicy_systemu;
GO;

GRANT SELECT ON miasta TO uzytkownicy_systemu;
GO;

GRANT SELECT ON dzielnice TO uzytkownicy_systemu;
GO;

GRANT SELECT ON obiekty TO uzytkownicy_systemu;
GO;


GRANT SELECT, UPDATE(nazwisko, imie, wiek, adres, telefon, plec) ON uzytkownicy TO uzytkownicy_systemu;
GO;

GRANT SELECT, INSERT, UPDATE(data_zakonczenia) ON najmy TO uzytkownicy_systemu;
GO;

---~~~

REVOKE SELECT ON kategorie TO uzytkownicy_systemu;
GO;

REVOKE SELECT ON miasta TO uzytkownicy_systemu;
GO;

REVOKE SELECT ON dzielnice TO uzytkownicy_systemu;
GO;

REVOKE SELECT ON obiekty TO uzytkownicy_systemu;
GO;


REVOKE SELECT, UPDATE(nazwisko, imie, wiek, adres, telefon, plec) ON uzytkownicy TO uzytkownicy_systemu;
GO;

REVOKE SELECT, INSERT, UPDATE(data_zakonczenia) ON najmy TO uzytkownicy_systemu;
GO;