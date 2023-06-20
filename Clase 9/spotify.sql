
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `spotify` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `spotify` ;

CREATE TABLE IF NOT EXISTS `spotify`.`artistas` (
  `artista_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `apellido` VARCHAR(100) NOT NULL,
  `imagen` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`artista_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `spotify`.`canciones` (
  `cancion_id` INT NOT NULL AUTO_INCREMENT,
  `duracion` SMALLINT(4) UNSIGNED ZEROFILL NOT NULL,
  `reproducciones` BIGINT NOT NULL,
  `likes` BIGINT NOT NULL,
  `titulo` VARCHAR(100) NOT NULL,
  `genero` VARCHAR(100) NOT NULL,
  `album_id` INT NOT NULL,
  PRIMARY KEY (`cancion_id`),
  INDEX `album_canciones_idx` (`album_id` ASC) VISIBLE,
  CONSTRAINT `album_canciones`
    FOREIGN KEY (`album_id`)
    REFERENCES `spotify`.`albums` (`album_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `spotify`.`paises` (
  `pais_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`pais_id`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `spotify`.`discograficas` (
  `discografica_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `pais_id` INT NOT NULL,
  PRIMARY KEY (`discografica_id`),
  INDEX `paises_discograficas_idx` (`pais_id` ASC) VISIBLE,
  CONSTRAINT `paises_discograficas`
    FOREIGN KEY (`pais_id`)
    REFERENCES `spotify`.`paises` (`pais_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `spotify`.`albums` (
  `album_id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(100) NOT NULL,
  `año_publicacion` DATE NOT NULL,
  `imagen` VARCHAR(100) NOT NULL,
  `cancion_id` INT NOT NULL,
  `discografica_id` INT NOT NULL,
  `artista_id` INT NOT NULL,
  PRIMARY KEY (`album_id`),
  INDEX `canciones_albums_idx` (`cancion_id` ASC) VISIBLE,
  INDEX `discograficas_albums_idx` (`discografica_id` ASC) VISIBLE,
  INDEX `artistas_albums_idx` (`artista_id` ASC) VISIBLE,
  CONSTRAINT `artistas_albums`
    FOREIGN KEY (`artista_id`)
    REFERENCES `spotify`.`artistas` (`artista_id`),
  CONSTRAINT `canciones_albums`
    FOREIGN KEY (`cancion_id`)
    REFERENCES `spotify`.`canciones` (`cancion_id`),
  CONSTRAINT `discograficas_albums`
    FOREIGN KEY (`discografica_id`)
    REFERENCES `spotify`.`discograficas` (`discografica_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `spotify`.`validaciones` (
  `validacion_id` INT NOT NULL AUTO_INCREMENT,
  `fecha_modificacion` DATE NOT NULL,
  `contador_fecha` TINYINT NOT NULL,
  PRIMARY KEY (`validacion_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `spotify`.`usuarios` (
  `usuario_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(200) NOT NULL,
  `sexo` VARCHAR(50) NOT NULL,
  `codigo_postal` INT NOT NULL,
  `subscripcion_premium` TINYINT(1) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `contraseña` VARCHAR(500) NOT NULL,
  `validacion_id` INT NOT NULL,
  `pais_id` INT NOT NULL,
  PRIMARY KEY (`usuario_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `usuario_validacion_idx` (`validacion_id` ASC) VISIBLE,
  INDEX `pais_usuario_idx` (`pais_id` ASC) VISIBLE,
  CONSTRAINT `pais_usuario`
    FOREIGN KEY (`pais_id`)
    REFERENCES `spotify`.`paises` (`pais_id`),
  CONSTRAINT `validacion_usuario`
    FOREIGN KEY (`validacion_id`)
    REFERENCES `spotify`.`validaciones` (`validacion_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `spotify`.`playlists` (
  `playlist_id` INT NOT NULL AUTO_INCREMENT,
  `cantidad_canciones` INT NOT NULL,
  `fecha_creacion` DATE NOT NULL,
  `eliminada` TINYINT(1) NOT NULL,
  `fecha_eliminacion` DATE NOT NULL,
  `titulo` VARCHAR(100) NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`playlist_id`),
  INDEX `usuarios_playlists_idx` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `usuarios_playlists`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `spotify`.`usuarios` (`usuario_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
