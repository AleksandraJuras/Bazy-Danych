-- 1. Tworzenie nowej bazy danych
CREATE DATABASE firma;
USE firma;

--2. Tworzenie nowego schematu
CREATE SCHEMA ksiegowosc

--3. Tworzenie tabeli 
CREATE TABLE ksiegowosc.pracownicy
(id_pracownika	NUMERIC(5)		CONSTRAINT pk_pr PRIMARY KEY	IDENTITY(1,1),
 imie			VARCHAR(30)		NOT NULL,
 nazwisko		VARCHAR(30)		NOT NULL,
 adres			VARCHAR(30)		NOT NULL,
 telefon		VARCHAR(12)		CHECK(LEN(telefon)>=9),
);

CREATE TABLE ksiegowosc.godziny
(id_godziny		NUMERIC(5)	CONSTRAINT pk_g PRIMARY KEY	IDENTITY(1,1),
 data			DATE		NOT NULL,
 liczba_godzin  NUMERIC(3)	NOT NULL,
 id_pracownika	NUMERIC(5)	NOT NULL,
);

CREATE TABLE ksiegowosc.pensje
(id_pensji		NUMERIC(5)	CONSTRAINT pk_pe PRIMARY KEY	IDENTITY(1,1),
 stanowisko		VARCHAR(30)	NOT NULL,
 kwota			FLOAT(8)	NOT NULL,
);

CREATE TABLE ksiegowosc.premie
(id_premii		NUMERIC(5)	CONSTRAINT pk_pre PRIMARY KEY	IDENTITY(1,1),
 rodzaj			VARCHAR(20)	NOT NULL,
 kwota			FLOAT(7) NOT NULL,
);

CREATE TABLE ksiegowosc.wynagrodzenia
(id_wynagrodzenia NUMERIC(5) CONSTRAINT pk_w PRIMARY KEY	IDENTITY(1,1),
 data			  DATE		 NOT NULL,
 id_pracownika	  NUMERIC(5) NOT NULL,
 id_godziny       NUMERIC(5) NOT NULL,
 id_pensji		  NUMERIC(5) NOT NULL,
 id_premii		  NUMERIC(5),
);


--3b. DODAJE KLUCZE OBCE ZA POMOCA ALTER TABLE
ALTER TABLE ksiegowosc.godziny ADD FOREIGN KEY(id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);
ALTER TABLE ksiegowosc.wynagrodzenia ADD FOREIGN KEY(id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);
ALTER TABLE ksiegowosc.wynagrodzenia ADD FOREIGN KEY(id_godziny) REFERENCES ksiegowosc.godziny(id_godziny);
ALTER TABLE ksiegowosc.wynargodzenia ADD FOREIGN KEY(id_pensji) REFERENCES ksiegowosc.penje(id_pensji);
ALTER TABLE ksiegowosc.wynagrodzenia ADD FOREIGN KEY(id_premii) REFERENCES ksiegowosc.premie(id_premii);

--4. WYPE£NIAM TABELE REKORDAMI
--a. pracownicy
INSERT INTO ksiegowosc.pracownicy(imie, nazwisko, adres, telefon) VALUES ('Andrzej', 'Bargiel', 'ul.Sikorki 45', '886767999')
INSERT INTO ksiegowosc.pracownicy(imie, nazwisko, adres, telefon) VALUES ('Tomasz', 'Fuziak', 'ul.Nowa 34', '885678940')
INSERT INTO ksiegowosc.pracownicy(imie, nazwisko, adres, telefon) VALUES ('Aleksandra', 'Koliñska', 'ul.Wolna 77', '678456789')
INSERT INTO ksiegowosc.pracownicy(imie, nazwisko, adres, telefon) VALUES ('Anna', 'Bia³ka', 'os.Lotników 37/56', '777890555')
INSERT INTO ksiegowosc.pracownicy(imie, nazwisko, adres, telefon) VALUES ('Bogus³aw', 'Monte', 'os.Bogaczy 44/77', '512789455')
INSERT INTO ksiegowosc.pracownicy(imie, nazwisko, adres, telefon) VALUES ('Dominik', 'Stanicki', 'os.Inwalidów 66/85 ', '567777908')
INSERT INTO ksiegowosc.pracownicy(imie, nazwisko, adres, telefon) VALUES ('Pawe³', 'Pilicki', 'ul.Moreny 32', '889678451')
INSERT INTO ksiegowosc.pracownicy(imie, nazwisko, adres, telefon) VALUES ('Patrycja', 'Porwa³a', 'ul.Kubicy 6', '666995000')
INSERT INTO ksiegowosc.pracownicy(imie, nazwisko, adres, telefon) VALUES ('Magdalena', 'Jorusza', 'os.Z³otego Wieku 35/99', '454989009')
INSERT INTO ksiegowosc.pracownicy(imie, nazwisko, adres, telefon) VALUES ('Genowefa', 'Kud³acz', 'ul.Or³ów 10', '881211774')
SELECT * FROM ksiegowosc.pracownicy
--b. godziny
INSERT INTO ksiegowosc.godziny(data, liczba_godzin, id_pracownika) VALUES ('2021/12/12', '178', '1')
INSERT INTO ksiegowosc.godziny(data, liczba_godzin, id_pracownika) VALUES ('2021/11/23', '160', '2')
INSERT INTO ksiegowosc.godziny(data, liczba_godzin, id_pracownika) VALUES ('2020/09/12', '150', '5')
INSERT INTO ksiegowosc.godziny(data, liczba_godzin, id_pracownika) VALUES ('2020/12/24', '146', '9')
INSERT INTO ksiegowosc.godziny(data, liczba_godzin, id_pracownika) VALUES ('2020/08/10', '120', '10')
INSERT INTO ksiegowosc.godziny(data, liczba_godzin, id_pracownika) VALUES ('2020/03/15', '134', '3')
INSERT INTO ksiegowosc.godziny(data, liczba_godzin, id_pracownika) VALUES ('2020/07/28', '123', '6')
INSERT INTO ksiegowosc.godziny(data, liczba_godzin, id_pracownika) VALUES ('2020/12/30', '145', '4')
INSERT INTO ksiegowosc.godziny(data, liczba_godzin, id_pracownika) VALUES ('2020/11/03', '122', '7')
INSERT INTO ksiegowosc.godziny(data, liczba_godzin, id_pracownika) VALUES ('2020/11/16', '162', '8')
SELECT * FROM ksiegowosc.godziny
--c. premie
INSERT INTO ksiegowosc.premie(rodzaj, kwota) VALUES ('regulaminowa', 321.89)
INSERT INTO ksiegowosc.premie(rodzaj, kwota) VALUES ('regulaminowa', 334.34)
INSERT INTO ksiegowosc.premie(rodzaj, kwota) VALUES ('regulaminowa', 298.90)
INSERT INTO ksiegowosc.premie(rodzaj, kwota) VALUES ('uznaniowa', 456.99)
INSERT INTO ksiegowosc.premie(rodzaj, kwota) VALUES ('regulaminowa', 301.46)
INSERT INTO ksiegowosc.premie(rodzaj, kwota) VALUES ('uznaniowa', 437.90)
INSERT INTO ksiegowosc.premie(rodzaj, kwota) VALUES ('uznaniowa', 678.91)
INSERT INTO ksiegowosc.premie(rodzaj, kwota) VALUES ('regulaminowa', 789.21)
INSERT INTO ksiegowosc.premie(rodzaj, kwota) VALUES ('regulaminowa', 197.66)
INSERT INTO ksiegowosc.premie(rodzaj, kwota) VALUES ('uznaniowa', 543.11)
SELECT * FROM ksiegowosc.premie
--d. pensje
INSERT INTO ksiegowosc.pensje(stanowisko, kwota) VALUES ('Project meneger', '5200')
INSERT INTO ksiegowosc.pensje(stanowisko, kwota) VALUES ('Analityk biznesowy', '6200')
INSERT INTO ksiegowosc.pensje(stanowisko, kwota) VALUES ('Architekt systemu', '5300')
INSERT INTO ksiegowosc.pensje(stanowisko, kwota) VALUES ('Tester oprogramownaia', '4900')
INSERT INTO ksiegowosc.pensje(stanowisko, kwota) VALUES ('Administrator sici LAN', '5300')
INSERT INTO ksiegowosc.pensje(stanowisko, kwota) VALUES ('Administrator sici WAN', '5300')
INSERT INTO ksiegowosc.pensje(stanowisko, kwota) VALUES ('Administrator serwerów', '6100')
INSERT INTO ksiegowosc.pensje(stanowisko, kwota) VALUES ('Informatyk', '4800')
INSERT INTO ksiegowosc.pensje(stanowisko, kwota) VALUES ('Grafik komputerowy', '6600')
INSERT INTO ksiegowosc.pensje(stanowisko, kwota) VALUES ('In¿ynier oprogramowania', '5000')
SELECT * FROM ksiegowosc.pensje
--e. wynagrodzenia
INSERT INTO ksiegowosc.wynagrodzenia(data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES ('12/03/2021', '2', '2', '1', '2')
INSERT INTO ksiegowosc.wynagrodzenia(data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES ('12/03/2021', '3', '3', '3', '3')
INSERT INTO ksiegowosc.wynagrodzenia(data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES ('12/03/2021', '1', '1', '2', '2')
INSERT INTO ksiegowosc.wynagrodzenia(data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES ('12/04/2021', '4', '5', '5', '6')
INSERT INTO ksiegowosc.wynagrodzenia(data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES ('12/03/2021', '5', '4', '4', '7')
INSERT INTO ksiegowosc.wynagrodzenia(data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES ('12/03/2021', '6', '8', '6', '9')
INSERT INTO ksiegowosc.wynagrodzenia(data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES ('12/02/2021', '7', '6', '8', '10')
INSERT INTO ksiegowosc.wynagrodzenia(data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES ('12/03/2021', '8', '7', '7', null)
INSERT INTO ksiegowosc.wynagrodzenia(data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES ('12/03/2021', '10', '9', '10', null)
INSERT INTO ksiegowosc.wynagrodzenia(data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES ('12/03/2021', '9', '10', '9', '8')
SELECT * FROM ksiegowosc.wynagrodzenia

-- 4. Komentarze do tabel
EXEC sp_addextendedproperty   
@name = N'Description_pracownicy',   
@value = 'Ta tablica przedstawia dane pracowników',  
@level0type = N'Schema', @level0name = 'ksiegowosc',  
@level1type = N'Table',  @level1name = 'pracownicy';   
GO 

EXEC sp_addextendedproperty   
@name = N'Description_godziny',   
@value = 'Ta tablica przedstawia ilosc przepracowanych godzin',  
@level0type = N'Schema', @level0name = 'ksiegowosc',  
@level1type = N'Table',  @level1name = 'godziny';   
GO 

EXEC sp_addextendedproperty   
@name = N'Description_pensje',   
@value = 'Ta tablica przedstawia wielkosc pensji dla danego stanowiska',  
@level0type = N'Schema', @level0name = 'ksiegowosc',  
@level1type = N'Table',  @level1name = 'pensje';   
GO 

EXEC sp_addextendedproperty   
@name = N'Description_premie',   
@value = 'Ta tabela przedstawia premie',  
@level0type = N'Schema', @level0name = 'ksiegowosc',  
@level1type = N'Table',  @level1name = 'premie';   
GO 

EXEC sp_addextendedproperty   
@name = N'Description_wynagrodzenie',   
@value = 'Ta tabela ³¹czy wszytkie pozosta³e ',  
@level0type = N'Schema', @level0name = 'ksiegowosc',  
@level1type = N'Table',  @level1name = 'wynagrodzenia';   
GO 

--5. zaczynamy podpunkty
--a) Wyœwietl tylko id pracownika oraz jego nazwisko
SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy

--b) Wyœwietl id pracowników, których p³aca jest wiêksza ni¿ 5200
SELECT id_pracownika FROM ksiegowosc.wynagrodzenia WHERE id_pensji IN (SELECT id_pensji FROM ksiegowosc.pensje WHERE kwota > '5200')

--c) Wyœwietl id pracowników nieposiadaj¹cych premii,których p³aca jest wiêksza ni¿ 2000.
SELECT id_pracownika FROM ksiegowosc.wynagrodzenia WHERE id_premii is null AND id_pensji IN (SELECT id_pensji FROM ksiegowosc.pensje WHERE kwota > '2000')

--d) Wyœwietl pracowników, których pierwsza litera imienia zaczyna siê na literê ‘P’
SELECT * FROM ksiegowosc.pracownicy WHERE pracownicy.imie LIKE 'P%'

--e) Wyœwietl pracowników, których nazwisko zawiera literê ‘r’ oraz imiê koñczy siê na literê ‘a’
SELECT * FROM ksiegowosc.pracownicy WHERE pracownicy.imie LIKE '%a' AND pracownicy.nazwisko LIKE '%r%'

--f) Wyœwietl imiê i nazwisko pracowników oraz liczbê ich nadgodzin, przyjmuj¹c, i¿ standardowy czas pracy to 160 h miesiêcznie
SELECT imie, nazwisko, (liczba_godzin-160) AS nadgodziny FROM ksiegowosc.pracownicy 
INNER JOIN ksiegowosc.godziny ON godziny.id_godziny = pracownicy.id_pracownika WHERE liczba_godzin > 160

--g) Wyœwietl imiê i nazwisko pracowników, których pensja zawiera siê w przedziale 4800 –5300PLN
SELECT imie, nazwisko, kwota FROM ksiegowosc.wynagrodzenia 
INNER JOIN ksiegowosc.pracownicy ON wynagrodzenia.id_pracownika = pracownicy.id_pracownika 
INNER JOIN ksiegowosc.pensje ON wynagrodzenia.id_pensji = pensje.id_pensji WHERE kwota<5300 AND kwota>4800

--h) Wyœwietl imiê i nazwisko pracowników, którzy pracowali w nadgodzinachi nie otrzymali premii
SELECT imie, nazwisko, liczba_godzin, id_premii FROM ksiegowosc.wynagrodzenia 
INNER JOIN ksiegowosc.pracownicy ON wynagrodzenia.id_pracownika = pracownicy.id_pracownika 
INNER JOIN ksiegowosc.godziny ON wynagrodzenia.id_godziny = godziny.id_godziny  WHERE liczba_godzin>160 AND id_premii is null

--i) Uszereguj pracowników wed³ug pensji
SELECT imie, nazwisko, kwota FROM ksiegowosc.wynagrodzenia 
INNER JOIN ksiegowosc.pracownicy ON wynagrodzenia.id_pracownika = pracownicy.id_pracownika 
INNER JOIN ksiegowosc.pensje ON wynagrodzenia.id_pensji = pensje.id_pensji ORDER BY kwota

--j) Uszereguj pracowników wed³ug pensji i premii malej¹co
SELECT imie, nazwisko, pensje.kwota, premie.kwota FROM ksiegowosc.wynagrodzenia
INNER JOIN ksiegowosc.pracownicy ON wynagrodzenia.id_pracownika = pracownicy.id_pracownika
INNER JOIN ksiegowosc.pensje ON wynagrodzenia.id_pensji = pensje.id_pensji
INNER JOIN ksiegowosc.premie ON wynagrodzenia.id_premii = premie.id_premii
ORDER BY pensje.kwota, premie.kwota

--k) Zlicz i pogrupuj pracowników wed³ug pola ‘stanowisko’
SELECT stanowisko, COUNT(pensje.stanowisko) AS suma FROM ksiegowosc.wynagrodzenia 
INNER JOIN ksiegowosc.pracownicy ON wynagrodzenia.id_pracownika = pracownicy.id_pracownika
INNER JOIN ksiegowosc.pensje ON wynagrodzenia.id_pensji = pensje.id_pensji
GROUP BY pensje.stanowisko

--l)Policz œredni¹, minimaln¹ i maksymaln¹ p³acê dla stanowiska ‘kierownik’ (je¿eli takiego nie masz, to przyjmij dowolne inne)
SELECT MIN(kwota) AS min_kwota, MAX(kwota) AS max_kwota, AVG(kwota) AS mean_kwota
FROM ksiegowosc.pensje 
WHERE pensje.stanowisko = 'Informatyk'

--m) Policz sumê wszystkich wynagrodzeñ
SELECT SUM(kwota) as suma
FROM ksiegowosc.pensje

--n) Policz sumê wynagrodzeñ w ramach danego stanowiska
 SELECT stanowisko, SUM(kwota) AS suma, COUNT(stanowisko) AS stanowisko FROM ksiegowosc.pensje GROUP BY stanowisko

 --o) Wyznacz liczbê premii przyznanych dla pracowników danego stanowiska
 SELECT stanowisko, COUNT(premie.id_premii) as ilosc_premii FROM ksiegowosc.wynagrodzenia 
 INNER JOIN ksiegowosc.pensje ON wynagrodzenia.id_pensji = pensje.id_pensji 
 INNER JOIN ksiegowosc.premie ON wynagrodzenia.id_premii = premie.id_premii
 GROUP BY stanowisko

 --p) Usuñ wszystkich pracowników maj¹cych pensjê mniejsz¹ ni¿ 1200 z³
 DELETE pracownicy FROM ksiegowosc.wynagrodzenia 
 INNER JOIN ksiegowosc.pracownicy ON wynagrodzenia.id_pracownika = pracownicy.id_pracownika
 INNER JOIN ksiegowosc.pensje ON wynagrodzenia.id_pensji = pensje.id_pensji  WHERE kwota < 1200