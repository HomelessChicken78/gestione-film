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
  `id_film` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_attore`, `id_film`));
ALTER TABLE `gestione-film`.`attore_film` 
ADD CONSTRAINT `fk_attore`
  FOREIGN KEY (`id_attore`)
  REFERENCES `gestione-film`.`attore` (`id_attore`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
