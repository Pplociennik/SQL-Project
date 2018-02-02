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

	