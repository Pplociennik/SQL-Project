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


--wyswietlenie tabeli
SELECT * FROM Magazyny;
SELECT * FROM Magazynierzy;
SELECT * FROM Towary;
SELECT * FROM Sklad;
SELECT * FROM Dostawcy;


