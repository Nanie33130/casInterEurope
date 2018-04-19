-- Changement du délimiteur
DELIMITER $$
DROP TRIGGER IF EXISTS validVols$$
DROP TRIGGER IF EXISTS nbrPlaces$$
DROP TRIGGER IF EXISTS historique_vol$$

CREATE TRIGGER InterEuropeBDD.validVols
BEFORE INSERT ON Vol
FOR EACH ROW
BEGIN
	-- Déclaration des Variables
	DECLARE VDateHeureDep DATETIME;
	DECLARE VDateHeureDest DATETIME;
	-- Un vol ne peut décoller et atterrir dans un même aéroport
	IF(NEW.volAeroDepart=NEW.volAeroDestination) THEN
		signal sqlstate "45000" SET message_text = "Même aéroport en décollage et atterrisage";
	END IF;
	-- Un vol ne peut aterrir avant même d'avoir décollé
	IF(NEW.volDateHeureDepart>NEW.volDateHeureArrivee) THEN
		signal sqlstate "45000" SET message_text = "L'avion ne peut décoller avant d'atterrir";
	END IF;
	-- Un avion ne peut servir pour plusieurs vols à la fois
	SELECT volDateHeureDepart, volDateHeureArrivee
	INTO VDateHeureDep,VDateHeureDest
	FROM Vol
	WHERE volAvion=NEW.volAvion AND volDateHeureDepart=NEW.volDateHeureDepart;
	IF(NEW.volDateHeureDepart BETWEEN VDateHeureDep AND VDateHeureDest) THEN
		signal sqlstate "45000" SET message_text="L'avion est déjà en vol";
	END IF;
END$$


CREATE TRIGGER InterEuropeBDD.nbrPlaces
AFTER INSERT ON Reservation
FOR EACH ROW
BEGIN 
	-- Déclaration des Variables
	DECLARE VNbPlaces smallint(6);

	-- Recherche de nombre de place disponibles
	SELECT volNbPlace 
	INTO VNbPlaces
	FROM Vol
	WHERE VolId= NEW.resaVol;

	-- Obtention du nbr de place reservées

	IF(VNbPlaces>0) THEN
		UPDATE Vol
		SET volNbPlace= volNbPlace -1
		WHERE VolId=NEW.resaVol;
	END IF;
END$$

CREATE TRIGGER InterEuropeBDD.historique_vol
BEFORE DELETE ON Vol
FOR EACH ROW
BEGIN
	-- INSERT INTO du vol supprimé
	INSERT INTO Historique_Vol
	VALUES (OLD.volId, OLD.volAeroDepart, OLD.volAeroDestination, OLD.volDateHeureDepart, OLD.volDateHeureArrivee, OLD.volNbPlace, OLD.volAvion);

	-- DELETE de la reservation
	DELETE FROM Reservation
	WHERE resaVol=OLD.volId;
END$$

DELIMITER ;

source intereurope_data.sql;