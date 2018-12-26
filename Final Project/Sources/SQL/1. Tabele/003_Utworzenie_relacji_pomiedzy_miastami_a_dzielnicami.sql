ALTER TABLE dzielnice
  ADD CONSTRAINT dzielnice_miasta_fk 
  FOREIGN KEY (miasto_id) 
  REFERENCES miasta(id);
GO;

---~~~

ALTER TABLE dzielnice DROP CONSTRAINT dzielnice_miasta_fk;
GO;