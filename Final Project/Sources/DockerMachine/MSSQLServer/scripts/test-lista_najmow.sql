PRINT 'Uruchamiam jako: admin'
EXECUTE AS USER = 'admin';
SELECT TOP 5 nazwisko, nazwa_obiektu, data_rozpoczecia FROM lista_najmow;
REVERT;

PRINT 'Uruchamiam jako: operator'
EXECUTE AS USER = 'operator';
SELECT TOP 5 nazwisko, nazwa_obiektu, data_rozpoczecia FROM lista_najmow;
REVERT;

PRINT 'Uruchamiam jako: login_1'
EXECUTE AS USER = 'login_1';
SELECT TOP 5 nazwisko, nazwa_obiektu, data_rozpoczecia FROM lista_najmow;
REVERT;