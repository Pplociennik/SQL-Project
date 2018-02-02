--tworzenie tabeli i wype³nianie ich wartoœciami

IF OBJECT_ID('Towary', 'U') IS NOT NULL 
    DROP TABLE Towary;

IF OBJECT_ID('Sklad', 'U') IS NOT NULL 
    DROP TABLE Sklad;

IF OBJECT_ID('Dostawcy', 'U') IS NOT NULL 
    DROP TABLE Dostawcy;

IF OBJECT_ID('Magazynierzy', 'U') IS NOT NULL 
    DROP TABLE Magazynierzy;

IF OBJECT_ID('Magazyny', 'U') IS NOT NULL 
    DROP TABLE Magazyny;

IF OBJECT_ID('Jednostki', 'U') IS NOT NULL 
    DROP TABLE Jednostki;

CREATE TABLE Jednostki
(
	nr			INT,
	rodzaj_tow	VARCHAR(10),
	jednostkaJ	VARCHAR(10) PRIMARY KEY
);

CREATE TABLE Magazyny
(
    id			 INT NOT NULL PRIMARY KEY,
    miasto		VARCHAR(10),
    towar		VARCHAR(10),
	poj_max		INT, 
	poj_aktualna	INT,
	jednostka	VARCHAR(10) REFERENCES Jednostki(jednostkaJ),
    CHECK (poj_max > 0), 
	CHECK (poj_max > poj_aktualna)
);

CREATE TABLE Magazynierzy
(
    idM          INT NOT NULL PRIMARY KEY,
    imie         VARCHAR(20) NOT NULL,
    nazwisko     VARCHAR(20) NOT NULL,
    magazyn      INT REFERENCES Magazyny(id),
    zatrudniony  DATE
);

CREATE TABLE Dostawcy
(
	idD			INT PRIMARY KEY,
	firma		VARCHAR(20),
	oferta		VARCHAR(20),
	siedziba	VARCHAR(20)
);

CREATE TABLE Sklad
(
	nazwa		VARCHAR(10),
	rodzaj		VARCHAR(10),
	status		VARCHAR(10),
	firma		INT REFERENCES Dostawcy(idD),
	ilosc		INT,
	magazyn		INT REFERENCES Magazyny(id),
	magazynier	INT REFERENCES Magazynierzy(idM),
	wykonano	DATE
);

CREATE TABLE Towary
(
	nazwa		VARCHAR(10),
	ilosc		INT,
	rodzaj		VARCHAR(10),
	magazyn		INT REFERENCES Magazyny(id)
);

GO

INSERT INTO Jednostki VALUES (1, 'Owoce', 'Skrzynki');
INSERT INTO Jednostki VALUES (2, 'Warzywa', 'Worki');
INSERT INTO Jednostki VALUES (3, 'RTV', 'Kartony');
INSERT INTO Jednostki VALUES (4, 'AGD', 'm2');
INSERT INTO Jednostki VALUES (5, 'Papier', 'Sztuki');

INSERT INTO Magazyny VALUES (1, 'Poznañ', 'Owoce', 50, 4, 'Skrzynki');
INSERT INTO Magazyny VALUES (2, 'Poznañ', 'RTV', 65, 1, 'Kartony');
INSERT INTO Magazyny VALUES (3, 'Katowice', 'Owoce', 30, 7, 'Skrzynki');
INSERT INTO Magazyny VALUES (4, 'Bydgoszcz', 'AGD', 55, 12, 'm2');
INSERT INTO Magazyny VALUES (5, 'Szczecin', 'Warzywa', 30, 20, 'Worki');
INSERT INTO Magazyny VALUES (6, 'Gdañsk', 'RTV', 75, 0, 'Kartony');
INSERT INTO Magazyny VALUES (7, 'Warszawa', 'Papier', 250, 27, 'Sztuki');

INSERT INTO Magazynierzy VALUES (1,  'Szymon', 'Jankowski', 2, '01-01-1985');
INSERT INTO Magazynierzy VALUES (2,  'Pawe³', 'Grafiñski', 1, '10-01-1990');
INSERT INTO Magazynierzy VALUES (3,  'Tomasz', 'Wróblewski', 4, '08-28-1989');
INSERT INTO Magazynierzy VALUES (4,  'Marek', 'Przybicki', 7, '11-30-1993');
INSERT INTO Magazynierzy VALUES (5,  'Marian', 'Zió³ko', 5, '03-24-1985');
INSERT INTO Magazynierzy VALUES (6,  'Gra¿yna', 'Bogucka', 3, '05-01-1992');
INSERT INTO Magazynierzy VALUES (7,  'Ferdynand', 'Kijowski', 6, '01-17-1992');
INSERT INTO Magazynierzy VALUES (8,  'Szymon', 'G³ogowski', 6, '07-07-1987');
INSERT INTO Magazynierzy VALUES (9,  'Kamil', 'Roztocki', 2, '02-12-1980');
INSERT INTO Magazynierzy VALUES (10,  'Piotr', 'Mierzycki', 6, '09-09-1983');

INSERT INTO Dostawcy VALUES (1, 'Fresh Fruits', 'Owoce', 'Poznañ');
INSERT INTO Dostawcy VALUES (2, 'Wegetables 4YOU', 'Warzywa', 'Sosnowiec');
INSERT INTO Dostawcy VALUES (3, 'RTV/AGD Hurt', 'RTV', 'Warszawa');
INSERT INTO Dostawcy VALUES (4, 'RTV/AGD Hurt', 'AGD', 'Warszawa');
INSERT INTO Dostawcy VALUES (5, 'GreatBooks', 'Papier', 'Warszawa');
INSERT INTO Dostawcy VALUES (6, 'SuperAGD', 'AGD', 'Bydgoszcz');
INSERT INTO Dostawcy VALUES (7, 'FruityHealth', 'Owoce', 'Poznañ');
INSERT INTO Dostawcy VALUES (8, 'Magazyny', 'nie dotyczy', 'Poznañ');


INSERT INTO Sklad VALUES ('Wiœnie', 'Owoce', 'pobrano', 1, 1, 1, 2, '11-02-2017');
INSERT INTO Sklad VALUES ('Banany', 'Owoce', 'pobrano', 7, 4, 1, 2, '01-05-2018');
INSERT INTO Sklad VALUES ('Banany', 'Owoce', 'wydano', NULL, 1, 1, 2, '01-06-2018');
INSERT INTO Sklad VALUES ('Telewizory', 'RTV', 'pobrano', 3, 1, 2, 1, '11-02-2017');
INSERT INTO Sklad VALUES ('Pralki', 'AGD', 'pobrano', 6, 12, 4, 3, '11-02-2017');
INSERT INTO Sklad VALUES ('Ksi¹¿ki', 'Papier', 'pobrano', 5, 27, 7, 4, '11-02-2017');
INSERT INTO Sklad VALUES ('Pomidory', 'Warzywa', 'pobrano', 2, 30, 5, 5, '11-02-2017');

INSERT INTO Towary VALUES ('Wiœnie', 1, 'Owoce', 1);
INSERT INTO Towary VALUES ('Banany', 3, 'Owoce', 1);
INSERT INTO Towary VALUES ('Telewizory', 1, 'RTV', 2);
INSERT INTO Towary VALUES ('Pralki', 12, 'AGD', 4);
INSERT INTO Towary VALUES ('Ksi¹¿ki', 27, 'Papier', 7);
INSERT INTO Towary VALUES ('Pomidory', 20, 'Warzywa', 5);
INSERT INTO Towary VALUES ('Banany', 7, 'Owoce', 3);

--wyswietlenie tabel
SELECT * FROM Magazyny;
SELECT * FROM Magazynierzy;
SELECT * FROM Towary;
SELECT * FROM Sklad;
SELECT * FROM Dostawcy;


--procedury:

--Przesy³anie towaru miêdzy magazynami

CREATE PROC Wyslij

	@magazyn1 INT,
	@magazyn2 INT, 
	@magazynier1 INT,
	@magazynier2 INT,
	@towar VARCHAR(10),
	@rodzaj VARCHAR(10),
	@firma1 VARCHAR(20),
	@firma2 VARCHAR(20),
	@ilosc INT

AS
BEGIN
IF NOT EXISTS (SELECT *
				FROM Towary
					WHERE nazwa = @rodzaj AND magazyn = @magazyn1 AND ilosc >0)
					BEGIN
					PRINT 'Magazyn nie posiada danego towaru'
					END
ELSE
BEGIN
		IF NOT EXISTS (SELECT *
				FROM Magazyny M	
				INNER JOIN Towary T
					ON M.towar = @towar AND M.id = @magazyn2 AND T.ilosc - @ilosc > 0)
	BEGIN
	PRINT 'Magazyn do ktorego chcesz wyslac towar nie obsluguje tego typu towaru'
	END
	ELSE
	BEGIN

		IF NOT EXISTS (SELECT *
					FROM Magazyny
						WHERE id = @magazyn2 AND poj_max >= poj_aktualna + @ilosc OR poj_aktualna - @ilosc < 0)
		BEGIN
		PRINT 'Za malo towaru w magazynie lub towar nie zmiesci sie do magazynu!'
		END

		ELSE


	BEGIN
	IF EXISTS (SELECT *
				FROM Towary
					WHERE nazwa = @rodzaj)
		BEGIN
		UPDATE Towary 
		SET ilosc = ilosc - @ilosc 
		WHERE magazyn = @magazyn1 AND nazwa = @rodzaj

		UPDATE Magazyny
		SET poj_aktualna = poj_aktualna - @ilosc
		WHERE id = @magazyn1

		UPDATE Towary
		SET ilosc = ilosc + @ilosc 
		WHERE magazyn = @magazyn2 AND nazwa = @rodzaj

		UPDATE Magazyny
		SET poj_aktualna = poj_aktualna + @ilosc
		WHERE id = @magazyn2

		INSERT INTO Towary VALUES (@rodzaj, @ilosc, @towar, @magazyn2)

		INSERT INTO Sklad VALUES (@rodzaj, @towar, 'wydano', @firma1, @ilosc, @magazyn1, @magazynier1, GETDATE())
		INSERT INTO Sklad VALUES (@rodzaj, @towar, 'pobrano', @firma2, @ilosc, @magazyn2, @magazynier2, GETDATE())
	END

		ELSE
		BEGIN
		INSERT INTO Towary VALUES (@rodzaj, @ilosc, @towar, @magazyn2)
		INSERT INTO Sklad VALUES (@rodzaj, @towar, 'pobrano', @firma2, @ilosc, @magazyn2, @magazynier2, GETDATE())
		INSERT INTO Sklad VALUES (@rodzaj, @towar, 'wydano', @firma1, @ilosc, @magazyn1, @magazynier1, GETDATE())
		END

	END
END
END
END;

--wywolac przed wywolaniem procedury
SELECT * FROM Towary;
SELECT * FROM Sklad;

EXEC Wyslij 2, 6, 1, 10, 'RTV', 'Telewizory', 8, 8, 1;		--przenies z magazynu 2 do magazynu 6

--zobaczyc efekty
SELECT * FROM Towary;
SELECT * FROM Sklad;
SELECT * FROM Magazyny;

--dostawa towaru do magazynu
CREATE PROC Dostawa
	@firma VARCHAR(20),
	@towar VARCHAR(10),
	@rodzaj VARCHAR(10),
	@ilosc INT,
	@magazyn INT,
	@magazynier INT

AS
BEGIN
DECLARE @dostawa VARCHAR(10) = 'pobrano'

	IF(@ilosc <= 0)
	BEGIN
	PRINT 'Magazyn nie otrzyma ¿adnego towaru!'
	END

		IF NOT EXISTS (SELECT *
						FROM Magazyny
							WHERE id = @magazyn AND @rodzaj = towar)
		BEGIN
		PRINT 'Magazyn nie przyjmuje tego typu towarów!'
		END

		ELSE
		BEGIN

			IF @magazynier NOT IN (SELECT idM
									FROM Magazynierzy
										WHERE magazyn = @magazyn)
			BEGIN
			PRINT 'Magazynier nie pracuje w tym magazynie!'
			END

			ELSE
			BEGIN

				IF NOT EXISTS (SELECT *
								FROM Magazyny
									WHERE id = @magazyn AND poj_max > poj_aktualna + @ilosc)
				BEGIN
				PRINT 'Towar nie zmiesci sie w magazynie!'
				END

				ELSE
				BEGIN

				IF EXISTS (SELECT DISTINCT *
							FROM Towary
								WHERE nazwa = @towar AND @rodzaj = rodzaj AND magazyn = @magazyn)
				BEGIN
				UPDATE Towary
				SET ilosc = ilosc + @ilosc
				WHERE nazwa = @towar AND @rodzaj = rodzaj AND magazyn = @magazyn

				UPDATE Magazyny
				SET poj_aktualna = poj_aktualna + @ilosc
				WHERE id = @magazyn
				END

				ELSE
				INSERT INTO Towary VALUES (@towar, @ilosc, @rodzaj, @magazyn)
				INSERT INTO Sklad VALUES (@towar, @rodzaj, @dostawa, @firma, @ilosc, @magazyn, @magazynier, GETDATE())
				END
				END
				END
				END;

EXEC Dostawa 1, 'Arbuzy', 'Owoce', 20, 5, 3;	--z³y typ towarów dla danego magazynu

EXEC Dostawa 1, 'Arbuzy', 'Owoce', 0, 5, 3;	--"0", magazyn nie otrzyma towaru, ponadto, z³y typ towarów dla danego magazynu

EXEC Dostawa 4, 'Odkurzacze', 'AGD', 15, 4, 1;	--magazynier nie pracuje w danym magazynie

EXEC Dostawa 2, 'Marchew', 'Warzywa', 2, 5, 5; --ok


SELECT * FROM Sklad;
SELECT * FROM Towary;
SELECT * FROM Dostawcy;


--sprzeda¿ towaru z magazynu
CREATE PROC Sprzedaz
	@towar VARCHAR(10),
	@rodzaj VARCHAR(10),
	@ilosc INT,
	@komu VARCHAR(20),
	@magazyn INT,
	@magazynier INT

AS
BEGIN

DECLARE @sprzedaz VARCHAR(10) = 'wydano'

IF NOT EXISTS (SELECT *
				FROM Towary
					WHERE nazwa = @towar AND rodzaj = @rodzaj)
BEGIN
PRINT 'Brak towaru w magazynach'
END

ELSE BEGIN

IF NOT EXISTS (SELECT *
				FROM Towary
					WHERE nazwa = @towar AND rodzaj = @rodzaj AND magazyn = @magazyn)
BEGIN 
PRINT 'Brak danego towaru w tym magazynie'
END

ELSE
BEGIN

IF (@ilosc < 0)
BEGIN
PRINT 'Nie sprzedano zadnego towaru'
END

ELSE
BEGIN
	IF NOT EXISTS (SELECT *
					FROM Magazynierzy
						WHERE magazyn = @magazyn AND @magazynier = idM)
	BEGIN
	PRINT 'Magazynier nie pracuje w tym magazynie'
	END

	ELSE
	BEGIN
		IF NOT EXISTS (SELECT *
							FROM Towary T
							INNER JOIN Magazyny M
								ON T.nazwa = @towar AND T.magazyn = @magazyn AND @ilosc > M.poj_aktualna)
		BEGIN
			PRINT 'Niewystarczajaca ilosc towaru w magazynie!'
		END

		ELSE
		BEGIN
			UPDATE Towary
			SET ilosc = ilosc - @ilosc
			WHERE nazwa = @towar AND magazyn = @magazyn

			UPDATE Magazyny
			SET poj_aktualna = poj_aktualna - @ilosc
			WHERE id = @magazyn

			INSERT INTO Sklad VALUES (@towar, @rodzaj, @sprzedaz, @komu, @ilosc, @magazyn, @magazynier, GETDATE())
		END
	END
END
END
END
END;

EXEC Sprzedaz 'Ksi¹¿ki', 'Papier', 12, NULL, 7, 4;	--ok

EXEC Sprzedaz 'Ogórki', 'Warzywa', 3, NULL, 5, 2;	--ogórków nie ma w bazie

EXEC Sprzedaz 'Pomidory', 'Warzywa', 3, NULL, 5, 2;	--magazynier nie pracuje w magazynie

EXEC Sprzedaz 'Pomidory', 'Warzywa', 3, NULL, 1, 5;	--w danym magazynie nie ma pomidorów (warzyw ogólnie)

--dodawanie towaru do magazynu
CREATE PROC Dodaj_towar
@towar VARCHAR(10),
@rodzaj VARCHAR(10),
@ilosc INT,
@magazyn INT

AS
BEGIN 

IF NOT EXISTS (SELECT *
				FROM Magazyny 
				WHERE id = @magazyn AND towar = @rodzaj)
BEGIN
	PRINT 'Zly typ towaru dla tego magazynu!'
END

ELSE
	BEGIN
		IF NOT EXISTS (SELECT *
						FROM Magazyny
							WHERE poj_max > poj_aktualna + @ilosc)
		BEGIN
			PRINT 'Magazyn jest przepelniony!'
		END
		
		ELSE
		BEGIN			
INSERT INTO Towary VALUES (@towar, @ilosc, @rodzaj, @magazyn)
UPDATE Magazyny
SET poj_aktualna = poj_aktualna + @ilosc
WHERE id = @magazyn
END
END
END;

EXEC Dodaj_towar 'Truskawki', 'Owoce', 1, 1;	--ok

EXEC Dodaj_towar 'Pralki', 'AGD', 1, 4;	--ok

EXEC Dodaj_towar 'Kalafior', 'Warzywa', 1, 1;	--z³y typ towaru dla magazynu

EXEC Dodaj_towar 'Truskawki', 'Owoce', 1000, 1;	--Przekroczenie pojemnosci maksymalnej magazynu

--Wyrzucenie towaru z magazynu
CREATE PROC Wyrzuc_towar
	@towar VARCHAR(10),
	@magazyn INT

AS
BEGIN

UPDATE Magazyny
SET poj_aktualna = poj_aktualna - (SELECT SUM(ilosc)
										FROM Towary
											WHERE nazwa = @towar AND magazyn = @magazyn)

DELETE FROM Towary
WHERE nazwa = @towar AND magazyn = @magazyn

END;

DROP PROC Wyrzuc_towar;

EXEC Wyrzuc_towar 'Telewizory', 2;	--wyrzucenie telewizorów z magazynu 2

--Usuniêcie danego towaru z magazynów na terenie danego miasta
CREATE PROC Usun_z_miasta
	@towar VARCHAR(10),
	@miasto VARCHAR(10)

AS
BEGIN

UPDATE Magazyny
SET poj_aktualna = poj_aktualna - (SELECT SUM(ilosc)
										FROM Towary T
										INNER JOIN Magazyny M
											ON M. miasto = @miasto AND T.magazyn = M.id)

DELETE FROM Towary
WHERE nazwa = @towar AND magazyn IN (SELECT id
										FROM Magazyny
											WHERE miasto = @miasto)
END;

SELECT * FROM Towary;
SELECT * FROM Magazyny;

EXEC Usun_z_miasta 'Pralki', 'Bydgoszcz';	--Usuniêcie wszystkich pralek znajduj¹cych siê w magazynach w Bydgoszczy

--wyswietl raport roczny (ile transakcji zosta³o przeprowadzonych w roku...
CREATE PROC Rap_roczny
	@rok INT

AS
BEGIN

	SELECT *
		FROM Sklad
			WHERE YEAR(wykonano) = @rok
END;


EXEC Rap_roczny 2017;	--2017?)

	


--funkcje:


--ile srednio jednostek towaru zostalo dostarczonych do magazynów miesiêcznie...
CREATE FUNCTION IleTowarow
(
	@towar_roczny INT
)
	RETURNS INT
AS
BEGIN

	RETURN @towar_roczny / 12
END;

SELECT dbo.IleTowarow(5679);	--dla 5679 jednostek towaru dostarczonego w roku?


--w magazynach o jakich numerach znajduj¹ siê...
CREATE FUNCTION Wmagazynie
(
	@towar VARCHAR(10)
)
	RETURNS TABLE

AS
	RETURN SELECT magazyn
			FROM Towary
				WHERE nazwa = @towar;


SELECT * FROM Wmagazynie('Wiœnie');	--wiœnie?



--wyzwalacze:

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


