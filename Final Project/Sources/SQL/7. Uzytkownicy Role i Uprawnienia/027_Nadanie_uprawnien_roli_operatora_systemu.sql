GRANT SELECT ON kategorie TO operatorzy_systemu;
GO;

GRANT SELECT ON miasta TO operatorzy_systemu;
GO;

GRANT SELECT ON dzielnice TO operatorzy_systemu;
GO;

GRANT SELECT ON obiekty TO operatorzy_systemu;
GO;

GRANT SELECT ON uzytkownicy TO operatorzy_systemu;
GO;

GRANT SELECT, INSERT, UPDATE ON najmy TO operatorzy_systemu;
GO;

GRANT SELECT ON lista_najmow TO operatorzy_systemu;
GO;

---~~~


REVOKE SELECT ON kategorie TO operatorzy_systemu;
GO;

REVOKE SELECT ON miasta TO operatorzy_systemu;
GO;

REVOKE SELECT ON dzielnice TO operatorzy_systemu;
GO;

REVOKE SELECT ON obiekty TO operatorzy_systemu;
GO;

REVOKE SELECT ON uzytkownicy TO operatorzy_systemu;
GO;

REVOKE SELECT, INSERT, UPDATE ON najmy TO operatorzy_systemu;
GO;

REVOKE SELECT ON lista_najmow TO operatorzy_systemu;
GO;