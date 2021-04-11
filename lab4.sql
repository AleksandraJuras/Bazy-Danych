-- 1. Tworzenie nowej bazy danych
CREATE DATABASE firma;
USE firma;

--2. Tworzenie nowego schematu
CREATE SCHEMA rozliczenia;

--3. Tworzenie tabeli 
CREATE TABLE rozliczenia.pracownicy
(id_pracownika	NUMERIC(5)		CONSTRAINT pk_pr PRIMARY KEY	IDENTITY(1,1),
 imie			VARCHAR(30)		NOT NULL,
 nazwisko		VARCHAR(30)		NOT NULL,
 adres			VARCHAR(30)		NOT NULL,
 telefon		VARCHAR(12)		CHECK(LEN(telefon)>=9),
);

CREATE TABLE rozliczenia.godziny
(id_godziny		NUMERIC(5)	CONSTRAINT pk_g PRIMARY KEY	IDENTITY(1,1),
 data			DATE,
 liczba_godzin  NUMERIC(8)	NOT NULL,
 id_pracownika	NUMERIC(5)	NOT NULL,
);

CREATE TABLE rozliczenia.pensje
(id_pensje		NUMERIC(5)	CONSTRAINT pk_pe PRIMARY KEY	IDENTITY(1,1),
 stanowisko		VARCHAR(30)	NOT NULL,
 kwota			FLOAT(8)	NOT NULL,
 id_premii		NUMERIC(5),
);

CREATE TABLE rozliczenia.premie
(id_premii		NUMERIC(5)	CONSTRAINT pk_pre PRIMARY KEY	IDENTITY(1,1),
 rodzoj			VARCHAR(20)	NOT NULL,
 kwota			FLOAT(7),
);

--3b. DODAJE KLUCZE OBCE ZA POMOCA ALTER TABLE I ZMIENIAM TEZ NAZWE TABELI
USE firma
EXEC sp_rename 'rozliczenia.premie.rodzoj', 'rodzaj', 'COLUMN';

ALTER TABLE rozliczenia.godziny ADD FOREIGN KEY(id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);
ALTER TABLE rozliczenia.pensje ADD FOREIGN KEY(id_premii) REFERENCES rozliczenia.premie(id_premii);

--4. WYPE£NIAM TABELE REKORDAMI
--a. pracownicy
INSERT INTO rozliczenia.pracownicy(imie, nazwisko, adres, telefon) VALUES ('Andrzej', 'Bargiel', 'ul.Sikorki 45', '886767999')
INSERT INTO rozliczenia.pracownicy(imie, nazwisko, adres, telefon) VALUES ('Tomasz', 'Fuziak', 'ul.Nowa 34', '885678940')
INSERT INTO rozliczenia.pracownicy(imie, nazwisko, adres, telefon) VALUES ('Aleksandra', 'Koliñska', 'ul.Wolna 77', '678456789')
INSERT INTO rozliczenia.pracownicy(imie, nazwisko, adres, telefon) VALUES ('Anna', 'Bia³ka', 'os.Lotników 37/56', '777890555')
INSERT INTO rozliczenia.pracownicy(imie, nazwisko, adres, telefon) VALUES ('Bogus³aw', 'Monte', 'os.Bogaczy 44/77', '512789455')
INSERT INTO rozliczenia.pracownicy(imie, nazwisko, adres, telefon) VALUES ('Dominik', 'Stanicki', 'os.Inwalidów 66/85 ', '567777908')
INSERT INTO rozliczenia.pracownicy(imie, nazwisko, adres, telefon) VALUES ('Pawe³', 'Pilicki', 'ul.Moreny 32', '889678451')
INSERT INTO rozliczenia.pracownicy(imie, nazwisko, adres, telefon) VALUES ('Patrycja', 'Porwa³a', 'ul.Kubicy 6', '666995000')
INSERT INTO rozliczenia.pracownicy(imie, nazwisko, adres, telefon) VALUES ('Magdalena', 'Jorusza', 'os.Z³otego Wieku 35/99', '454989009')
INSERT INTO rozliczenia.pracownicy(imie, nazwisko, adres, telefon) VALUES ('Genowefa', 'Kud³acz', 'ul.Or³ów 10', '881211774')
SELECT * FROM rozliczenia.pracownicy
--b. godziny
INSERT INTO rozliczenia.godziny(data, liczba_godzin, id_pracownika) VALUES ('2021/12/12', '67', '1')
INSERT INTO rozliczenia.godziny(data, liczba_godzin, id_pracownika) VALUES ('2021/11/23', '90', '2')
INSERT INTO rozliczenia.godziny(data, liczba_godzin, id_pracownika) VALUES ('2020/09/12', '101', '5')
INSERT INTO rozliczenia.godziny(data, liczba_godzin, id_pracownika) VALUES ('2020/12/24', '24', '9')
INSERT INTO rozliczenia.godziny(data, liczba_godzin, id_pracownika) VALUES ('2020/08/10', '57', '10')
INSERT INTO rozliczenia.godziny(data, liczba_godzin, id_pracownika) VALUES ('2020/03/15', '18', '3')
INSERT INTO rozliczenia.godziny(data, liczba_godzin, id_pracownika) VALUES ('2020/07/28', '37', '6')
INSERT INTO rozliczenia.godziny(data, liczba_godzin, id_pracownika) VALUES ('2020/12/30', '32', '4')
INSERT INTO rozliczenia.godziny(data, liczba_godzin, id_pracownika) VALUES ('2020/11/03', '20', '7')
INSERT INTO rozliczenia.godziny(data, liczba_godzin, id_pracownika) VALUES ('2020/11/16', '13', '8')
SELECT * FROM rozliczenia.godziny
--c. premie
INSERT INTO rozliczenia.premie(rodzaj, kwota) VALUES ('regulaminowa', 321.89)
INSERT INTO rozliczenia.premie(rodzaj, kwota) VALUES ('regulaminowa', 334.34)
INSERT INTO rozliczenia.premie(rodzaj, kwota) VALUES ('regulaminowa', 298.90)
INSERT INTO rozliczenia.premie(rodzaj, kwota) VALUES ('uznaniowa', 456.99)
INSERT INTO rozliczenia.premie(rodzaj, kwota) VALUES ('regulaminowa', 301.46)
INSERT INTO rozliczenia.premie(rodzaj, kwota) VALUES ('uznaniowa', 437.90)
INSERT INTO rozliczenia.premie(rodzaj, kwota) VALUES ('uznaniowa', 678.91)
INSERT INTO rozliczenia.premie(rodzaj, kwota) VALUES ('regulaminowa', 789.21)
INSERT INTO rozliczenia.premie(rodzaj, kwota) VALUES ('regulaminowa', 197.66)
INSERT INTO rozliczenia.premie(rodzaj, kwota) VALUES ('uznaniowa', 543.11)
SELECT * FROM rozliczenia.premie
--d. pensje
INSERT INTO rozliczenia.pensje(stanowisko, kwota, id_premii) VALUES ('Project meneger', '5200', 1)
INSERT INTO rozliczenia.pensje(stanowisko, kwota, id_premii) VALUES ('Analityk biznesowy', '6200', 3)
INSERT INTO rozliczenia.pensje(stanowisko, kwota, id_premii) VALUES ('Architekt systemu', '5300', 5)
INSERT INTO rozliczenia.pensje(stanowisko, kwota, id_premii) VALUES ('Tester oprogramownaia', '4900', 7)
INSERT INTO rozliczenia.pensje(stanowisko, kwota, id_premii) VALUES ('Administrator sici LAN', '5300', 9)
INSERT INTO rozliczenia.pensje(stanowisko, kwota, id_premii) VALUES ('Administrator sici WAN', '5300', 2)
INSERT INTO rozliczenia.pensje(stanowisko, kwota, id_premii) VALUES ('Administrator serwerów', '6100', 4)
INSERT INTO rozliczenia.pensje(stanowisko, kwota, id_premii) VALUES ('Informatyk', '4800', 6)
INSERT INTO rozliczenia.pensje(stanowisko, kwota, id_premii) VALUES ('Grafik komputerowy', '6600', 8)
INSERT INTO rozliczenia.pensje(stanowisko, kwota, id_premii) VALUES ('In¿ynier oprogramowania', '5000', 10)
SELECT * FROM rozliczenia.pensje

--5. WYŒWIETL PRACOWNIKÓW I ICH ADRESY

SELECT nazwisko, adres FROM rozliczenia.pracownicy;

--6. KONWERSJA

SELECT id_godziny, liczba_godzin, id_pracownika, DATEPART(wk,[data]) as [tyg],DATEPART(mm,[data]) as [mies] From rozliczenia.godziny


--7. KWOTA NETTO I KWOTA BRUTTO

EXEC sp_rename 'rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN';
ALTER TABLE rozliczenia.pensje ADD kwota_netto FLOAT(8) NULL;
UPDATE rozliczenia.pensje SET kwota_netto = kwota_brutto*0.81