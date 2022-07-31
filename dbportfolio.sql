-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema dbportfolio
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dbportfolio
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dbportfolio` DEFAULT CHARACTER SET utf8 ;
USE `dbportfolio` ;

-- -----------------------------------------------------
-- Table `dbportfolio`.`pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbportfolio`.`pais` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbportfolio`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbportfolio`.`provincia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `pais_id` INT NOT NULL,
  PRIMARY KEY (`id`, `pais_id`),
  INDEX `fk_provincia_pais1_idx` (`pais_id` ASC) VISIBLE,
  CONSTRAINT `fk_provincia_pais1`
    FOREIGN KEY (`pais_id`)
    REFERENCES `dbportfolio`.`pais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbportfolio`.`localidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbportfolio`.`localidad` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `provincia_id` INT NOT NULL,
  PRIMARY KEY (`id`, `provincia_id`),
  INDEX `fk_localidad_provincia1_idx` (`provincia_id` ASC) VISIBLE,
  CONSTRAINT `fk_localidad_provincia1`
    FOREIGN KEY (`provincia_id`)
    REFERENCES `dbportfolio`.`provincia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbportfolio`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbportfolio`.`persona` (
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
    REFERENCES `dbportfolio`.`localidad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbportfolio`.`experiencia_laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbportfolio`.`experiencia_laboral` (
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
    REFERENCES `dbportfolio`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbportfolio`.`institucion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbportfolio`.`institucion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbportfolio`.`educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbportfolio`.`educacion` (
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
    REFERENCES `dbportfolio`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_educacion_institucion1`
    FOREIGN KEY (`institucion_id`)
    REFERENCES `dbportfolio`.`institucion` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbportfolio`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbportfolio`.`usuario` (
  `usuario` VARCHAR(50) NOT NULL,
  `contraseña` VARCHAR(50) NOT NULL,
  `persona_id` INT NOT NULL,
  PRIMARY KEY (`usuario`, `persona_id`),
  INDEX `fk_usuario_persona1_idx` (`persona_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `dbportfolio`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbportfolio`.`proyecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbportfolio`.`proyecto` (
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
    REFERENCES `dbportfolio`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dbportfolio`.`habilidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbportfolio`.`habilidad` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `porcentaje` INT NOT NULL,
  `persona_id` INT NOT NULL,
  PRIMARY KEY (`id`, `persona_id`),
  INDEX `fk_habilidad_persona1_idx` (`persona_id` ASC) VISIBLE,
  CONSTRAINT `fk_habilidad_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `dbportfolio`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
