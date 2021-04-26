USE firma

--a. Zmodyfikuj numer telefonu dodajac +48
UPDATE ksiegowosc.pracownicy
SET telefon = '+48'+ telefon  
WHERE telefon NOT LIKE '+%'
SELECT telefon FROM ksiegowosc.pracownicy

--b. 
UPDATE ksiegowosc.pracownicy
SET telefon = Replace(telefon, '+48','')
WHERE telefon LIKE '+48%'

UPDATE ksiegowosc.pracownicy
SET telefon = SUBSTRING(telefon, 1, 3) + '-' + SUBSTRING(telefon, 4, 3) + '-' + SUBSTRING(telefon, 7, 3)

--c. Wyswietl dane pracownika, ktorego nazwisko jest najdluzsze, uzywajac duzych liter
SELECT id_pracownika, UPPER(nazwisko), UPPER(imie), UPPER(adres), telefon 
FROM ksiegowosc.pracownicy
WHERE len(nazwisko) = (SELECT max(len(nazwisko)) FROM ksiegowosc.pracownicy)

--d. Wyswietl pracownikow i ich pensje zakodowane przy pomocy algorytmu md5
SELECT imie, nazwisko, adres, telefon, HashBytes('MD5', CAST(kwota AS VARCHAR(6))) AS pensje_hash FROM ksiegowosc.wynagrodzenia 
INNER JOIN ksiegowosc.pracownicy ON wynagrodzenia.id_pracownika = pracownicy.id_pracownika
INNER JOIN ksiegowosc.pensje ON wynagrodzenia.id_pensji = pensje.id_pensji

--e. Wyswietl pracownikow, ich pensje oraz premie. Wykorzystaj zlaczenie lewostronne
SELECT imie, nazwisko, adres, telefon, pensje.kwota, premie.kwota FROM ksiegowosc.pracownicy 
INNER JOIN ksiegowosc.wynagrodzenia ON wynagrodzenia.id_pracownika = pracownicy.id_pracownika
LEFT JOIN ksiegowosc.pensje ON wynagrodzenia.id_pensji = pensje.id_pensji
LEFT JOIN ksiegowosc.premie ON wynagrodzenia.id_premii = premie.id_premii

--f. Wygeneruj raport(zapytanie), które zwróci w wyniku tresc wg ponizszego szablonu
SELECT 'Pracownik ' + imie + ' '+ nazwisko + ', w dniu ' + CAST(wynagrodzenia.data AS nvarchar(10)) + ' otrzyma³ pensje calkowit¹ na kwote ' + CAST(premie.kwota+pensje.kwota AS nvarchar(10)) +
', gdzie wynagrodzenie zasadnicze wynosi³o: ' + CAST(pensje.kwota AS nvarchar(10)) + ', premia: ' + CAST(premie.kwota AS nvarchar(10)) + ' nadgoziny: '+
CAST((liczba_godzin-160)*25 AS varchar(10)) + 'zl'
AS raport FROM ksiegowosc.wynagrodzenia 
INNER JOIN ksiegowosc.pracownicy ON wynagrodzenia.id_pracownika = pracownicy.id_pracownika
INNER JOIN ksiegowosc.godziny ON wynagrodzenia.id_godziny = godziny.id_godziny
INNER JOIN ksiegowosc.pensje ON wynagrodzenia.id_pensji = pensje.id_pensji
INNER JOIN ksiegowosc.premie ON wynagrodzenia.id_premii = premie.id_premii

