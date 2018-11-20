USE kasety_501_03;

IF NOT EXISTS(SELECT *
                FROM dbo.sysobjects
                WHERE id = object_id(N'filmy_rodzaje'))
  BEGIN
    PRINT 'filmy_rodzaje: nie istnieje!!'
  END
ELSE
  BEGIN
    PRINT 'filmy_rodzaje: usuwam'
    DROP TABLE filmy_rodzaje;
  END
GO ;

IF NOT EXISTS(SELECT *
                FROM dbo.sysobjects
                WHERE id = object_id(N'filmy_kraje'))
  BEGIN
    PRINT 'filmy_kraje: nie istnieje!!'
  END
ELSE
  BEGIN
    PRINT 'filmy_kraje: usuwam'
    DROP TABLE filmy_kraje;
  END
GO ;

IF NOT EXISTS(SELECT *
                FROM dbo.sysobjects
                WHERE id = object_id(N'wypozyczenia'))
  BEGIN
    PRINT 'wypozyczenia: nie istnieje!!'
  END
ELSE
  BEGIN
    PRINT 'wypozyczenia: usuwam'
    DROP TABLE wypozyczenia;
  END
GO ;

IF NOT EXISTS(SELECT *
                FROM dbo.sysobjects
                WHERE id = object_id(N'kasety'))
  BEGIN
    PRINT 'kasety: nie istnieje!!'
  END
ELSE
  BEGIN
    PRINT 'kasety: usuwam'
    DROP TABLE kasety;
  END
GO ;

IF NOT EXISTS(SELECT *
                FROM dbo.sysobjects
                WHERE id = object_id(N'filmy'))
  BEGIN
    PRINT 'filmy: nie istnieje!!'
  END
ELSE
  BEGIN
    PRINT 'filmy: usuwam'
    DROP TABLE filmy;
  END
GO ;

IF NOT EXISTS(SELECT *
                FROM dbo.sysobjects
                WHERE id = object_id(N'rezyser'))
  BEGIN
    PRINT 'rezyser: nie istnieje!!'
  END
ELSE
  BEGIN
    PRINT 'rezyser: usuwam'
    DROP TABLE rezyser;
  END
GO ;

IF NOT EXISTS(SELECT *
                FROM dbo.sysobjects
                WHERE id = object_id(N'rodzaje'))
  BEGIN
    PRINT 'rodzaje: nie istnieje!!'
  END
ELSE
  BEGIN
    PRINT 'rodzaje: usuwam'
    DROP TABLE rodzaje;
  END
GO ;

IF NOT EXISTS(SELECT *
                FROM dbo.sysobjects
                WHERE id = object_id(N'kraje'))
  BEGIN
    PRINT 'kraje: nie istnieje!!'
  END
ELSE
  BEGIN
    PRINT 'kraje: usuwam'
    DROP TABLE kraje;
  END
GO ;

IF NOT EXISTS(SELECT *
                FROM dbo.sysobjects
                WHERE id = object_id(N'klienci'))
  BEGIN
    PRINT 'klienci: nie istnieje!!'
  END
ELSE
  BEGIN
    PRINT 'klienci: usuwam'
    DROP TABLE klienci;
  END
GO ;

DROP RULE regula_plec;
GO ;

DROP DEFAULT domyslne_brak_informacji;
GO ;