CREATE FUNCTION fn_securitypredicate_najmy (@login_field SYSNAME)
  RETURNS TABLE
  WITH SCHEMABINDING
  AS
    RETURN SELECT 1 AS fn_securitypredicate_najmy_result
      FROM dbo.najmy n
      WHERE (
        @login_field = (SELECT u.id FROM dbo.uzytkownicy u WHERE u.login COLLATE SQL_Latin1_General_CP1_CS_AS = CURRENT_USER COLLATE SQL_Latin1_General_CP1_CS_AS)
        OR IS_ROLEMEMBER('admini_systemu', user_name()) = 1
        OR IS_ROLEMEMBER('operatorzy_systemu', user_name()) = 1
        OR user_name() = 'dbo'
      )
GO;

CREATE SECURITY POLICY fn_security_najmy
  ADD FILTER PREDICATE
  dbo.fn_securitypredicate_najmy(uzytkownik_id)
  ON dbo.najmy
GO;

ALTER SECURITY POLICY fn_security_najmy WITH (state = on);
GO;

---~~~

ALTER SECURITY POLICY fn_security_najmy WITH (state = off);
GO;

DROP SECURITY POLICY fn_security_najmy;
GO;

DROP FUNCTION fn_securitypredicate_najmy;
GO;