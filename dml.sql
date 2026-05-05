START TRANSACTION;
INSERT INTO `gestione-film`.`attore` VALUES
(1, 'Marcello Mastroianni', 1924, 'Italia'),
(2, 'Sophia Loren', 1934, 'Italia'),
(3, 'Robin Williams', 1951, 'USA'),
(4, 'Jean Reno', 1948, 'Francia'),
(5, 'Ken Watanabe', 1959, 'Giappone'),
(6, 'Leonardo DiCaprio', 1974, 'USA'),
(7, 'Harrison Ford', 1942, 'USA');
COMMIT;

START TRANSACTION;
START TRANSACTION;
INSERT INTO `gestione-film`.`film` VALUES
(1, 'La Dolce Vita', 1960, 'Italia', 'F. Fellini', 'Drammatico', 180),
(2, '8½', 1963, 'Italia', 'F. Fellini', 'Drammatico', 140),
(3, 'Casablanca', 1942, 'USA', 'M. Curtiz', 'Drammatico', 102),
(4, 'Inception', 2010, 'USA', 'C. Nolan', 'Fantascienza', 148),
(5, 'Godzilla', 1998, 'Giappone', 'R. Emmerich', 'Fantascienza', 139),
(6, 'Il favoloso mondo di Amélie', 2001, 'Francia', 'J.P. Jeunet', 'Commedia', 122),
(7, 'E.T.', 1982, 'USA', 'S. Spielberg', 'Fantascienza', 115),
(8, 'Minority Report', 2002, 'USA', 'S. Spielberg', 'Fantascienza', 145),
(9, 'Lost in Translation', 2003, 'Giappone', 'S. Coppola', 'Drammatico', 102),
(10, 'French SciFi', 2005, 'Francia', 'A. Director', 'Fantascienza', 110);

INSERT INTO `gestione-film`.`attore_film` VALUES
(1,1), (1,2), (2,1), (2,2), (3,7), (3,8), (4,6), (5,5), (6,4), (7,7);

INSERT INTO `gestione-film`.`sala` (`id_sala`, `posti`, `nome`, `citta`) VALUES 
(1, 100, 'Cinema Pisa Centro', 'Pisa'),
(2, 50, 'Cinema Pisa Nord', 'Pisa'),
(3, 120, 'Cinema Napoli Uno', 'Napoli'),
(4, 80, 'Cinema Napoli Due', 'Napoli'),
(5, 200, 'Cinema Roma', 'Roma');

INSERT INTO `gestione-film`.`proiezione` (`id_proiezione`, `id_film`, `id_sala`, `incasso`, `data_proiezione`) VALUES
(1, 7, 3, 5000, '2004-12-25'),
(2, 8, 4, 4000, '2004-12-25'),
(3, 4, 1, 3000, '2004-12-25'),
(4, 4, 1, 8000, '2005-01-10'),
(5, 5, 1, 7000, '2005-01-15'),
(6, 6, 2, 6000, '2005-01-20'),
(7, 10, 5, 2000, '2005-02-01'),
(8, 9, 3, 3500, '2004-11-10'),
(9, 3, 5, 1000, '2004-01-01');
-- COMMIT; / ROLLBACK;