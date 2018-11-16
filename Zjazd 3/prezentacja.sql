IF EXISTS(SELECT *
            FROM dbo.sysobjects
            WHERE id = object_id(N'miasta'))
  BEGIN
    PRINT 'tabela miasta juz istnieje'
  END
ELSE
  BEGIN
    PRINT 'tworze tabele miasta'
    CREATE TABLE miasta (
      id    INT PRIMARY KEY,
      nazwa CHAR(30)
    );
  END
GO;

CREATE TABLE osoby_m (
  id        INT PRIMARY KEY,
  imie      CHAR(30),
  nazwisko  CHAR(30),
  miasto_id INT,
  CONSTRAINT fk_osoby_miasta FOREIGN KEY (miasto_id) REFERENCES miasta (id)
)
GO;

DROP TABLE osoby_m;
DROP TABLE miasta;

SELECT * FROM information_schema.table_constraints;
select * from dbo.sysobjects;