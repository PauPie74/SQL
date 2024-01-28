CREATE TABLE gosc (
  id_gosc INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nazwisko VARCHAR(20) NOT NULL,
  imie VARCHAR(20) NOT NULL,
  pesel CHAR(11),
  nr_telefonu NUMERIC(8),
  UNIQUE (pesel)

);

CREATE TABLE pokoj (
  id_pokoj INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
  typ VARCHAR(12) NOT NULL,
  cena MONEY CHECK (cena > 0)
  UNIQUE (typ)
);

CREATE TABLE rezerwacja (
  id_rezerwacja INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
  id_gosc INTEGER NOT NULL REFERENCES gosc(id_gosc),
  id_pokoj INTEGER NOT NULL REFERENCES pokoj(id_pokoj)
  data_pocz DATE NOT NULL,
  data_konc DATE CHECK (data_konc > data_pocz)
);

INSERT INTO gosc(nazwisko,imie,pesel,nr_telefonu) VALUES ('Kowalska','Maria','9012120929','12345678');
INSERT INTO gosc(nazwisko,imie,pesel,nr_telefonu) VALUES ('Kowalczyk','Maciej','9502020111','12345679');

INSERT INTO pokoj(typ,cena) VALUES ('dwuosobowy',120);
INSERT INTO pokoj(typ,cena) VALUES ('jednoosobowy',70);

INSERT INTO rezerwacja(id_gosc,id_pokoj,data_pocz,data_kon) VALUES (1,1,'2020-02-01','2020-02-14')
INSERT INTO rezerwacja(id_gosc,id_pokoj,data_pocz,data_kon) VALUES (2,1,'2020-03-10','2020-03-15')