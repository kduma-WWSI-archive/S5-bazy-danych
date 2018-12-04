IF EXISTS(SELECT 1
              FROM sys.databases
              WHERE name = N'sem5')
  BEGIN
    PRINT '+------------------------------+'
    PRINT '|Baza danych już istnieje: sem5|'
    PRINT '+------------------------------+'
  END
ELSE
  BEGIN
    CREATE DATABASE sem5;
    PRINT '+----------------------------------+'
    PRINT '|Baza danych została utwożona: sem5|'
    PRINT '+----------------------------------+'
  END;
  
GO