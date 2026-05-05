-- CREATE SCHEMA `gestione-film` ;
CREATE TABLE `gestione-film`.`attore` (
  `id_attore` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `anno_nascita` INT NOT NULL,
  `nazionalita` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_attore`));

CREATE TABLE `gestione-film`.`film` (
  `id_film` INT NOT NULL,
  `titolo` VARCHAR(45) NOT NULL,
  `anno_produzione` INT NOT NULL,
  `nazionalita` VARCHAR(45) NOT NULL,
  `regista` VARCHAR(45) NOT NULL,
  `durata` INT NOT NULL,
  PRIMARY KEY (`id_film`));

CREATE TABLE `gestione-film`.`attore_film` (
  `id_attore` INT NOT NULL,
  `id_film` INT NOT NULL,
  PRIMARY KEY (`id_attore`, `id_film`));
ALTER TABLE `gestione-film`.`attore_film` 
ADD INDEX `fk_film_idx` (`id_film` ASC) VISIBLE;
;
ALTER TABLE `gestione-film`.`attore_film` 
ADD CONSTRAINT `fk_attore`
  FOREIGN KEY (`id_attore`)
  REFERENCES `gestione-film`.`attore` (`id_attore`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_film`
  FOREIGN KEY (`id_film`)
  REFERENCES `gestione-film`.`film` (`id_film`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

CREATE TABLE `gestione-film`.`sala` (
  `id_sala` INT NOT NULL,
  `posti` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `citta` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_sala`));

CREATE TABLE `gestione-film`.`proiezione` (
  `id_proiezione` INT NOT NULL,
  `id_sala` INT NOT NULL,
  `id_film` INT NOT NULL,
  `incasso` REAL NOT NULL,
  `data_proiezione` DATE NOT NULL,
  PRIMARY KEY (`id_proiezione`));
ALTER TABLE `gestione-film`.`proiezione` 
ADD INDEX `fk_film_idx` (`id_film` ASC) VISIBLE,
ADD INDEX `fk_sala_idx` (`id_sala` ASC) VISIBLE;
;
ALTER TABLE `gestione-film`.`proiezione` 
ADD CONSTRAINT `fk_film`
  FOREIGN KEY (`id_film`)
  REFERENCES `gestione-film`.`film` (`id_film`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_sala`
  FOREIGN KEY (`id_sala`)
  REFERENCES `gestione-film`.`sala` (`id_sala`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
