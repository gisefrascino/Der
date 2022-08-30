-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema portfoliodb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema portfoliodb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `portfoliodb` DEFAULT CHARACTER SET utf8mb4 ;
USE `portfoliodb` ;

-- -----------------------------------------------------
-- Table `portfoliodb`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfoliodb`.`persona` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `apellido` VARCHAR(45) NOT NULL,
  `img_fondo` VARCHAR(100) NULL DEFAULT NULL,
  `img_perfil` VARCHAR(100) NULL DEFAULT NULL,
  `info_profesional` VARCHAR(200) NULL DEFAULT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(50) NULL DEFAULT NULL,
  `provincia` VARCHAR(50) NULL DEFAULT NULL,
  `titulo` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `portfoliodb`.`educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfoliodb`.`educacion` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `fecha_fin` VARCHAR(30) NULL DEFAULT NULL,
  `fecha_inicio` VARCHAR(30) NULL DEFAULT NULL,
  `institucion` VARCHAR(50) NOT NULL,
  `titulo` VARCHAR(50) NOT NULL,
  `persona_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `persona_id`),
  INDEX `fk_educacion_persona1_idx` (`persona_id` ASC) VISIBLE,
  CONSTRAINT `fk_educacion_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `portfoliodb`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `portfoliodb`.`experiencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfoliodb`.`experiencia` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `empresa` VARCHAR(60) NOT NULL,
  `fecha_fin` VARCHAR(30) NULL DEFAULT NULL,
  `fecha_inicio` VARCHAR(30) NULL DEFAULT NULL,
  `puesto` VARCHAR(45) NOT NULL,
  `tareas` VARCHAR(200) NULL DEFAULT NULL,
  `persona_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `persona_id`),
  INDEX `fk_experiencia_persona1_idx` (`persona_id` ASC) VISIBLE,
  CONSTRAINT `fk_experiencia_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `portfoliodb`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `portfoliodb`.`habilidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfoliodb`.`habilidad` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `porcentaje` INT(11) NOT NULL,
  `persona_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `persona_id`),
  INDEX `fk_habilidad_persona1_idx` (`persona_id` ASC) VISIBLE,
  CONSTRAINT `fk_habilidad_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `portfoliodb`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `portfoliodb`.`proyecto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfoliodb`.`proyecto` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(100) NULL DEFAULT NULL,
  `fecha_realizacion` VARCHAR(30) NULL DEFAULT NULL,
  `img_proyecto` VARCHAR(100) NULL DEFAULT NULL,
  `link` VARCHAR(100) NULL DEFAULT NULL,
  `nombre` VARCHAR(60) NOT NULL,
  `persona_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `persona_id`),
  INDEX `fk_proyecto_persona1_idx` (`persona_id` ASC) VISIBLE,
  CONSTRAINT `fk_proyecto_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `portfoliodb`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `portfoliodb`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfoliodb`.`rol` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `rol_nombre` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `portfoliodb`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfoliodb`.`usuario` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(60) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `nombre_usuario` VARCHAR(50) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `persona_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `persona_id`),
  UNIQUE INDEX `UK_puhr3k3l7bj71hb7hk7ktpxn0` (`nombre_usuario` ASC) VISIBLE,
  INDEX `fk_usuario_persona1_idx` (`persona_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_persona1`
    FOREIGN KEY (`persona_id`)
    REFERENCES `portfoliodb`.`persona` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `portfoliodb`.`usuario_rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfoliodb`.`usuario_rol` (
  `usuario_id` INT(11) NOT NULL,
  `rol_id` INT(11) NOT NULL,
  PRIMARY KEY (`usuario_id`, `rol_id`),
  INDEX `FK610kvhkwcqk2pxeewur4l7bd1` (`rol_id` ASC) VISIBLE,
  CONSTRAINT `FK610kvhkwcqk2pxeewur4l7bd1`
    FOREIGN KEY (`rol_id`)
    REFERENCES `portfoliodb`.`rol` (`id`),
  CONSTRAINT `FKbyfgloj439r9wr9smrms9u33r`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `portfoliodb`.`usuario` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
