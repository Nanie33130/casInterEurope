	-- Données

INSERT INTO template_Avion VALUES (1,'A320-200',200),
								  (2,'Boeing 757',289),
								  (3,'A320-250',250);

INSERT INTO template_Vol VALUES (1,'MRS','OPO',1),
								(2,'MRS','CDG',2);

	-- Procédures de remplissage des tables Avion et Vol

-- Changement du delimiteur pour qu'il n'y ai pas conflit entre les differents points virgules 
DELIMITER $$

DROP PROCEDURE IF EXISTS template2avion$$
DROP PROCEDURE IF EXISTS vol2template$$
DROP PROCEDURE IF EXISTS template2vol$$
DROP FUNCTION IF EXISTS newNumVol$$


-- FUNCTIONS

CREATE FUNCTION newNumVol ( PvolAeroDepart VARCHAR(3), PvolDateHeureDepart SMALLINT(2))
RETURNS VARCHAR(10)
BEGIN
	-- éclaration des variables
	DECLARE VvolId VARCHAR(5);
	DECLARE VvolNum VARCHAR(5);
	DECLARE VvolIdFinal VARCHAR(10);
	DECLARE VnumChar SMALLINT;
	DECLARE Compteur TINYINT;
	DECLARE Fin TINYINT;

	
	-- les données sur le modèle recherché
	SELECT MAX(SUBSTRING(volId,6))
	INTO VvolId
	FROM Vol
	WHERE volAeroDepart= PvolAeroDepart AND SUBSTRING(YEAR(volDateHeureDepart),3)=PvolDateHeureDepart;

	SET VvolNum= CONCAT(PvolAeroDepart, PvolDateHeureDepart);

	-- On parcours les 5 caractères du numero
	SET Compteur=0;
	SET Fin=0;
	SET VvolIdFinal='';

	WHILE Compteur<5 DO
		-- On récupère le caractère à traiter
		SET VnumChar=ASCII(SUBSTRING(VvolId,5-Compteur,1));

		IF Fin=0 THEN
			-- Caractère Z
			IF VnumChar=90 THEN
				-- Caractère 0
				SET VnumChar=48;
			-- Caratère 9
			ELSEIF VnumChar =57 THEN
				-- Caractère A
				SET VnumChar=65;
				SET Fin=1;
			ELSE 
				-- On incrémente le caractère de 1
				SET VnumChar=VnumChar+1;
				SET Fin=1;
			END IF;
		END IF;

		SET VvolIdFinal=CONCAT(CHAR(VnumChar),VvolNum);

		SET Compteur=Compteur+1;
	END WHILE;
	
	SET VvolIdFinal=CONCAT(VvolNum,VvolIdFinal);
	-- RETURN du VvolIdFinal
	RETURN VvolIdFinal;
END$$


-- PROCEDURES

CREATE PROCEDURE template2avion( IN PmodeleId SMALLINT, IN Pcompany SMALLINT)
BEGIN
	-- déclaration des variables
	DECLARE VavionModele VARCHAR(20);
	DECLARE VnbPlaces SMALLINT;
	
	-- les données sur le modèle recherché
	SELECT avionModeleNom, avionNbPlaces
	INTO VavionModele, VnbPlaces
	FROM template_Avion
	WHERE avionModeleId=PmodeleId;

	-- création du nouvel avion
	INSERT INTO Avion VALUES (NULL, VavionModele, Pcompany, VnbPlaces);

END$$

CREATE PROCEDURE vol2template(IN PvolId VARCHAR(10))
BEGIN
	-- déclaration des variables
	DECLARE VvolAeroDepart VARCHAR(3);
	DECLARE VvolAeroDestination VARCHAR(3);
	DECLARE VvolAvion INT(11);

	-- les données sur le modèle recherché
	SELECT volAeroDepart, volAeroDestination, volAvion
	INTO VvolAeroDepart, VvolAeroDestination, VvolAvion
	FROM Vol
	WHERE volId=PvolId;

	-- création du nouvel avion
	INSERT INTO template_Vol VALUES (NULL, VvolAeroDepart, VvolAeroDestination, VvolAvion);

END$$

CREATE PROCEDURE template2vol(IN PtempId INT, IN PvolDateHeureDepart DATETIME, IN PvolDateHeureArrivee DATETIME, IN PvolNbPlace SMALLINT(6))
BEGIN
	-- déclaration des variables
	DECLARE VvolAeroDepart VARCHAR(3);
	DECLARE VvolAeroDestination VARCHAR(3);
	DECLARE VvolAvion INT(11);

	-- les données sur le modèle recherché
	SELECT volAeroDepart, volAeroDestination, volAvion
	INTO VvolAeroDepart, VvolAeroDestination, VvolAvion
	FROM template_Vol
	WHERE volTemplateId=PtempId;

	-- création du nouvel avion
	INSERT INTO Vol VALUES (SUBSTRING(MD5(now()),1,10), VvolAeroDepart,VvolAeroDestination, PvolDateHeureDepart, PvolDateHeureArrivee, PvolNbPlace, VvolAvion);

END$$
-- Réintialisation du délimiteur
DELIMITER ;

