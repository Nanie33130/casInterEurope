/* Présentation :
	nomScript: intereurope_base.sql
	nomBase: InterEuropeBDD
	Auteur: Mélanie Lebeau
	Date de création : 22/02/2018
*/

/***************************************/
/*Suppression des tables existantes */
DROP TABLE IF EXISTS Historique_Vol,template_Avion, template_Vol, Reservation, Client, Vol, Avion, Aeroport, Company, Pays;

/***************************************/
/*
CREATE TABLE
*/

CREATE TABLE Company(
	compId SMALLINT(6) PRIMARY KEY NOT NULL,
	compNom VARCHAR(50),
	compPays TINYINT(4)
)ENGINE=InnoDB CHARSET=utf8;

CREATE TABLE Avion(
	avionId INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
	avionModele VARCHAR(20),
	avionCompany SMALLINT(6),
	nbPlaces SMALLINT(6)
)ENGINE=InnoDB CHARSET=utf8;

CREATE TABLE Vol(
	volId VARCHAR(10) PRIMARY KEY NOT NULL ,
	volAeroDepart VARCHAR(3),
	volAeroDestination VARCHAR(3),
	volDateHeureDepart DATETIME,
	volDateHeureArrivee DATETIME,
	volNbPlace SMALLINT(6),
	volAvion INT(11)
)ENGINE=InnoDB CHARSET=utf8;

CREATE TABLE Aeroport(
	aeroId CHAR(3) PRIMARY KEY NOT NULL,
	aeroNom VARCHAR(30),
	aeroPays TINYINT(4)
)ENGINE=InnoDB CHARSET=utf8;

CREATE TABLE Pays(
	paysId TINYINT(4) PRIMARY KEY NOT NULL,
	paysNom VARCHAR(30)
)ENGINE=InnoDB CHARSET=utf8;

CREATE TABLE Client(
	clientId INT(11) PRIMARY KEY NOT NULL,	
	clientNom VARCHAR(30),
	clientPrenom VARCHAR(30),
	clientRue VARCHAR(100),
	clientCP VARCHAR(6),
	clientVille VARCHAR(30),
	clientPays TINYINT(4)
)ENGINE=InnoDB CHARSET=utf8;

CREATE TABLE Reservation(
	resaId BIGINT(20) PRIMARY KEY NOT NULL,
	resaDate DATE,
	resaVol VARCHAR(10),
	resaPlace VARCHAR(5),
	resaNomPassager VARCHAR(60),
	resaClient INT(11)
)ENGINE=InnoDB CHARSET=utf8;

CREATE TABLE Historique_Vol(
	histoVolId VARCHAR(10) PRIMARY KEY NOT NULL ,
	histoVolAeroDepart VARCHAR(3),
	histoVolAeroDestination VARCHAR(3),
	histoVolDateHeureDepart DATETIME,
	histoVolDateHeureArrivee DATETIME,
	histoVolNbPlace SMALLINT(6),
	histoVolAvion INT(11)
)ENGINE=InnoDB CHARSET=utf8;

/***************************************/
/*Mise en oeuvre du CIF
ALTER TABLE
	ADD FOREIGN KEY */
ALTER TABLE Company
	ADD FOREIGN KEY (compPays) REFERENCES Pays(paysId);

ALTER TABLE Avion
	ADD FOREIGN KEY (avionCompany) REFERENCES Company(compId);

ALTER TABLE Vol
	ADD FOREIGN KEY (volAvion) REFERENCES Avion(avionId),
	ADD FOREIGN KEY (volAeroDepart) REFERENCES Aeroport(aeroId),
	ADD FOREIGN KEY (volAeroDestination) REFERENCES Aeroport(aeroId);

ALTER TABLE Aeroport
	ADD FOREIGN KEY (aeroPays) REFERENCES Pays(paysId);

ALTER TABLE Client
	ADD FOREIGN KEY (clientPays) REFERENCES Pays(paysId);

ALTER TABLE Reservation
	ADD FOREIGN KEY (resaClient) REFERENCES Client(clientId),
	ADD FOREIGN KEY (resaVol) REFERENCES Vol(volId);

ALTER TABLE Historique_Vol
	ADD FOREIGN KEY (histoVolAvion) REFERENCES Avion(avionId),
	ADD FOREIGN KEY (histoVolAeroDepart) REFERENCES Aeroport(aeroId),
	ADD FOREIGN KEY (histoVolAeroDestination) REFERENCES Aeroport(aeroId);

source intereurope_trigger.sql;


