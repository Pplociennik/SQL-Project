--wyzwalacze AFTER i INSTEAD OF

CREATE TRIGGER Potwierdz ON Towary
AFTER DELETE
AS
	PRINT 'Zosta³y usuniête wiersze: '
	SELECT * FROM deleted;
GO

ALTER TABLE Towary ENABLE TRIGGER Potwierdz;	--uruchomienie wyzwalacza

ALTER TABLE Towary DISABLE TRIGGER Potwierdz;	--wy³¹czenie wyzwalacza

CREATE TRIGGER Przerwij ON Towary
INSTEAD OF INSERT
AS
	PRINT 'Próbowano wstawiæ wiersze: '
	SELECT * FROM inserted;
GO

ALTER TABLE Towary ENABLE TRIGGER Przerwij;	--uruchomienie wyzwalacza

ALTER TABLE Towary DISABLE TRIGGER Przerwij;	--wy³¹czenie wyzwalacza