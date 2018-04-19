INSERT INTO Pays VALUES (1,'France'),(2,'Angleterre'),(3,'Portugal'),(4,'Espagne'),(5,'Autralie');

INSERT INTO Company VALUES (1,'Air France',1),(2,'RyanAir',2);

INSERT INTO Avion VALUES (1,'A320-200',1,200),(2,'A320-200',2,200),(3,'A320-250',2,250);

INSERT INTO Aeroport VALUES ('BCL','Barcelone',4),('CDG','Paris Charles de Gaule',1),('MRS','Marseille Marignane',1),('OPO','Porto',3),('STX','Lyon Saint Exupéry',1);


INSERT INTO Vol VALUES 	('MRS1600001','MRS','OPO','2017-03-01 17:50:08','2018-03-01 19:12:01',200,1),
			('MRS16AAAAA','MRS','OPO','2018-03-21 10:00:00','2018-03-21 11:21:00',200,1),
			('MRS16BBBBB','MRS','OPO','2018-03-10 23:00:00','2018-03-11 00:21:00',200,1);


INSERT INTO Client VALUES 	(1,'TOTO','Robert','102 missile fixe','05000','Gap',1),
							(2,'MACRON','Emmanuel','1 rue Elysée','750000','Paris',1),
							(3,'CRUZ','Penelope','Plaça Sant Jaume','08002','Barcelone',4),
							(4,'LEGRAND', 'Julien', 'Rue Carnot','05000','Gap',1),
							(5,'TAYLOR-COTTER', 'Eliza','Un endroit en Australie','03000','Melbourne',5),
							(6,'LEBEAU','Melanie','109 Boulevard Georges Pompidou','05000','Gap',1);


INSERT INTO Reservation VALUES (15,'2017-02-20', 'MRS1600001', '1', 'TOTO', 1),
							   (32, '2018-03-05', 'MRS16AAAAA', '2', 'MACRON', 2),
							   (65, '2018-03-04', 'MRS16BBBBB', '1', 'CRUZ', 3),
							   (70,'2018-03-05', 'MRS16AAAAA','1', 'LEGRAND',4),
							   (71,'2018-03-07', 'MRS16AAAAA','1', 'LEGRAND',4),
							   (72,'2018-03-08', 'MRS16AAAAA','1', 'LEGRAND',4),
							   (18, '2018-04-05','MRS16BBBBB','9','LEBEAU',6),
							   (100,'2018-04-05','MRS16BBBBB','48','TAYLOR-COTTER',5);

source intereurope_template_base.sql;