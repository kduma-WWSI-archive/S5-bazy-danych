GRANT SELECT, INSERT, UPDATE, DELETE ON kategorie TO admini_systemu;
GO;

GRANT SELECT, INSERT, UPDATE, DELETE ON miasta TO admini_systemu;
GO;

GRANT SELECT, INSERT, UPDATE, DELETE ON dzielnice TO admini_systemu;
GO;

GRANT SELECT, INSERT, UPDATE, DELETE ON obiekty TO admini_systemu;
GO;

GRANT SELECT, UPDATE, DELETE ON uzytkownicy TO admini_systemu;
GO;

GRANT SELECT, INSERT, UPDATE ON najmy TO admini_systemu;
GO;

GRANT SELECT ON lista_najmow TO admini_systemu;
GO;

GRANT SELECT ON lista_niepopularnych_obiektow TO admini_systemu;
GO;

GRANT SELECT ON lista_popularnosci_obiektow TO admini_systemu;
GO;

---~~~

REVOKE SELECT, INSERT, UPDATE, DELETE ON kategorie TO admini_systemu;
GO;

REVOKE SELECT, INSERT, UPDATE, DELETE ON miasta TO admini_systemu;
GO;

REVOKE SELECT, INSERT, UPDATE, DELETE ON dzielnice TO admini_systemu;
GO;

REVOKE SELECT, INSERT, UPDATE, DELETE ON obiekty TO admini_systemu;
GO;

REVOKE SELECT, UPDATE, DELETE ON uzytkownicy TO admini_systemu;
GO;

REVOKE SELECT, INSERT, UPDATE ON najmy TO admini_systemu;
GO;

REVOKE SELECT ON lista_najmow TO admini_systemu;
GO;

REVOKE SELECT ON lista_niepopularnych_obiektow TO admini_systemu;
GO;

REVOKE SELECT ON lista_popularnosci_obiektow TO admini_systemu;
GO;