IF EXISTS(SELECT 1 FROM sys.databases WHERE name = N'projekt')
  BEGIN
    PRINT 'Baza danych już istnieje: projekt'
  END
ELSE
  BEGIN
    CREATE DATABASE projekt;
    PRINT 'Baza danych została utwożona: projekt'

    EXEC dbo.sp_executesql @statement = N'USE projekt';
    EXEC dbo.sp_executesql @statement = N'EXEC sp_configure ''CONTAINED DATABASE AUTHENTICATION'', 1';
    EXEC dbo.sp_executesql @statement = N'RECONFIGURE';
    EXEC dbo.sp_executesql @statement = N'ALTER DATABASE projekt SET CONTAINMENT = PARTIAL';
    PRINT 'Baza danych została skonfigurowana'
  END
GO