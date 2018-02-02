--wyzwalacze AFTER i INSTEAD OF

CREATE TRIGGER Potwierdz ON Towary
AFTER DELETE
AS
	PRINT 'Zosta�y usuni�te wiersze: '
	SELECT * FROM deleted;
GO

ALTER TABLE Towary ENABLE TRIGGER Potwierdz;	--uruchomienie wyzwalacza

ALTER TABLE Towary DISABLE TRIGGER Potwierdz;	--wy��czenie wyzwalacza

CREATE TRIGGER Przerwij ON Towary
INSTEAD OF INSERT
AS
	PRINT 'Pr�bowano wstawi� wiersze: '
	SELECT * FROM inserted;
GO

ALTER TABLE Towary ENABLE TRIGGER Przerwij;	--uruchomienie wyzwalacza

ALTER TABLE Towary DISABLE TRIGGER Przerwij;	--wy��czenie wyzwalacza