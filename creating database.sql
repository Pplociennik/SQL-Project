CREATE DATABASE Magazyny
GO

USE Magazyny
GO

CREATE TABLE Magazyny
(
    id      INT NOT NULL PRIMARY KEY,
    miasto  VARCHAR(10),
    towar  VARCHAR(10),
	pojemnosc INT
    CHECK (pojemnosc > 0)
);

CREATE TABLE Magazynierzy
(
    idM          INT NOT NULL PRIMARY KEY,
    imie         VARCHAR(20) NOT NULL,
    nazwisko     VARCHAR(20) NOT NULL,
    magazyn      INT REFERENCES Magazyny(id),
    zatrudniony  DATE
);

CREATE TABLE Sklad
(
	nazwa		VARCHAR(10),
	rodzaj		VARCHAR(10),
	status		VARCHAR(10),
	firma		VARCHAR(20),
	ilosc		INT,
	magazyn		INT REFERENCES Magazyny(id),
	magazynier	INT REFERENCES Magazynierzy(idM),
	wykonano	DATE
);

CREATE TABLE Dostawcy
(
	firma		VARCHAR(20),
	oferta		VARCHAR(20),
	siedziba	VARCHAR(20)
);

CREATE TABLE Towary
(
	nazwa		VARCHAR(10),
	ilosc		INT,
	rodzaj		VARCHAR(10),
	magazyn		INT REFERENCES Magazyny(id)
);

GO

INSERT INTO Magazyny VALUES (1, 'Poznañ', 'Owoce', 50);
INSERT INTO Magazyny VALUES (2, 'Poznañ', 'RTV', 65);
INSERT INTO Magazyny VALUES (3, 'Katowice', 'Owoce', 30);
INSERT INTO Magazyny VALUES (4, 'Bydgoszcz', 'AGD', 55);
INSERT INTO Magazyny VALUES (5, 'Szczecin', 'Warzywa', 20);
INSERT INTO Magazyny VALUES (6, 'Gdañsk', 'RTV', 75);
INSERT INTO Magazyny VALUES (7, 'Warszawa', 'Papier', 50);

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

INSERT INTO Sklad VALUES ('Wiœnie', 'Owoce', 'pobrano', 'Fresh Fruits', 1, 1, 2, '11-02-2017');
INSERT INTO Sklad VALUES ('Banany', 'Owoce', 'pobrano', 'FruityHealth', 4, 1, 2, '01-05-2018');
INSERT INTO Sklad VALUES ('Banany', 'Owoce', 'wydano', NULL, 1, 1, 2, '01-06-2018');
INSERT INTO Sklad VALUES ('Telewizory', 'RTV', 'pobrano', 'RTV/AGD Hurt', 1, 2, 1, '11-02-2017');
INSERT INTO Sklad VALUES ('Pralki', 'AGD', 'pobrano', 'SuperAGD', 12, 4, 3, '11-02-2017');
INSERT INTO Sklad VALUES ('Ksi¹¿ki', 'Papier', 'pobrano', 'GreatBooks', 27, 7, 4, '11-02-2017');
INSERT INTO Sklad VALUES ('Pomidory', 'Warzywa', 'pobrano', 'Wegetables 4YOU', 30, 5, 5, '11-02-2017');

INSERT INTO Towary VALUES ('Wiœnie', 1, 'Owoce', 1);
INSERT INTO Towary VALUES ('Banany', 3, 'Owoce', 1);
INSERT INTO Towary VALUES ('Telewizory', 1, 'RTV', 2);
INSERT INTO Towary VALUES ('Pralki', 12, 'AGD', 4);
INSERT INTO Towary VALUES ('Ksi¹¿ki', 27, 'Papier', 7);
INSERT INTO Towary VALUES ('Pomidory', 30, 'Warzywa', 5);

INSERT INTO Dostawcy VALUES ('Fresh Fruits', 'Owoce', 'Poznañ');
INSERT INTO Dostawcy VALUES ('Wegetables 4YOU', 'Warzywa', 'Sosnowiec');
INSERT INTO Dostawcy VALUES ('RTV/AGD Hurt', 'RTV', 'Warszawa');
INSERT INTO Dostawcy VALUES ('RTV/AGD Hurt', 'AGD', 'Warszawa');
INSERT INTO Dostawcy VALUES ('GreatBooks', 'Papier', 'Warszawa');
INSERT INTO Dostawcy VALUES ('SuperAGD', 'AGD', 'Bydgoszcz');
INSERT INTO Dostawcy VALUES ('FruityHealth', 'Owoce', 'Poznañ');

SELECT * FROM Magazyny;
SELECT * FROM Magazynierzy;
SELECT * FROM Towary;
SELECT * FROM Sklad;
SELECT * FROM Dostawcy;






