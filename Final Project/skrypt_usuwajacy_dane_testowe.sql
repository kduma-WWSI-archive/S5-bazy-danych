DELETE FROM najmy WHERE 1=1 DBCC CHECKIDENT (najmy, RESEED, 0);
PRINT 'Tabela ''najmy'' została opróżniona';

DELETE FROM uzytkownicy WHERE 1=1 DBCC CHECKIDENT (uzytkownicy, RESEED, 0);

DROP SCHEMA login_1;
DROP LOGIN login_1;
DROP USER login_1;

DROP SCHEMA login_2;
DROP LOGIN login_2;
DROP USER login_2;

DROP SCHEMA login_3;
DROP LOGIN login_3;
DROP USER login_3;

DROP SCHEMA login_4;
DROP LOGIN login_4;
DROP USER login_4;

PRINT 'Tabela ''uzytkownicy'' została opróżniona';

DELETE FROM obiekty WHERE 1=1 DBCC CHECKIDENT (obiekty, RESEED, 0);
PRINT 'Tabela ''obiekty'' została opróżniona';

DELETE FROM kategorie WHERE 1=1 DBCC CHECKIDENT (kategorie, RESEED, 0);
PRINT 'Tabela ''kategorie'' została opróżniona';

DELETE FROM dzielnice WHERE 1=1 DBCC CHECKIDENT (dzielnice, RESEED, 0);
PRINT 'Tabela ''dzielnice'' została opróżniona';

DELETE FROM miasta WHERE 1=1 DBCC CHECKIDENT (miasta, RESEED, 0);
PRINT 'Tabela ''miasta'' została opróżniona';