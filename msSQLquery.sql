CREATE DATABASE test

CREATE SCHEMA project;
	
	---------creating tables first--------------
	
	CREATE TABLE project.GeoEon
	(id_eon INT IDENTITY(1,1) CONSTRAINT pk_eon PRIMARY KEY NOT NULL,
	 nazwa_eon VARCHAR(10)
	);
	 
	 --DROP TABLE project.GeoEon
	 
	CREATE TABLE project.GeoEra
	(id_era INT IDENTITY(1,1) CONSTRAINT pk_era PRIMARY KEY NOT NULL,
	 nazwa_era VARCHAR(15),
	 id_eon INT DEFAULT 1,
	 FOREIGN KEY(id_eon) REFERENCES project.GeoEon(id_eon)
	);
	
	--DROP TABLE project.GeoEra
	
	CREATE TABLE project.GeoOkres
	(id_okres INT IDENTITY(1,1) CONSTRAINT pk_okres PRIMARY KEY NOT NULL,
	 nazwa_okres VARCHAR(25),
	 id_era INT,
	 FOREIGN KEY(id_era) REFERENCES project.GeoEra(id_era)
	);
	
	--DROP TABLE project.GeoOkres
	
	CREATE TABLE project.GeoEpoka
	(id_epoka INT IDENTITY(1,1) CONSTRAINT pk_epoka PRIMARY KEY NOT NULL,
	 nazwa_epoka VARCHAR(10),
	 id_okres INT,
	 FOREIGN KEY(id_okres) REFERENCES project.GeoOkres(id_okres)
	);
	
	--DROP TABLE project.GeoEpoka
	
	CREATE TABLE project.GeoPietro
	(id_pietro INT IDENTITY(1,1) CONSTRAINT pk_pietro PRIMARY KEY NOT NULL,
	 nazwa_pietro VARCHAR(15),
	 id_epoka INT,
	 FOREIGN KEY(id_epoka) REFERENCES project.GeoEpoka(id_epoka)
	);
	
	--DROP TABLE project.GeoPietro


	-------then i fill up the tables----------
	
	INSERT INTO project.GeoEon (nazwa_eon) VALUES ('Fanerozoik')
	
	--SELECT * FROM project.GeoEon
	
	INSERT INTO project.GeoEra (nazwa_era) VALUES ('Kenozoik'), ('Mezozoik'), ('Paleozoik')
	
	--SELECT * FROM project.GeoEra
	
	INSERT INTO project.GeoOkres (nazwa_okres, id_era) VALUES
	('Czwartorzêd', 1), ('Neogen', 1), ('Paleogen', 1),
	('Kreda', 2), ('Jura', 2), ('Trias', 2),
	('Perm', 3), ('Karbon', 3), ('Dewon', 3)
	
	--SELECT * FROM project.GeoOkres
	
	INSERT INTO project.GeoEpoka (nazwa_epoka, id_okres) VALUES
	('Holocen', 1), ('Plejstocen', 1),
	('Pliocen', 2), ('Miocen', 2),
	('Oligocen', 3), ('Eocen', 3), ('Paleocen', 3),
	('Górna', 4), ('Dolna', 4),
	('Górna', 5), ('Œrodkowa', 5), ('Dolna', 5),
	('Górna', 6), ('Œrodkowa', 6), ('Dolna', 6),
	('Górny', 7), ('Dolny', 7),
	('Górny', 8), ('Dolny', 8),
	('Górny', 9), ('Œrodkowy', 9), ('Dolny', 9)
	
	--SELECT * FROM project.GeoEpoka
	
	INSERT INTO project.GeoPietro (nazwa_pietro, id_epoka) VALUES 
	('megalaj', 1), ('northgrip', 1), ('grenland', 1),
	('póŸny', 2), ('chiban', 2), ('kalabr', 2), ('gelas', 2),
	('piacent', 3),('zankl', 3),
	('messyn', 4), ('torton', 4), ('serrawal', 4), ('lang', 4), ('burdyga³', 4), ('akwitan', 4),
	('szat', 5), ('rupel', 5),
	('priabon', 6), ('barton', 6), ('lutet', 6), ('iprez', 6),
	('tanet', 7), ('zeland', 7), ('dan', 7),
	('mastrycht', 8), ('kampan', 8), ('santon', 8), ('koniak', 8), ('turon', 8), ('cenoman', 8),
	('alb', 9), ('apt', 9), ('barrem', 9), ('hoteryw', 9), ('walan¿yn', 9), ('berrias', 9),
	('tyton', 10), ('kimeryd', 10), ('oksford', 10),
	('kelowej', 11), ('baton', 11), ('bajos', 11), ('aalen', 11),
	('toark', 12), ('pliensbach', 12), ('synemur', 12), ('hettang', 12),
	('retyk', 13), ('noryk', 13), ('karnik', 13),
	('ladyn', 14), ('anizyk', 14),
	('olenek', 15), ('ind', 15),
	('czangsing', 16), ('wucziaping', 16), ('kapitan', 16), ('word', 16), ('road', 16),
	('kungur', 17), ('artinsk', 17), ('sakmar', 17), ('assel', 17),
	('g¿el', 18), ('kasimow', 18), ('moskow', 18), ('baszkir', 18),
	('serpuchow', 19), ('wizen', 19), ('turnej', 19),
	('famen', 20), ('fran', 20),
	('¿ywet', 21), ('eifel', 21),
	('ems', 22), ('prag', 22), ('lochkow', 22)
	
	--SELECT * FROM project.GeoPietro

	
	-------next stage will be creating denormalized table----------
	
	CREATE TABLE project.GeoTabela 
	AS (SELECT * FROM project.GeoPietro 
	INNER JOIN project.GeoEpoka ON GeoPietro.id_epoka = GeoEpoka.id_epoka 
	INNER JOIN project.GeoOkres ON GeoOkres.id_okres = GeoEpoka.id_okres
	INNER JOIN project.GeoEra ON GeoOkres.id_era = GeoEra.id_era
	INNER JOIN project.GeoEon ON GeoEra.id_eon = GeoEon.id_eon
	);
	

	SELECT nazwa_eon, nazwa_era, nazwa_okres, nazwa_epoka, nazwa_pietro, id_pietro, GeoEpoka.id_epoka INTO project.GeoTabela
	FROM project.GeoPietro
	INNER JOIN project.GeoEpoka ON GeoPietro.id_epoka = GeoEpoka.id_epoka
	INNER JOIN project.GeoOkres ON GeoEpoka.id_okres = GeoOkres.id_okres
	INNER JOIN project.GeoEra ON GeoOkres.id_era = GeoEra.id_era
	INNER JOIN project.GeoEon ON GeoEra.id_eon = GeoEon.id_eon;

	--TRUNCATE project.GeoTabela
	--DROP TABLE project.GeoTabela
	--SELECT * FROM project.GeoTabela  ORDER BY id_pietro
	
	---------------#-----performance tests------#--------------------
	
	-------------------creating milion table-------------------------
	
	CREATE SCHEMA dziesiec
	
	CREATE TABLE dziesiec.a1
	(cyfra NUMERIC(2),
	 bit INT DEFAULT 1);
	CREATE TABLE dziesiec.a2
	(cyfra NUMERIC(2),
	 bit INT DEFAULT 1);
	CREATE TABLE dziesiec.a3
	(cyfra NUMERIC(2),
	 bit INT DEFAULT 1);
	CREATE TABLE dziesiec.a4
	(cyfra NUMERIC(2),
	 bit INT DEFAULT 1);
	CREATE TABLE dziesiec.a5
	(cyfra NUMERIC(2),
	 bit INT DEFAULT 1);
	CREATE TABLE dziesiec.a6
	(cyfra NUMERIC(2),
	 bit INT DEFAULT 1);
	 
	
	INSERT INTO dziesiec.a6 (cyfra) VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
	
	
	--TRUNCATE dziesiec.a6;
	--DROP TABLE dziesiec.a6
	--SELECT * FROM dziesiec.a1
	
	
	CREATE TABLE Milion(liczba int,cyfra int, bit int);
	INSERT INTO  Milion 
	SELECT a1.cyfra +10* a2.cyfra +100*a3.cyfra + 1000*a4.cyfra + 10000*a5.cyfra + 100000*a6.cyfra 
	AS liczba , a1.cyfra AS cyfra, a1.bit AS bit 
	FROM dziesiec.a1, dziesiec.a2, dziesiec.a3, dziesiec.a4, dziesiec.a5, dziesiec.a6 ;
	
	
	--SELECT * FROM Milion ORDER BY liczba DESC
	--TRUNCATE Milion;
	--DROP TABLE Milion

	-----------------1 zapytanie--------------------

	SELECT COUNT(*) FROM Milion 
	INNER JOIN project.GeoTabela ON Milion.liczba%68 = GeoTabela.id_pietro;

	set statistics time on 
	SELECT COUNT(*) FROM Milion 
	INNER JOIN project.GeoTabela ON Milion.liczba%68 = GeoTabela.id_pietro;
	set statistics time off


	-----------------2 zapytanie---------------------


	SELECT COUNT(*) FROM Milion 
	INNER JOIN project.GeoPietro ON Milion.liczba%68=GeoPietro.id_pietro
	inner join project.GeoEpoka ON GeoPietro.id_epoka =GeoEpoka.id_epoka
	inner join project.GeoOkres ON GeoEpoka.id_okres = GeoOkres.id_okres
	inner join project.GeoEra ON GeoEra.id_era = GeoOkres.id_era
	inner join project.GeoEon ON GeoEon.id_eon = GeoEra.id_eon;

	set statistics time on 
	SELECT COUNT(*) FROM Milion 
	INNER JOIN project.GeoPietro ON Milion.liczba%68=GeoPietro.id_pietro
	inner join project.GeoEpoka ON GeoPietro.id_epoka =GeoEpoka.id_epoka
	inner join project.GeoOkres ON GeoEpoka.id_okres = GeoOkres.id_okres
	inner join project.GeoEra ON GeoEra.id_era = GeoOkres.id_era
	inner join project.GeoEon ON GeoEon.id_eon = GeoEra.id_eon;
	set statistics time off


	-----------------3 zapytanie---------------------

	SELECT COUNT(*) 
	FROM Milion WHERE Milion.liczba%68 = (SELECT id_pietro FROM project.GeoTabela WHERE Milion.liczba%68=id_pietro);

	set statistics time on 
	SELECT COUNT(*) 
	FROM Milion WHERE Milion.liczba%68 = (SELECT id_pietro FROM project.GeoTabela WHERE Milion.liczba%68=id_pietro);
	set statistics time off

	-----------------4 zapytanie---------------------

	SELECT COUNT(*) FROM Milion WHERE Milion.liczba%68 IN
	(SELECT id_pietro FROM project.GeoPietro 
	INNER JOIN project.GeoEpoka ON GeoPietro.id_epoka = GeoEpoka.id_epoka 
	INNER JOIN project.GeoOkres ON GeoEpoka.id_okres = GeoOkres.id_okres
	INNER JOIN project.GeoEra ON GeoEra.id_era = GeoOkres.id_era
	INNER JOIN project.GeoEon ON GeoEon.id_eon = GeoEra.id_eon);

	set statistics time on 
	SELECT COUNT(*) FROM Milion WHERE Milion.liczba%68 IN
	(SELECT id_pietro FROM project.GeoPietro 
	INNER JOIN project.GeoEpoka ON GeoPietro.id_epoka = GeoEpoka.id_epoka 
	INNER JOIN project.GeoOkres ON GeoEpoka.id_okres = GeoOkres.id_okres
	INNER JOIN project.GeoEra ON GeoEra.id_era = GeoOkres.id_era
	INNER JOIN project.GeoEon ON GeoEon.id_eon = GeoEra.id_eon);
	set statistics time off

	-----------------indexy---------------------------------

	CREATE INDEX ix_eon ON project.GeoEon(id_eon);
	CREATE INDEX ix_era ON project.GeoEra(id_era, id_eon);
	CREATE INDEX ix_okres ON project.GeoOkres(id_okres, id_era);
	CREATE INDEX ix_epoka ON project.GeoEpoka(id_epoka, id_okres);
	CREATE INDEX ix_pietro ON project.GeoPietro(id_pietro, id_epoka);
	CREATE INDEX ix_tabela ON project.GeoTabela(id_pietro, id_epoka);











