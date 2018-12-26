IF EXISTS(SELECT 1
              FROM sys.databases
              WHERE name = N'projekt')
  BEGIN
    PRINT 'Baza danych już istnieje: projekt'
  END
ELSE
  BEGIN
    CREATE DATABASE projekt;
    PRINT 'Baza danych została utwożona: projekt'
  END;
  
GO