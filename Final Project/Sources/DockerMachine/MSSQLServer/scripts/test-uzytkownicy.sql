PRINT 'Uruchamiam jako: admin'
EXECUTE AS USER = 'admin';
SELECT id, login, nazwisko FROM uzytkownicy;
REVERT;

PRINT 'Uruchamiam jako: operator'
EXECUTE AS USER = 'operator';
SELECT id, login, nazwisko FROM uzytkownicy;
REVERT;

PRINT 'Uruchamiam jako: login_1'
EXECUTE AS USER = 'login_1';
SELECT id, login, nazwisko FROM uzytkownicy;
REVERT;

PRINT 'Uruchamiam jako: login_2'
EXECUTE AS USER = 'login_2';
SELECT id, login, nazwisko FROM uzytkownicy;
REVERT;

PRINT 'Uruchamiam jako: login_3'
EXECUTE AS USER = 'login_3';
SELECT id, login, nazwisko FROM uzytkownicy;
REVERT;

PRINT 'Uruchamiam jako: login_4'
EXECUTE AS USER = 'login_4';
SELECT id, login, nazwisko FROM uzytkownicy;
REVERT;