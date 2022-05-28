-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema portfolio
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema portfolio
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `portfolio` DEFAULT CHARACTER SET utf8 ;
USE `portfolio` ;

-- -----------------------------------------------------
-- Table `portfolio`.`pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`pais` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`localidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`localidad` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `pais_id` INT NOT NULL,
  PRIMARY KEY (`id`, `pais_id`),
  INDEX `fk_localidad_pais1_idx` (`pais_id` ASC) VISIBLE,
  CONSTRAINT `fk_localidad_pais1`
    FOREIGN KEY (`pais_id`)
    REFERENCES `portfolio`.`pais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`persona` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `img_fondo` VARCHAR(100) NULL,
  `img_perfil` VARCHAR(100) NULL,
  `titulo` VARCHAR(50) NULL,
  `info_profesional` VARCHAR(200) NULL,
  `localidad_id` INT NOT NULL,
  PRIMARY KEY (`id`, `localidad_id`),
  INDEX `fk_persona_localidad1_idx` (`localidad_id` ASC) VISIBLE,
  CONSTRAINT `fk_persona_localidad1`
    FOREIGN KEY (`localidad_id`)
    REFERENCES `portfolio`.`localidad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`experiencia_laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`experiencia_laboral` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `empresa` VARCHAR(60) NOT NULL,
  `puesto` VARCHAR(45) NULL,
  `fecha_inicio` DATE NULL,
  `fecha_fin` DATE NULL,
  `tareas` VARCHAR(200) NULL,
  `persona_id` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_id`),
  INDEX `fk_experiencia_laboral_persona_idx` (`persona_id` ASC) VISIBLE,
  CONSTRAINT `fk_experiencia_laboral_persona`
    FOREIGN KEY (`persona_id`)
    REFERENCES `portfolio`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`usuario` (
  `usuario` VARCHAR(50) NOT NULL,
  `contraseña` VARCHAR(50) NOT NULL,
  `persona_id` INT NOT NULL,
  PRIMARY KEY (`usuario`, `persona_id`),
  INDEX `fk_usuario_persona1_idx` (`persona_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `portfolio`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`proyecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`proyecto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `fecha_realizacion` DATE NULL,
  `descripcion` VARCHAR(100) NULL,
  `link` VARCHAR(100) NULL,
  `img_proyecto` VARCHAR(100) NULL,
  `persona_id` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_id`),
  INDEX `fk_proyecto_persona1_idx` (`persona_id` ASC) VISIBLE,
  CONSTRAINT `fk_proyecto_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `portfolio`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`habilidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`habilidad` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `porcentaje` INT NOT NULL,
  `persona_id` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_id`),
  INDEX `fk_habilidad_persona1_idx` (`persona_id` ASC) VISIBLE,
  CONSTRAINT `fk_habilidad_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `portfolio`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`institucion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`institucion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `portfolio`.`educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio`.`educacion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(50) NULL,
  `fecha_inicio` DATE NULL,
  `fecha_fin` DATE NULL,
  `persona_id` INT NOT NULL,
  `institucion_id` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_id`, `institucion_id`),
  INDEX `fk_educacion_persona1_idx` (`persona_id` ASC) VISIBLE,
  INDEX `fk_educacion_institucion1_idx` (`institucion_id` ASC) VISIBLE,
  CONSTRAINT `fk_educacion_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `portfolio`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_educacion_institucion1`
    FOREIGN KEY (`institucion_id`)
    REFERENCES `portfolio`.`institucion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
