/* Présentation :
	nomScript: intereurope_template_data.sql
	nomBase: InterEuropeBDD
	Auteur: Mélanie Lebeau
	Date de création : 22/02/2018
*/

/***************************************/
/*Suppression des tables existantes */
-- DROP TABLE IF EXISTS template_Avion;
-- DROP TABLE IF EXISTS template_Vol;

/***************************************/
/*
CREATE TABLE
*/

CREATE TABLE template_Avion(
	avionModeleId SMALLINT(6) PRIMARY KEY NOT NULL,
	avionModeleNom VARCHAR(30),
	avionNbPlaces SMALLINT(6)
)ENGINE=InnoDB CHARSET=utf8;

CREATE TABLE template_Vol(
	volTemplateId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	volAeroDepart CHAR(3),
	volAeroDestination CHAR(3),
	volAvion INT(11)
)ENGINE=InnoDB CHARSET=utf8;

ALTER TABLE template_Vol
	ADD FOREIGN KEY (volAeroDepart) REFERENCES Aeroport(aeroId),
	ADD FOREIGN KEY (volAeroDestination) REFERENCES Aeroport(aeroId),
	ADD FOREIGN KEY (volAvion) REFERENCES Avion(avionId);

source intereurope_template_data.sql;