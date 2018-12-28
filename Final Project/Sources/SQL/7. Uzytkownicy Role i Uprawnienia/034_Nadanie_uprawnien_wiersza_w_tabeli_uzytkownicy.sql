CREATE FUNCTION fn_securitypredicate_uzytkownicy (@login_field SYSNAME)
  RETURNS TABLE
  WITH SCHEMABINDING
  AS
    RETURN SELECT 1 AS fn_securitypredicate_uzytkownicy_result
      FROM dbo.uzytkownicy
      WHERE (
        @login_field = user_name()
        OR IS_ROLEMEMBER('admini_systemu', user_name()) = 1
        OR IS_ROLEMEMBER('operatorzy_systemu', user_name()) = 1
        OR user_name() = 'dbo'
      )
GO;

CREATE SECURITY POLICY fn_security_uzytkownicy
  ADD FILTER PREDICATE
  dbo.fn_securitypredicate_uzytkownicy(login)
  ON dbo.uzytkownicy
GO;

ALTER SECURITY POLICY fn_security_uzytkownicy WITH (state = on);
GO;

---~~~

ALTER SECURITY POLICY fn_security_uzytkownicy WITH (state = off);
GO;

DROP SECURITY POLICY fn_security_uzytkownicy;
GO;

DROP FUNCTION fn_securitypredicate_uzytkownicy;
GO;