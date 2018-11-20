USE kasety_501_03
;


TRUNCATE TABLE wypozyczenia
;

DELETE FROM klienci DBCC CHECKIDENT (klienci, RESEED, 0)
;

DELETE FROM kasety DBCC CHECKIDENT (kasety, RESEED, 0)
;

TRUNCATE TABLE filmy_rodzaje
;

TRUNCATE TABLE filmy_kraje
;

DELETE FROM filmy DBCC CHECKIDENT (filmy, RESEED, 0)
;

DELETE FROM kraje DBCC CHECKIDENT (kraje, RESEED, 0)
;

DELETE FROM rezyser DBCC CHECKIDENT (rezyser, RESEED, 0)
;

DELETE FROM rodzaje DBCC CHECKIDENT (rodzaje, RESEED, 0)
;