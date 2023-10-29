--zadanie 1  Projekcja wyników zapytań (SELECT ... FROM ...)
--1.1 Wyświetlić zawartość wszystkich kolumn z tabeli pracownik.

SELECT * FROM pracownik; 

--1.2 Z tabeli pracownik wyświetlić same imiona pracowników.

SELECT imie FROM pracownik;

--1.3 Wyświetlić zawartość kolumn imię, nazwisko i data_zatrudnienia z tabeli pracownik.

SELECT imie, naziwsko, data_zatrudnienia

--zadanie 2 Sortowanie wyników zapytań (ORDER BY)
--2.1 Wyświetlić zawartość kolumn imię, nazwisko i pensja z tabeli pracownik. Wynik posortuj malejąco względem pensji .

SELECT imie, nazwisko, pensja FROM pracownik ORDER BY pensja DESC;

--2.2 Wyświetl zawartość kolumn nazwisko i imię z tabeli pracownik. Wynik posortuj rosnąco (leksykograficznie) względem nazwiska i imienia.

SELECT imie, nazwisko FROM pracownik ORDER BY nazwisko, imie;

--2.3 Wyświetlić zawartość kolumn nazwisko, pensja, dodatek z tabeli pracownik. Wynik posortuj rosnąco względem pensji, a dla tych samych wartości  pola pensja malejąco względem dodatku.

SELECT imie, nazwisko, pensja, dodatek FROM pracownik ORDER BY pensja, dodatek DESC;

--zadanie 3 Eliminowanie duplikatów wyników zapytań (DISTINCT)
--3.1 Wyświetlić niepowtarzające się wartości kolumny pensja z tabeli pracownik.

SELECT DISTINCT pensja FROM pracownik;

--3.2 Wyświetlić unikatowe wiersze zawierające wartości kolumn pensja i dodatek w tabeli pracownik.

SELECT DISTINCT pensja, dodatek FROM pracownik;

--3.3 Wyświetlić unikatowe wiersze zawierające wartości kolumn pensja i dodatek w tabeli pracownik. Wynik posortujmalejąco względem pensji i dodatku.

SELECT DISTINCT pensja, dodatek FROM pracownik ORDER BY pensja DESC, dodatek DESC;

--zadanie 4 Selekcja wyników zapytań (WHERE)
--4.1 Znajdź klientów o imieniu Jan. Wyświetl ich imiona i nazwiska.

SELECT imie, nazwisko FROM pracownik WHERE imie='Jan';

--4.2 Wyświetlić imiona i nazwiska klientów, którzy jako haslo ustawili słowo 'password'

SELECT imie, nazwisko FROM klient WHERE haslo='password';

--4.3 Wyświetlić imiona, nazwiska, pensje pracowników , którzy zarabiają powyżej 1500 zł. Wynik posortuj malejąco względem pensji.

SELECT imie, nazwisko, pensja FROM pracownik WHERE pensja > 1500 ORDER BY pensja DESC;

--Zadanie 5
--Warunki złożone (AND, OR, NOT)
5.1 Znajdź produkty (id_produkt, id_producent,nazwa), których cena netto jest mniejsza od 10zl ale większa niż 5 zl.

SELECT id_produkt, id_producent, nazwa FROM produkt WHERE cena_netto < 10 AND cena_netto > 5;

--5.2  Znajdź produkty (id_produkt, id_producent,nazwa, cena_netto), których cena netto jest mniejsza od 10zl lub większa niż 5000zl.

SELECT id_produkt, id_producent, nazwa FROM produkt WHERE cena_netto < 10 OR cena_netto > 5000;

--5.3  Znajdź te produkty, których podatek jest 23% a ich cena jest większa niż 500zl.

SELECT id_produkt, id_producent, nazwa, cena_netto, podatek FROM produkt WHERE podatek = 23 AND cena_netto > 500;
------------------

--6 Predykat IN 
--6.1 Znaleźć klientów o imionach 'Tomasz ' , Robert' lub 'Jan'

SELECT * FROM klient WHERE imie IN ('Tomasz', 'Robert', 'Jan');

--6.2 Znajdź pracowników o imionach Anna, Marzena i Alicja. Wyświetl ich imiona, nazwiska i daty zatrudnienia. 

SELECT imie, nazwisko, data_zatrudnienia FROM pracownik WHERE imie IN ('Anna', 'Marzena', 'Alicja');
 

--7.  Predykat LIKE 
--7.1 Wyświetlić imiona i nazwiska klientów, których nazwisko zawiera literę K.

SELECT imie, nazwisko FROM klient WHERE nazwisko LIKE '%k%';

--7.2 Wyświetlić imiona i nazwiska klientów, dla których nazwisko zaczyna się na D, a kończy się na SKI. 

SELECT imie, nazwisko FROM klient WHERE nazwisko LIKE 'D%ski';

--7.3 Znaleźć imiona i nazwiska klientów, których nazwisko zawiera drugą literę O lub A. 

SELECT imie, nazwisko FROM klient WHERE nazwisko LIKE '_a%' OR nazwisko LIKE '_o%';


--8 Predykat BETWEEN
--8.1 Z tabeli pracownik wyświetlić wiersze, dla których pensja jest z przedziału [3500,5000].

SELECT * FROM pracownik WHERE pensja BETWEEN 3500 AND 5000;

--8.2 Znaleźć pracowników, którzy zostali zatrudnieni pomiędzy datami 2010-01-01 a 2011-12-31. 

SELECT * FROM pracownik WHERE data_zatrudnienia BETWEEN '2010-01-01' AND '2011-12-31';

--9 Wartość NULL 
--9.1 Znaleźć pracowników, którzy nie mają określonego dodatku do pensji.

SELECT * FROM pracownik WHERE dodatek IS NULL; 

--9.2 Dla każdego pracownika wyświetl imię, nazwisko i wysokość dodatku. Wartość NULL z kolumny dodatek powinna być wyświetlona jako 0. Wskazówka: Użyj funkcji COALESCE.

SELECT imie, nazwisko, COALESCE(dodatek,'0') FROM pracownik;

--10 Kolumny wyliczeniowe (COALESCE) 
--10.1 Wyświetlić imiona, nazwiska pracowników ich pensje i dodatki oraz kolumnę wyliczeniową do_zapłaty, zawierającą sumę pensji i dodatku. Wskazówka: Wartość NULL z kolumny dodatek powinna być wyświetlona jako zero.

SELECT imie, nazwisko, pensja, COALESCE(dodatek,'0'), pensja+COALESCE(dodatek,'0') AS 'do_zaplaty' FROM pracownik; 

--10.2 Dla każdego pracownika wyświetl imię, nazwisko i wyliczeniową kolumnę nowa_pensja, która będzie miała o 50% większą wartość niż dotychczasowe zarobki.

SELECT imie, nazwisko, (pensja + COALESCE(dodatek, 0)) * 1.5 AS 'nowa_pensja' FROM pracownik;

--10.3 Dla każdego pracownika oblicz ile wynosi 1% zarobków (pensja + dodatek). Wyświetl imię, nazwisko i obliczony 1%. Wyniki posortuj rosnąco względem obliczonego 1%.

SELECT imie, nazwisko, (pensja+COALESCE(dodatek,'0'))*0.01 AS 'procent' FROM pracownik ORDER BY procent;

--11 Ograniczanie wyników wyszukiwania (TOP) 
--11.1 Znajdź imię i nazwisko pracownika, który jako pierwszy został zatrudniony w sklepie. (Jest tylko jeden taki pracownik.) 

SELECT TOP 1 imie, nazwisko, data_zatrudnienia FROM pracownik ORDER BY data_zatrudnienia;

--11.2 Wyświetl pierwszych czterech pracowników z alfabetycznej listy (nazwiska i imiona) wszystkich pracowników. (W tym zadaniu nie musisz się przejmować powtórkami imion i nazwisk, ale gdybyś chciał to sprawdź konstrukcję SELECT TOP x WITH TIES …)

SELECT TOP 4 imie, nazwisko FROM pracownik ORDER BY nazwisko, imie;


--12 Wybrane funkcje daty i czasu (DAY, MONTH, YEAR, GETDATE, DATEDIFF) 
--12.1 Wyszukaj pracowników zatrudnionych w maju. Wyświetl ich imiona, nazwiska i datę zatrudnienia. Wynik posortuj rosnąco względem nazwiska i imienia. Wskazówka: Zajrzyj do dokumentacji MS SQL i poczytaj o funkcjach: DAY, MONTH, YEAR, GETDATE, DATEDIFF. 

SELECT imie, nazwisko, data_zatrudnienia FROM pracownik WHERE MONTH(data_zatrudnienia)='5' ORDER BY nazwisko, imie;

--12.2 Dla każdego pracownika (imię i nazwisko) oblicz ile już pracuje dni. Wynik posortuj malejąco według ilości przepracowanych dni. 

SELECT imie, nazwisko, DATEDIFF(d, data_zatrudnienia, GETDATE()) AS "Dni" FROM pracownik ORDER BY Dni DESC;

--13 Wybrane funkcje operujące na napisach (LEFT, RIGHT, LEN, UPPER, LOWER, STUFF) (Trudne)
--13.1 Wyświetl imię, nazwisko i inicjały każdego klienta. Wynik posortuj względem inicjałów, nazwiska i imienia klienta. Wskazówka: Zajrzyj do dokumentacji MS SQL i poczytaj o funkcjach: LEFT, RIGHT, LEN, UPPER, LOWER, STUFF. 

SELECT imie, nazwisko, LEFT(imie, 1) AS "Inicjal imienia", LEFT(nazwisko, 1) AS "Inicjal nazwiska" FROM klient ORDER BY LEFT(nazwisko, 1), LEFT(imie, 1), nazwisko, imie;

--13.2 Wyświetl imiona i nazwiska klientów w taki sposób, aby pierwsza litera imienia i nazwiska była wielka, a pozostałe małe.

SELECT UPPER(LEFT(imie,1))+LOWER(SUBSTRING(imie,2,LEN(imie))) AS "Imie", UPPER(LEFT(nazwisko,1))+LOWER(SUBSTRING(nazwisko,2,LEN(nazwisko))) AS "Nazwisko" FROM klient;

--13.3 Wyświetl imiona, nazwiska, adresy email oraz hasla. Każdy znak hasła powinien być zastąpiony znakiem x.

SELECT imie, nazwisko, email, REPLICATE('x', LEN(haslo)) FROM klient;
----------------

--14 Modyfikacja danych w bazie danych (UPDATE) 
UPDATE nazwa_tabeli  SET nazwa_kolumny= ...... [WHERE .....]
--14.1 Pracownikom, którzy nie mają określonej wysokości dodatku nadaj dodatek w wysokości 50 zł. 

UPDATE pracownik SET dodatek = 50 where dodatek is null;

--14.2 Klientowi o identyfikatorze równym 10 zmień imię i nazwisko na Jerzy Nowak. 

UPDATE klient SET imie = 'Jerzy', nazwisko = 'Nowak' where id_klient = 10;

--14.3 Zwiększ o 100 zł dodatek pracownikom, których pensja jest mniejsza niż 1500 zł. 

UPDATE pracownik SET dodatek = dodatek + 100 WHERE pensja < 1500;

--15 Usuwanie danych z bazy danych (DELETE) 
DELETE FROM nazwa_ tabeli WHERE ......
--15.1 Usunąć klienta o identyfikatorze równym 17. 

DELETE FROM klient WHERE id_klient = 17;

--15.2 Usunąć wszystkie informacje o fakturach klienta o identyfikatorze równym 3. 

DELETE FROM faktura WHERE id_klient = 3;

--16 Dodawanie danych do bazy danych (INSERT) 
INSERT INTO nazwa_tabeli(kolumna1, kolumna2,...) VALUES ( wartości oddzielone przecinkami, ciągi znaków w apostrofach)
--16.1 Dodaj do bazy danych klienta o identyfikatorze równym 121: Adam Cichy zamieszkały ul. Korzenna 12, 00-950 Warszawa, tel. 123-454-321, pesel: 56121201234, email:Acichy@oo.pl; haslo:haslo ; rabat 0; dodany dzisiaj.

INSERT INTO adres VALUES (55, 'Korzenna', '12', '00-950', 'Warszawa')

INSERT INTO klient(id_klient, id_adres, imie, nazwisko, pesel, telefon, email, haslo, rabat, data_dodania) VALUES (121, 55, 'Adam', 'Cichy','56121201234','123-454-321','Acichy@oo.pl;','haslo',0,'2021-04-08');

--16.2 Dodaj do bazy danych pracownika: Alojzy Mikos zatrudniony od 11 sierpnia 2010 r. pensja 3000 zł i dodatek 50 zł,pracownik zamieszkuje w Warszawie na ul. Lewartowskiego 12, kod pocztowy: 00-950. 

INSERT INTO adres VALUES (56, 'Lewartowskiego', 12, '00-950', 'Warszawa')

INSERT INTO pracownik VALUES (15, 56, 'Alojzy', 'Mikos', '2010-08-11', 3000, 50, 'sprzedawca', 'false')

......................

--17.1 Dla każdej faktury wyświetl imię i nazwisko klienta

SELECT faktura.id_faktura, klient.imie, klient.nazwisko
FROM faktura
LEFT JOIN klient ON faktura.id_klient = klient.id_klient;

--17.2 Wyszukaj klientów, którzy nie opłacili jeszcze faktury.

SELECT klient.nazwisko, klient.imie, faktura.czy_oplacona
FROM klient
LEFT JOIN faktura
ON klient.id_klient = faktura.id_klient
WHERE czy_oplacona='false';

--17.3 Znajdź te produkty, które są zamawiane w dużych ilościach, tzn w pojedynczym koszyku wartość kolumny ilosc_sztuk jest większa niż 100.

SELECT produkt.*, koszyk.ilosc_sztuk
FROM produkt
INNER JOIN koszyk ON koszyk.id_produkt = produkt.id_produkt
WHERE koszyk.ilosc_sztuk > 100;

--18 Złączenia wewnętrzne większej liczby tabel 
--18.1 Dla każdego klienta, który choć raz złożył zamówienie, wyszukaj kiedy oraz  jakie produkty zamówił. Wyświetl imię i nazwisko klienta oraz datę zamówienia,nazwę  produktów w koszyku . Wynik posortuj rosnąco po nazwisku i imieniu klienta.

SELECT klient.imie, klient.nazwisko, zamowienie.data_zamowienia, produkt.nazwa
FROM klient
INNER JOIN zamowienie ON zamowienie.id_klient = klient.id_klient
INNER JOIN koszyk ON zamowienie.id_zamowienie = koszyk.id_zamowienie
INNER JOIN produkt ON koszyk.id_produkt = produkt.id_produkt
ORDER BY imie, nazwisko ASC;

--18.2 Dla każdej kategorii  wyszukaj jakie produkty były zamawiane. Wyświetl nazwę kategorii oraz nazwę produktu.. Wyniki posortuj rosnąco względem nazwy kategorii. 

SELECT kategoria.nazwa AS "nazwa kategorii", produkt.nazwa AS "nazwa produktu"
FROM kategoria
INNER JOIN podkategoria ON podkategoria.id_kategoria = kategoria.id_kategoria
LEFT JOIN produkt ON produkt.id_podkategoria = podkategoria.id_kategoria
LEFT JOIN koszyk ON koszyk.id_produkt = produkt.id_produkt
LEFT JOIN zamowienie ON koszyk.id_zamowienie = zamowienie.id_zamowienie
ORDER by kategoria.nazwa ASC;

--18.3 Dla każdego zamówionego produktu  wyszukaj informację jacy klienci go zamawialii. Wyświetl identyfikator, nazwę  oraz imię i nazwisko klienta. Wyniki posortuj rosnąco po identyfikatorze produktu oraz nazwisku i imieniu klienta. 

SELECT produkt.id_produkt, produkt.nazwa, klient.imie, klient.nazwisko
FROM zamowienie
INNER JOIN koszyk ON koszyk.id_zamowienie = zamowienie.id_zamowienie
INNER JOIN produkt ON produkt.id_produkt = koszyk.id_produkt
INNER JOIN klient ON zamowienie.id_klient = klient.id_klient
ORDER by produkt.id_produkt, klient.nazwisko, klient.imie ASC;
...........
--19.1 Dla każdego klienta oblicz ile faktur zostało wystawionych. 
(Uwzględnij też klientów, którzy nie otrzymali żadnej faktury.) Wynik posortuj malejąco po oblicznej ilości, a dla takiej samej ilości posortuj leksykograficznie po nazwisku klienta.

SELECT klient.imie, klient.nazwisko, count(faktura.id_klient) AS 'ilosc faktur' from klient
LEFT JOIN faktura ON klient.id_klient=faktura.id_klient
GROUP BY klient.imie, klient.nazwisko
ORDER BY 'ilosc faktur' desc, klient.imie, klient.nazwisko ASC;

--19.2* Dla każdej podkategorii (tabela podkategoria kolumna nazwa), wyświetl informację ile znajduje się produktów z danej podkategorii w tabeli produkt. 

SELECT podkategoria.nazwa, sum(produkt.ilosc_sztuk_magazyn)
FROM podkategoria
INNER JOIN produkt ON podkategoria.id_podkategoria = produkt.id_podkategoria
GROUP BY podkategoria.nazwa;

--19.3* Dla każdej podkategorii (tabela podkategoria kolumna nazwa), wyświetl informację ile znajduje się produktów z danej podkategorii w tabeli produkt.  Uwzględnij też podkategorie, które nie posiadają  żadnego produktu  w tabeli produkt. Wynik posortuj malejąco po obliczonej ilości, a dla takiej samej  ilości posortuj leksykograficznie po nazwie podkategorii.

SELECT podkategoria.nazwa, sum(produkt.ilosc_sztuk_magazyn)
FROM podkategoria
LEFT JOIN produkt ON podkategoria.id_podkategoria = produkt.id_podkategoria
GROUP by podkategoria.nazwa
ORDER BY podkategoria.nazwa;

--20.1 Znaleźć największą pensję pracownika.

SELECT MAX(pensja)
FROM pracownik;

--20.2 Znaleźć średnią rabat klienta wypożyczalni. 

SELECT AVG(rabat)
FROM klient;

--20.3 Znaleźć najwcześniejszą datę wystawienia faktury.

SELECT MIN(data_wystawienia)
FROM faktura;

--Zadanie 2 (powtórzeniowe)
--1) Znajdź klientów którzy zostali dodani pomiędzy 1.01 2010 a 31.12.2012 Wynik posortuj leksykograficznie po nazwisku i imieniu.

SELECT * From klient WHERE data_dodania BETWEEN '2010-01-01' AND '2012-12-31';

--2) W każdym koszyku (tabela koszyk) zmniejsz cenê netto produktu o 4% o ile jest zamówionych wiêcej niż 4 sztuk tego produktu (tabela koszyk kolumna ilosc_sztuk).

UPDATE koszyk SET cena_netto = cena_netto - cena_netto * 0.04 WHERE ilosc_sztuk > 4;

--3) Wyświetl statusy zamówień, które zostały przyjęte przez zamówienia  (zobacz tabela zamówienie_status). (Unikaj powtórzeń)

SELECT DISTINCT * From zamowienie_status;

--4) Usuń statusy zamówień (tabela status), które ani razu nie zostały przyjęte przez zamówienie (zobacz tabela zamówienie_status).

DELETE status FROM status
FULL JOIN zamowienie_status ON zamowienie_status.id_status = status.id_status
WHERE zamowienie_status.id_zamowienie IS NULL;
--------------------

-- 21.1 Dla każdego klienta wypisz imię, nazwisko i łączną ilość złożonych zamówień (nie zapomnij o zerowej liczbie zamówień). Wynik posortuj malejąco względem ilości zamówień

SELECT klient.imie, klient.nazwisko, COUNT(zamowienie.id_klient) as 'ilosc zamowien' from klient
LEFT JOIN zamowienie ON klient.id_klient=zamowienie.id_klient
GROUP BY klient.imie, klient.nazwisko
ORDER BY 'ilosc zamowien' DESC 

--21.2 Dla każdego produktu (identyfikator, nazwa) oblicz ilość zamówień (wystąpienia w tabeli koszyk). Wynik posortuj rosnąco względem ilości zamówień. (Nie zapomnij o produktachh, które ani razu nie zostały zamówione).

SELECT produkt.id_produkt, produkt.nazwa, COUNT(koszyk.id_produkt) as 'ilosc zamowien' from produkt
LEFT JOIN koszyk ON produkt.id_produkt=koszyk.id_produkt
GROUP BY produkt.id_produkt, produkt.nazwa
ORDER BY 'ilosc zamowien' ASC;

--21.3 Znajdź klientów, którzy co najmniej 2 razy złożyli zamówienie. Wypisz dla tych klientów imię, nazwisko i ilość zamówień. Wynik posortuj względem imienia i nazwiska.

SELECT klient.imie, klient.nazwisko, COUNT(zamowienie.id_klient) as 'ilosc zamowien' from klient
LEFT JOIN zamowienie ON klient.id_klient=zamowienie.id_klient
GROUP BY klient.imie, klient.nazwisko
HAVING COUNT(zamowienie.id_klient) > 2
ORDER BY klient.imie, klient.nazwisko DESC

--21.4 Znajdź produkty, które pojawiły się w co najmniej 3 zamówieniach. Wyświetl ich nazwę i ilość zamówień w których się pojawiły.

SELECT produkt.nazwa, COUNT(koszyk.id_produkt) as 'ilosc zamowien' from produkt
LEFT JOIN koszyk ON produkt.id_produkt=koszyk.id_produkt
GROUP BY produkt.id_produkt, produkt.nazwa
HAVING COUNT(koszyk.id_produkt) > 3;

--21.5 Znajdź pracowników, którzy obsługiwali co najwyżej 5 zamówień. Wyświetl ich imiona, nazwiska oraz łączną ilość zamówień.

SELECT pracownik.imie, pracownik.nazwisko, COUNT(zamowienie.id_pracownik) as 'ilosc zamowien' from pracownik
LEFT JOIN zamowienie ON pracownik.id_pracownik=zamowienie.id_pracownik
GROUP BY pracownik.imie, pracownik.nazwisko
HAVING COUNT(zamowienie.id_pracownik) < 5;

--22.1 Wyświetl imiona, nazwiska i pensje pracowników, którzy posiadają najwyższą pensję. 

SELECT imie, nazwisko, pensja FROM pracownik
WHERE pensja = (SELECT MAX(pensja) FROM pracownik);

--22.2 Wyświetl pracowników (imiona, nazwiska, pensje), którzy zarabiają powyżej średniej pensji.

SELECT imie, nazwisko, pensja FROM pracownik
WHERE pensja > (SELECT AVG(pensja) FROM pracownik); 

--23 Podzapytania nieskorelowane z predykatem IN 
--23.1 Wyświetl wszystkie produkty (nazwa), które do tej pory nie zostały zamówione. 

SELECT produkt.nazwa FROM produkt
LEFT JOIN koszyk ON produkt.id_produkt=koszyk.id_produkt
GROUP BY produkt.id_produkt, produkt.nazwa
HAVING COUNT(koszyk.id_produkt) = 0;

--23.2 Wyświetl klientów (imię i nazwisko), którzy do tej pory nie zamówili  żadnego produktu. Wynik posortuj rosnąco względem nazwiska i imienia klienta. 

SELECT klient.imie, klient.nazwisko FROM klient
LEFT JOIN zamowienie ON klient.id_klient=zamowienie.id_klient
GROUP BY klient.imie, klient.nazwisko
HAVING COUNT(zamowienie.id_klient) = 0;

-----------------------
--24.1 Znajdź klienta/klientów(id_klient, imię, nazwisko) którzy najrzadziej zamawiają produkty. Wynik posortuj rosnąco względem nazwiska i imienia. Nie uwzględniaj klientów, którzy ani razu nie zamówili produktu.

SELECT klient.imie, klient.id_klient, klient.nazwisko, from klient 
JOIN zamowienie on klient.id_klient = zamowienie.id_klient
group by klient.imie, klient.id_klient, klient.nazwisko 
having count(zamowienie.id_klient)=(SELECT top 1 COUNT(id_klient) AS 'liczba' FROM zamowienie GROUP BY id_klient order by liczba asc)

--24.2 Znajdź pracownika/pracowników, który przyjął najwięcej zamówień.  Wynik posortuj rosnąco względem nazwiska i imienia. 

SELECT pracownik.id_pracownik, pracownik.imie, pracownik.nazwisko from pracownik
JOIN zamowienie on pracownik.id_pracownik = zamowienie.id_pracownik
group by pracownik.id_pracownik, pracownik.imie, pracownik.nazwisko
HAVING count(zamowienie.id_pracownik)=(SELECT top 1 COUNT(id_pracownik) AS 'liczba' FROM zamowienie GROUP BY id_pracownik order by liczba DESC)
ORDER BY pracownik.nazwisko, pracownik.imie ASC;

--24.3 Znajdź produkt najczęściej zamawiany.

SELECT produkt.id_produkt, produkt.nazwa, COUNT(koszyk.id_produkt) as 'ilosc zamowien' from produkt
JOIN koszyk ON produkt.id_produkt=koszyk.id_produkt
GROUP BY produkt.id_produkt, produkt.nazwa
having count(koszyk.id_produkt)=(SELECT top 1 COUNT(id_produkt) AS 'liczba' FROM koszyk GROUP BY id_produkt order by liczba DESC)
ORDER BY 'ilosc zamowien' DESC;

--25.1 Podwyż o 10 % pensję pracownikom, którzy zarabiają poniżej średniej.

UPDATE pracownik SET pensja = pensja + pensja * 0.1
WHERE pensja < (SELECT AVG(pensja) FROM pracownik);

--25.2 Pracownikom, którzy w październiku przyjęli najwięcej zamówień zwiększ dodatek o 100zł

UPDATE pracownik
SET dodatek = COALESCE(dodatek, 0) + 100
WHERE id_pracownik IN (SELECT pracownik.id_pracownik
FROM pracownik JOIN zamowienie ON pracownik.id_pracownik = zamowienie.id_pracownik
WHERE MONTH(data_zamowienia) = 10 
GROUP BY pracownik.id_pracownik
having COUNT(zamowienie.id_pracownik) = (SELECT TOP 1 COUNT(id_pracownik) AS 'liczba' FROM zamowienie WHERE MONTH(data_zamowienia) = 10 GROUP BY id_pracownik ORDER BY liczba DESC));

--26.1 Usuń klientów, którzy nie złożyli żadnego zamówienia.

DELETE FROM klient
WHERE id_klient NOT IN (SELECT klient.id_klient FROM klient JOIN zamowienie ON klient.id_klient = zamowienie.id_klient GROUP BY klient.id_klient);

--26.2 Usuń pracowników, którzy nie przyjęli żadnego zamówienia

DELETE FROM pracownik
WHERE id_pracownik NOT IN (SELECT pracownik.id_pracownik FROM pracownik JOIN zamowienie ON pracownik.id_pracownik = zamowienie.id_pracownik GROUP BY pracownik.id_pracownik);

--27 UNION, UNION ALL, INTERSECT, EXCEPT
--27.1 Wyświetl razem wszystkie imiona i nazwiska pracowników i klientów (suma dwóch zbiorów). Wynik posortuj względem nazwiska i imienia. Rozpatrz dwa przypadki:
--1. Z pominięciem duplikatów

SELECT imie, nazwisko FROM pracownik
UNION
SELECT imie, nazwisko FROM klient
ORDER BY nazwisko, imie;

--2. z wyświetleniem duplikatów

SELECT imie, nazwisko FROM pracownik
UNION ALL
SELECT imie, nazwisko FROM klient
ORDER BY nazwisko, imie;

--27.2 Wyświetl powtarzające się imiona i nazwiska klientów i pracowników (Część wspólna dwóch zbiorów)

SELECT imie, nazwisko
FROM pracownik
INTERSCT
SELECT imie, nazwisko  
FROM klient;

--27.3 Wyświetl imiona i nazwiska pracowników, którzy nazywają się inaczej niż klienci. Wynik posortuj względem nazwiska i imienia. (Różnica dwóch zbiorów)


SELECT imie, nazwisko
FROM pracownik
EXCEPT
SELECT imie, nazwisko  
FROM klient;

----------------------------------------
--Tworzenie tabel

CREATE TABLE pojazd (
  id_pojazd INTEGER NOT NULL PRIMARY KEY,
  marka VARCHAR(12),
  typ VARCHAR(12),
  data_produkcji DATE,
  stan VARCHAR(200)
);

CREATE TABLE klient (
  id_klient INTEGER NOT NULL PRIMARY KEY,
  imie VARCHAR(12),
  nazwisko VARCHAR(12),
  telefon VARCHAR(9),
  data_ur DATE
);

CREATE TABLE wypozyczenie (
  id_klient INTEGER REFERENCES klient(id_klient),
  id_pojazd INTEGER REFERENCES pojazd(id_pojazd),
  data_wyp DATETIME,
  data_zwrotu DATE
);

---
INSERT INTO pojazd(id_pojazd,marka,typ,data_produkcji,stan) VALUES (1,'Toyota','Sedan','2003-03-03','Dobry');
INSERT INTO pojazd(id_pojazd,marka,typ,data_produkcji,stan) VALUES (2,'Renault','Limuzyna','1830-09-09','Średni');
INSERT INTO pojazd(id_pojazd,marka,typ,data_produkcji,stan) VALUES (3,'Mercedes','Ciężarówka','2000-01-01','Może być');

INSERT INTO klient(id_klient,imie,nazwisko,telefon,data_ur) VALUES (1,'Anna','Nowak','123456789','1990-09-09');
INSERT INTO klient(id_klient,imie,nazwisko,telefon,data_ur) VALUES (2,'Andrzej','Kowalski','987654321','1987-02-19');
INSERT INTO klient(id_klient,imie,nazwisko,telefon,data_ur) VALUES (3,'Kazimierz','Pracz','912837465','1980-12-25');

INSERT INTO wypozyczenie(id_klient,id_pojazd,data_wyp,data_zwrotu) VALUES (1,1,'2018-12-30','2019-02-01');
INSERT INTO wypozyczenie(id_klient,id_pojazd,data_wyp,data_zwrotu) VALUES (1,2,'2019-05-13','2019-06-20');
INSERT INTO wypozyczenie(id_klient,id_pojazd,data_wyp,data_zwrotu) VALUES (2,1,'2019-06-10','2019-08-02');
INSERT INTO wypozyczenie(id_klient,id_pojazd,data_wyp,data_zwrotu) VALUES (2,3,'2020-01-11','2020-02-11');
INSERT INTO wypozyczenie(id_klient,id_pojazd,data_wyp,data_zwrotu) VALUES (3,3,'2020-03-04','2021-02-20');

----
--Zad 2

CREATE TABLE student2(
  id_student INT IDENTITY(1,1) PRIMARY KEY,
  imie VARCHAR(20) NOT NULL,
  nazwisko VARCHAR(20) NOT NULL,
  nr_indeksu INT UNIQUE,
  stypendium MONEY CHECK (stypendium>1500)
);

....???
INSERT INTO student2(id_student,imie,nazwisko,nr_indeksu,stypendium) VALUES (1,'Agnieszka','Nowak',12345,1550);
INSERT INTO student2(id_student,imie,nazwisko,nr_indeksu,stypendium) VALUES (2,'Adam','Kowalski',12346,1600.00);
INSERT INTO student2(id_student,imie,nazwisko,nr_indeksu,stypendium) VALUES (3,'Agata','Nowicka',12347,1600.00);
INSERT INTO student2(id_student,imie,nazwisko,nr_indeksu,stypendium) VALUES (4,'Andrzej','Kowalczyk',12348,2050.00);

----
DROP TABLE klient,pojazd,wypozyczenie,student2;



----------------------------------------
--32 Tworzenie procedur składowych (CREATE PROCEDURE)

--32.1 Napisać procedurę o nazwie wypisz_produkty, która posiada tylko jeden parametr - nazwa produktu.

--Procedura powinna wyświetlać wszystkie informacje z tabeli produkt na temat szukanego produktu.

CREATE PROCEDURE wypisz_produkty
AS
SELECT * FROM produkt
GO;

EXEC wypisz_produkty;

--32.2 Napisać procedurę o nazwie zwieksz_pensje posiadającą dwa parametry: identyfikator pracownika i kwotę.
--Procedura powinna zwiększyć pensję pracownikowi, na którego wskazuje zadany identyfikator o zadaną kwotę.
--Przetestuj utworzoną procedurę – zwiększ pracownikowi o identyfikatorze równym 1 pensję o 1000 zł.


CREATE PROCEDURE zwieksz_pensje @id_pracownik INT, @pensja decimal
AS
UPDATE pracownik SET pensja = pensja + @pensja WHERE id_pracownik = @id_pracownik;

EXEC zwieksz_pensje @id_pracownik= 1 , @pensja = 1000 


--32.3 Napisz procedurę o nazwie dodaj_adres umożliwiającą dodanie nowego adresu. Szczegóły adresu powinny być odczytane z parametrów procedury. Dobierz odpowiednio parametry dla tworzonej procedury na podstawie kolumn tabeli adres. Przetestuj utworzoną procedurę – dodaj nowy adres.


CREATE PROCEDURE dodaj_adres @id_adres INT, @ulica varchar(50), @numer VARCHAR(10), @kod char(11), @miejscowosc VARCHAR(30)
AS
INSERT INTO adres (id_adres,ulica,numer,kod,miejscowosc) VALUES (@id_adres,@ulica,@numer,@kod,@miejscowosc);

EXEC dodaj_adres @id_adres=55, @ulica='Bażyńskigo', @numer=1, @kod='80-300', @miejscowosc='Gdańsk';

--33 Tworzenie funkcji składowych (CREATE FUNCTION)

--33.1 Napisać funkcję o nazwie aktywnosc_klienta, która będzie zwracać ilość zamówień dla klienta o identyfikatorze zadanym jako parametr funkcji. Przetestuj utworzoną funkcję – sprawdź ile zamówień złożył klient o identyfikatorze równym 3.


--33.2 Napisać funkcję o nazwie ile_zamówień posiadającą dwa parametry data_od i data_do. Funkcja powinna zwrócić ilość zamówień złożonych w zadanym przedziale czasowym. Przetestuj utworzoną funkcję .

--33.3 Napisać funkcję o nazwie roznica_pensji nie posiadającą parametrów i zwracającą różnicę pomiędzy największą i najmniejszą pensją wśród pracowników sklepu. Przetestuj utworzoną funkcję.

--33.1
create function aktywnosc_klienta (@id_klient int)
returns INT
BEGIN
return (select count(*) from zamowienie where id_klient=@id_klient)
end
select dbo.aktywnosc_klienta (3) as ilosc

--33.2
create function ile_zamowien (@data_od date, @data_do date)
returns int
BEGIN
return (select count(*) from zamowienie where data_zamowienia between @data_od and @data_do)
end
select dbo.ile_zamowien ('2001-01-01', '2010-01-01') as ilosc

