CREATE TABLE `UniversoLector`.`Socio` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `dni` INT NOT NULL,
  `apellidos` VARCHAR(100) NOT NULL,
  `nombres` VARCHAR(100) NOT NULL,
  `direccion` VARCHAR(200) NOT NULL,
  `localidad` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`codigo`));

---

CREATE TABLE `UniversoLector`.`TelefonoxSocio` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `nrotelefono` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`codigo`),
  CONSTRAINT `codigo_socio`
    FOREIGN KEY (`codigo`)
    REFERENCES `UniversoLector`.`Socio` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

---

CREATE TABLE `UniversoLector`.`Prestamo` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL,
  `fecha_devolucion` DATE NOT NULL,
  `fecha_tope` DATE NOT NULL,
  PRIMARY KEY (`codigo`),
  CONSTRAINT `codigo_socio_ii`
    FOREIGN KEY (`codigo`)
    REFERENCES `UniversoLector`.`Socio` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

---

CREATE TABLE `UniversoLector`.`Volumen` (
  `codigo` INT NOT NULL,
  `deteriorado` TINYINT NOT NULL,
  PRIMARY KEY (`codigo`));

ALTER TABLE `UniversoLector`.`Volumen` 
ADD CONSTRAINT `codigo_libro`
  FOREIGN KEY (`codigo`)
  REFERENCES `UniversoLector`.`Libro` (`codigo`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

---

CREATE TABLE `UniversoLector`.`Libro` (
  `codigo` INT NOT NULL,
  `isbn` VARCHAR(13) NOT NULL,
  `titulo` VARCHAR(200) NOT NULL,
  `anio_escritura` DATE NOT NULL,
  `anio_edicion` DATE NOT NULL,
  PRIMARY KEY (`codigo`));

ALTER TABLE `UniversoLector`.`Libro` 
ADD CONSTRAINT `codigo_autor`
  FOREIGN KEY (`codigo`)
  REFERENCES `UniversoLector`.`Autor` (`codigo`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `codigo_editorial`
  FOREIGN KEY (`codigo`)
  REFERENCES `UniversoLector`.`Editorial` (`codigo`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

---

CREATE TABLE `UniversoLector`.`Autor` (
  `codigo` INT NOT NULL,
  `apellidos` VARCHAR(100) NOT NULL,
  `nombres` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`codigo`));

---

CREATE TABLE `UniversoLector`.`Editorial` (
  `codigo` INT NOT NULL,
  `razon_social` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`codigo`));

---

ALTER TABLE `UniversoLector`.`Volumen` 
ADD CONSTRAINT `codigo_libro`
  FOREIGN KEY (`codigo`)
  REFERENCES `UniversoLector`.`Libro` (`codigo`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;