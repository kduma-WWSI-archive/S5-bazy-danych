IF EXISTS(SELECT 1
              FROM sys.databases
              WHERE name = N'sem5')
  BEGIN
    PRINT 'Baza danych już istnieje: sem5'
  END
ELSE
  BEGIN
    CREATE DATABASE sem5;
    PRINT 'Baza danych została utwożona: sem5'
  END;
  
GO