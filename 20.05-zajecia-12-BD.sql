UTWORZ TABELE:
1. pojazd
CREATE TABLE pojazd(
id_pojazd INT PRIMARY KEY not null identity(1,1),
marka VARCHAR(12) not null,
typ VARCHAR(12) not null,
data_produkcji date,
stan VARCHAR(200))

2.klient
CREATE TABLE klient(
id_klient INT PRIMARY KEY not null identity(1,1),
imie varchar(12) not null,
nazwisko VARCHAR(12) not null,
telefon VARCHAR(9) not null check(len(telefon)=9 and telefon like('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')),
data_ur date)                                  

3. wypozyczenie
CREATE TABLE wypozyczenie(
id_klient INT FOREIGN KEY references klient(id_klient),
id_pojazd INT FOREIGN KEY references pojazd(id_pojazd),
data_wyp date default GETDATE(), #wyciaganie daty z systemu
data_zwrotu date)


rekordy do tabel
INSERT INTO klient (imie, nazwisko, telefon, data_ur)
VALUES('Tomek', 'Nowak', 123456789, '1979-09-23')
INSERT INTO klient (imie, nazwisko, telefon, data_ur)
VALUES('Jan', 'Nowacki', 122346871, '1981-10-13')
INSERT INTO pojazd (marka, typ, data_produkcji, stan)
VALUES('Renault', 'dwuosobowy', '2000-12-01', 'brak uszkodzeń, zarysowane lewe drzwi')
INSERT INTO pojazd (marka, typ, data_produkcji, stan)
VALUES('Fiat', '126p', '1978-01-31', 'mustang nie samochód')
Insert into wypozyczenie (id_klient, id_pojazd, data_zwrotu)
VALUES(1, 2, '2021-08-12')
Insert into wypozyczenie (id_klient, id_pojazd, data_zwrotu)
VALUES(2, 1, '2021-07-31')


DANA JEST TABELA:


CREATE TABLE student2(
id_student INT PRIMARY KEY not null identity(1,1),
imie VARCHAR(20) not null,
nazwisko VARCHAR(20) not null,
nr_indeksu INT UNIQUE,
stypendium MONEY check((stypendium)>1300));

INSERT INTO student2(imie, nazwisko, nr_indeksu, stypendium)
VALUES('Tomek', 'Nowak', '234567', '1450')

sprawdzenie:
INSERT INTO student2(imie, nazwisko, nr_indeksu, stypendium)
VALUES('Tomek', 'Nowak', '234567', '1400') #nie przechodzi z powodu non unique nr_indeksu 
INSERT INTO student2(imie, nazwisko, nr_indeksu, stypendium)
VALUES('Tomek', 'Nowak', '211117', '1200') #nie przechodzi bo za mało pieniędzy w stypendium


DROP TABLE wypozyczenie, klient, pojazd, student2;



ZAJECIA 12 cz. 2:
32.1 
CREATE PROCEDURE wypisz_produkty @nazwa_produktu nvarchar(30)
AS
SELECT * from produkt WHERE nazwa = @nazwa_produktu;
-- sprawdzenie
EXEC wypisz_produkty @nazwa_produktu = 'Link Menthol';

32.2
CREATE PROCEDURE zwieksz_pensje @id_pracownik INT, @kwota INT
AS
UPDATE pracownik SET pensja = pensja + @kwota 
WHERE id_pracownik = @id_pracownik;

--sprawdzenie
EXEC zwieksz_pensje @id_pracownik = 1, @kwota = 1000

32.3
CREATE PROCEDURE dodaj_adres @ulica NVARCHAR(30), @numer NVARCHAR(10), @kod NVARCHAR(6), @miejscowosc NVARCHAR (30) 
AS
INSERT INTO adres (ulica, numer, kod, miejscowosc)
VALUES (@ulica, @numer, @kod, @miejscowosc)

--sprawdzenie nie działa bo tabele nie mają autoinkrementacji
EXEC dodaj_adres @ulica = 'Wejherowska', @numer = '123', @kod = '12-134', @miejscowosc = 'Sopot'




--z uwzglednieniem id_adres

CREATE PROCEDURE dodaj_adres @numer_id INT, @ulica NVARCHAR(30), @numer NVARCHAR(10), @kod NVARCHAR(6), @miejscowosc NVARCHAR (30) 
AS
INSERT INTO adres (id_adres, ulica, numer, kod, miejscowosc)
VALUES (@numer_id, @ulica, @numer, @kod, @miejscowosc);

EXEC dodaj_adres @numer_id = 100, @ulica = 'Wejherowska', @numer = '123', @kod = '12-134', @miejscowosc = 'Sopot';


33.1 
CREATE FUNCTION aktywnosc_klienta (@id_klient INT)
RETURNS TABLE
AS
RETURN
(SELECT SUM(id_zamowienie)  AS 'suma zamowien' FROM zamowienie
WHERE id_klient = @id_klient);
--sprawdzenie
SELECT * from aktywnosc_klienta (3)

33.2
CREATE FUNCTION ile_zamowien (@data_od DATE, @data_do DATE)
RETURNS TABLE
AS
RETURN
(SELECT SUM(id_zamowienie)  AS 'suma zamowien' FROM zamowienie
WHERE data_zamowienia BETWEEN @data_od AND @data_do);
--sprawdzenie
SELECT * from ile_zamowien ('2013-01-01', '2013-12-31')

33.3
CREATE FUNCTION roznica_pensji()
RETURNS TABLE
AS
RETURN
SELECT (MAX(pensja)-MIN(pensja)) AS 'roznica' FROM pracownik;
--sprawdzenie
SELECT * from roznica_pensji()

34.1
CREATE VIEW klient_raport AS
SELECT klient.id_klient, klient.imie, klient.nazwisko, SUM(zamowienie.id_zamowienie) as 'ilosc_zamowien' FROM klient FULL JOIN zamowienie ON
klient.id_klient = zamowienie.id_klient
GROUP BY klient.id_klient, klient.imie, klient.nazwisko
--sprawdzenie
SELECT * FROM klient_raport

--sprawdz klientow ktorzy zamowili >1
SELECT * FROM klient_raport
WHERE ilosc_zamowien > 1

34.2
CREATE VIEW produkt_raport AS
SELECT produkt.id_produkt, produkt.nazwa, SUM(koszyk.ilosc_sztuk) AS 'ilosc_zamowionych' FROM produkt FULL JOIN koszyk ON produkt.id_produkt = koszyk.id_produkt
GROUP BY produkt.id_produkt, produkt.nazwa

--sprawdz co bylo najczesciej zamawiane
SELECT * FROM produkt_raport
ORDER BY 'ilosc_zamowionych' DESC
--lub tylko najczesciej zamowiony produkt
SELECT * FROM produkt_raport
WHERE ilosc_zamowionych = (SELECT MAX(ilosc_zamowionych) FROM produkt_raport)

34.3
CREATE VIEW pracownik_raport AS
SELECT pracownik.id_pracownik, imie, nazwisko, SUM(pracownik.id_pracownik) AS 'ilosc_zamowien' FROM pracownik FULL JOIN zamowienie on zamowienie.id_pracownik = pracownik.id_pracownik
GROUP BY pracownik.id_pracownik, imie, nazwisko

--sprawdzenie
SELECT * from pracownik_raport

--zamowienia powyzej sredniej
SELECT * from pracownik_raport
WHERE ilosc_zamowien > (SELECT AVG(ilosc_zamowien) FROM pracownik_raport)