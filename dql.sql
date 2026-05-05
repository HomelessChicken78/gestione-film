-- 1. Il nome di tutte le sale di Pisa
SELECT nome FROM `gestione-film`.`sala`
WHERE `citta` = "Pisa"
;

-- 2. Il titolo dei film di F. Fellini prodotti dopo il 1960.
SELECT titolo FROM `gestione-film`.`film`
WHERE `regista` = "F. Fellini" AND `anno_produzione` > 1960
;

-- 3. Il titolo e la durata dei film di fantascienza giapponesi o francesi prodotti dopo il 1990
SELECT titolo FROM `gestione-film`.`film`
WHERE `genere` = "Fantascienza" AND `anno_produzione` > 1990 AND (`nazionalita` = "Giappone" OR `nazionalita` = "Francia")
;

-- 4. Il titolo dei film di fantascienza giapponesi prodotti dopo il 1990 oppure francesi
SELECT titolo FROM `gestione-film`.`film`
WHERE (`genere` = "Fantascienza" AND `anno_produzione` > 1990 AND `nazionalita` = "Giappone") OR `nazionalita` = "Francia"
;

-- 5. I titolo dei film dello stesso regista di “Casablanca”
WITH `t` AS (
	SELECT regista AS regista_casablanca FROM `gestione-film`.`film`
	WHERE titolo = "Casablanca"
)
SELECT titolo FROM `t` JOIN `gestione-film`.`film` ON `t`.`regista_casablanca` = `film`.`regista`
;

-- 6. Il titolo ed il genere dei film proiettati il giorno di Natale 2004
SELECT titolo, genere FROM `gestione-film`.`proiezione` JOIN `gestione-film`.`film` ON `film`.`id_film` = `proiezione`.`id_film`
WHERE data_proiezione = '2004-12-25'
;

-- 7. Il titolo ed il genere dei film proiettati a Napoli il giorno di Natale 2004
SELECT titolo, genere FROM `gestione-film`.`proiezione`
	JOIN `gestione-film`.`film` ON `film`.`id_film` = `proiezione`.`id_film`
	JOIN `gestione-film`.`sala` ON `sala`.`id_sala` = `proiezione`.`id_sala`
WHERE data_proiezione = '2004-12-25'
	AND `sala`.`citta` = "Napoli"
;

-- 8. I nomi delle sale di Napoli in cui il giorno di Natale 2004 è stato proiettato un film con R.Williams
SELECT `sala`.`nome` FROM `gestione-film`.`sala`
	JOIN `gestione-film`.`proiezione` ON `sala`.`id_sala` = `proiezione`.`id_sala`
	JOIN `gestione-film`.`film` ON `film`.`id_film` = `proiezione`.`id_film`
    JOIN `gestione-film`.`attore_film` ON `film`.`id_film` = `attore_film`.`id_film`
    JOIN `gestione-film`.`attore` ON `attore`.`id_attore` = `attore_film`.`id_attore`
WHERE citta = "Napoli"
	AND data_proiezione = '2004-12-25'
    AND `attore`.`nome` = "Robin Williams"
;

-- 9. Il titolo dei film in cui recita M. Mastroianni oppure S.Loren
SELECT DISTINCT titolo FROM `gestione-film`.`film`
	JOIN `gestione-film`.`attore_film` ON `film`.`id_film` = `attore_film`.`id_film`
    JOIN `gestione-film`.`attore` ON `attore`.`id_attore` = `attore_film`.`id_attore`
WHERE `attore`.`nome` = "Marcello Mastroianni" OR `attore`.`nome` = "Sophia Loren"
;

-- 10. Il titolo dei film in cui recitano M. Mastroianni e S.Loren
SELECT DISTINCT titolo FROM `gestione-film`.`film`
	JOIN `gestione-film`.`attore_film` AS att1_f ON `film`.`id_film` = att1_f.`id_film`
	JOIN `gestione-film`.`attore_film` AS att2_f ON `film`.`id_film` = att1_f.`id_film`
		AND att1_f.id_attore != att2_f.id_attore
    JOIN `gestione-film`.`attore` AS att1 ON att1.`id_attore` = att1_f.`id_attore`
    JOIN `gestione-film`.`attore` AS att2 ON att2.`id_attore` = att2_f.`id_attore`
WHERE att1.nome = "Marcello Mastroianni" AND att2.`nome` = "Sophia Loren"
;

-- 11. Per ogni film in cui recita un attore francese, il titolo del film e il nome dell’attore
SELECT titolo, att.nome FROM `gestione-film`.`attore` AS att
	JOIN `gestione-film`.`attore_film` AS att_f ON att.`id_attore` = att_f.`id_attore`
	JOIN `gestione-film`.`film` AS f ON f.`id_film` = att_f.`id_film`
WHERE att.nazionalita = "Francia"
;

-- 12. Per ogni film che è stato proiettato a Pisa nel gennaio 2005, il titolo del film e il nome della sala.
SELECT titolo, sala.nome FROM `gestione-film`.`film` AS f
	JOIN `gestione-film`.`proiezione` AS pr ON f.id_film = pr.id_film
    JOIN `gestione-film`.`sala` ON sala.id_sala = pr.id_sala
WHERE sala.citta = "Pisa" AND YEAR(pr.data_proiezione) = 2005 AND MONTH(pr.data_proiezione) = 1
;

-- 13. Il numero di sale di Pisa con più di 60 posti
SELECT COUNT(*) AS numero_sale FROM `gestione-film`.`sala`
WHERE posti > 60 AND citta = "Pisa"
;

-- 14. Il numero totale di posti nelle sale di Pisa
SELECT SUM(posti) AS tot_posti FROM `gestione-film`.`sala`
WHERE citta = "Pisa"
;

-- 15. Per ogni città, il numero di sale
SELECT citta, COUNT(id_sala) AS numero_sale FROM `gestione-film`.`sala`
GROUP BY citta
;

-- 16. Per ogni città, il numero di sale con più di 60 posti
SELECT citta, COUNT(id_sala) AS numero_sale FROM `gestione-film`.`sala`
WHERE posti > 60
GROUP BY citta
;

-- 17. Per ogni regista, il numero di film diretti dopo il 1990
SELECT regista, COUNT(id_film) FROM `gestione-film`.`film` AS f
WHERE anno_produzione > 1990
GROUP BY regista

-- 18. Per ogni regista, l’incasso totale di tutte le proiezioni dei suoi film
SELECT regista, SUM(pr.incasso) tot_incassi from `gestione-film`.`film` AS f
	JOIN `gestione-film`.`proiezione` AS pr ON f.id_film = pr.id_film
GROUP BY f.regista

-- 19. Per ogni film di S.Spielberg, il titolo del film, il numero totale di proiezioni a Pisa e l’incasso
-- totale
SELECT titolo, COUNT(pr.id_proiezione) num_proiezioni, SUM(pr.incasso) tot_incassi from `gestione-film`.`film` AS f
	JOIN `gestione-film`.`proiezione` AS pr ON f.id_film = pr.id_film
    JOIN `gestione-film`.`sala` ON sala.id_sala = pr.id_sala
WHERE sala.citta = "Pisa"
	AND f.regista = "S. Spielberg"
GROUP BY f.id_film
;

-- 20. Per ogni regista e per ogni attore, il numero di film del regista con l’attore
SELECT f.regista, att.nome AS attore, COUNT(f.id_film) FROM `gestione-film`.`film` AS f
	JOIN `gestione-film`.`attore_film` AS att_f ON f.`id_film` = att_f.`id_film`
    JOIN `gestione-film`.`attore` AS att ON att.`id_attore` = att_f.`id_attore`
GROUP BY f.regista, att_f.id_attore
;

-- 21. Il regista ed il titolo dei film in cui recitano meno di 6 attori
SELECT f.regista, f.titolo FROM `gestione-film`.`film` AS f
	JOIN `gestione-film`.`attore_film` AS att_f ON f.`id_film` = att_f.`id_film`
GROUP BY f.id_film
HAVING COUNT(id_attore) < 6
;

-- 22. Per ogni film prodotto dopo il 2000, il codice, il titolo e l’incasso totale di tutte le sue
-- proiezioni
SELECT f.id_film, f.titolo, SUM(incasso) incasso_tot FROM `gestione-film`.`film` AS f
	JOIN `gestione-film`.`proiezione` AS pr ON f.`id_film` = pr.`id_film`
WHERE YEAR(pr.data_proiezione) > 2000
GROUP BY f.id_film
;

-- 23. Il numero di attori dei film in cui appaiono solo attori nati prima del 1970
-- 23. Il numero di attori dei film in cui appaiono solo attori nati prima del 1970
SELECT * FROM `gestione-film`.`film` AS f
	JOIN `gestione-film`.`attore_film` AS att_f ON f.`id_film` = att_f.`id_film`
    JOIN `gestione-film`.`attore` AS att ON att.`id_attore` = att_f.`id_attore`
WHERE att.nome NOT IN (SELECT att.nome FROM `gestione-film`.`film` AS f
		JOIN `gestione-film`.`attore_film` AS att_f ON f.`id_film` = att_f.`id_film`
		JOIN `gestione-film`.`attore` AS att ON att.`id_attore` = att_f.`id_attore`
	WHERE att.anno_nascita > 1970
)
;
-- TODO: doesn't work right now

-- 24. Per ogni film di fantascienza, il titolo e l’incasso totale di tutte le sue proiezioni
SELECT f.titolo, SUM(pr.incasso) tot_incassi FROM `gestione-film`.`film` AS f
	JOIN `gestione-film`.`proiezione` AS pr ON f.id_film = pr.id_film
WHERE genere = "Fantascienza"
GROUP BY f.id_film
;

-- 25. Per ogni film di fantascienza il titolo e l’incasso totale di tutte le sue proiezioni successive al
-- 1/1/01
SELECT f.titolo, SUM(pr.incasso) tot_incassi FROM `gestione-film`.`film` AS f
	JOIN `gestione-film`.`proiezione` AS pr ON f.id_film = pr.id_film
WHERE genere = "Fantascienza" AND pr.data_proiezione > '2001-01-01'
GROUP BY f.id_film
;

-- 26. Per ogni film di fantascienza che non è mai stato proiettato prima del 1/1/01 il titolo e
-- l’incasso totale di tutte le sue proiezioni
SELECT f.titolo, SUM(pr.incasso) AS tot_incassi FROM `gestione-film`.`film` AS f
	JOIN `gestione-film`.`proiezione` AS pr ON f.id_film = pr.id_film
WHERE f.genere = "Fantascienza" AND
	f.titolo NOT IN (
		SELECT DISTINCT f.titolo FROM `gestione-film`.`film` AS f
			JOIN `gestione-film`.`proiezione` AS pr ON f.id_film = pr.id_film
		WHERE pr.data_proiezione < '2001-01-01'
	)
GROUP BY f.id_film
;

-- 27. Per ogni sala di Pisa, che nel mese di gennaio 2005 ha incassato più di 20000 €, il nome della
-- sala e l’incasso totale (sempre del mese di gennaio 2005)
SELECT sala.id_sala, sala.nome, SUM(pr.incasso) tot_incassi FROM `gestione-film`.`sala`
	JOIN `gestione-film`.`proiezione` AS pr ON sala.id_sala = pr.id_sala
WHERE YEAR(pr.data_proiezione) = 2005 AND MONTH(pr.data_proiezione) = 1
	AND sala.citta = "Pisa"
GROUP BY sala.id_sala, sala.nome
HAVING SUM(pr.incasso) > 20000
;

-- 28. I titoli dei film che non sono mai stati proiettati a Pisa
SELECT f.titolo FROM `gestione-film`.`film` AS f
WHERE f.titolo NOT IN (
	SELECT DISTINCT f.titolo FROM `gestione-film`.`film` AS f
		JOIN `gestione-film`.`proiezione` AS pr ON f.id_film = pr.id_film
		JOIN `gestione-film`.`sala` ON sala.id_sala = pr.id_sala
	WHERE sala.citta = "Pisa"
)

-- 29. I titoli dei film che sono stati proiettati solo a Pisa