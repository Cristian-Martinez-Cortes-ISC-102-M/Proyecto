-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_UBAM prueba dde commit desde development
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_UBAM
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_UBAM` DEFAULT CHARACTER SET utf8 ;
USE `db_UBAM` ;

-- -----------------------------------------------------
-- Table `db_UBAM`.`tbl_cat_turno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_UBAM`.`tbl_cat_turno` (
  `turnoid` INT NOT NULL AUTO_INCREMENT,
  `turno_turno` VARCHAR(45) NULL,
  `turno_activo` INT NULL,
  PRIMARY KEY (`turnoid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_UBAM`.`tbl_cat_carrera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_UBAM`.`tbl_cat_carrera` (
  `carreraid` INT NOT NULL AUTO_INCREMENT,
  `carrera_carrera` VARCHAR(150) NULL,
  `carrera_carreraabreviada` VARCHAR(10) NULL,
  `carrera_activo` INT NULL,
  PRIMARY KEY (`carreraid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_UBAM`.`tbl_cat_grado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_UBAM`.`tbl_cat_grado` (
  `gradoid` INT NOT NULL AUTO_INCREMENT,
  `grado_grado` VARCHAR(45) NULL,
  `grado_activo` INT NULL,
  PRIMARY KEY (`gradoid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_UBAM`.`tbl_cat_grupo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_UBAM`.`tbl_cat_grupo` (
  `grupoid` INT NOT NULL AUTO_INCREMENT,
  `grupo_carreraid` INT NULL,
  `grupo_gradoid` INT NULL,
  `grupo_turnoid` INT NULL,
  `grupo_activo` INT NULL,
  PRIMARY KEY (`grupoid`),
  INDEX `grupo_carrera_idx` (`grupo_carreraid` ASC) VISIBLE,
  INDEX `grupo_grado_idx` (`grupo_gradoid` ASC) VISIBLE,
  INDEX `grupo_turno_idx` (`grupo_turnoid` ASC) VISIBLE,
  CONSTRAINT `grupo_carrera`
    FOREIGN KEY (`grupo_carreraid`)
    REFERENCES `db_UBAM`.`tbl_cat_carrera` (`carreraid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `grupo_grado`
    FOREIGN KEY (`grupo_gradoid`)
    REFERENCES `db_UBAM`.`tbl_cat_grado` (`gradoid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `grupo_turno`
    FOREIGN KEY (`grupo_turnoid`)
    REFERENCES `db_UBAM`.`tbl_cat_turno` (`turnoid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_UBAM`.`tbl_cat_estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_UBAM`.`tbl_cat_estado` (
  `estadoid` INT NOT NULL AUTO_INCREMENT,
  `estado_estado` VARCHAR(60) NULL,
  `estado_activo` INT NULL,
  PRIMARY KEY (`estadoid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_UBAM`.`tbl_cat_municipio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_UBAM`.`tbl_cat_municipio` (
  `municipioid` INT NOT NULL AUTO_INCREMENT,
  `municipio_municipio` VARCHAR(70) NULL,
  `municipio_estadoid` INT NULL,
  `municipio_activo` INT NULL,
  PRIMARY KEY (`municipioid`),
  INDEX `municipio_estado_idx` (`municipio_estadoid` ASC) VISIBLE,
  CONSTRAINT `municipio_estado`
    FOREIGN KEY (`municipio_estadoid`)
    REFERENCES `db_UBAM`.`tbl_cat_estado` (`estadoid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_UBAM`.`tbl_cat_sexo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_UBAM`.`tbl_cat_sexo` (
  `sexoid` INT NOT NULL AUTO_INCREMENT,
  `sexo_sexo` VARCHAR(45) NULL,
  `sexo_activo` VARCHAR(45) NULL,
  PRIMARY KEY (`sexoid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_UBAM`.`tbl_ope_direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_UBAM`.`tbl_ope_direccion` (
  `direccionid` INT NOT NULL AUTO_INCREMENT,
  `direccion_calle` VARCHAR(100) NULL,
  `direccion_numint` INT NULL,
  `direccion_numext` INT NULL,
  `direcion_cp` INT NULL,
  `direccion_colonia` VARCHAR(45) NULL,
  `direccion_municipioid` INT NULL,
  `direccion_activo` INT NULL,
  PRIMARY KEY (`direccionid`),
  INDEX `direccion_municipio_idx` (`direccion_municipioid` ASC) VISIBLE,
  CONSTRAINT `direccion_municipio`
    FOREIGN KEY (`direccion_municipioid`)
    REFERENCES `db_UBAM`.`tbl_cat_municipio` (`municipioid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_UBAM`.`tbl_ope_contacto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_UBAM`.`tbl_ope_contacto` (
  `contactoid` INT NOT NULL AUTO_INCREMENT,
  `contacto_email` VARCHAR(100) NULL,
  `contacto_celular` INT NULL,
  `contacto_numrecados` INT NULL,
  `contacto_numcasa` INT NULL,
  `contacto_activo` INT NULL,
  PRIMARY KEY (`contactoid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_UBAM`.`tbl_ope_persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_UBAM`.`tbl_ope_persona` (
  `personaid` INT NOT NULL AUTO_INCREMENT,
  `persona_nombre` VARCHAR(60) NULL,
  `persona_apellidopaterno` VARCHAR(60) NULL,
  `persona_apellidomaterno` VARCHAR(60) NULL,
  `persona_fechanacimiento` DATE NULL,
  `persona_sexoid` INT NULL,
  `persona_direccionid` INT NULL,
  `persona_contactoid` INT NULL,
  `persona_activo` INT NULL,
  PRIMARY KEY (`personaid`),
  INDEX `persona_sexo_idx` (`persona_sexoid` ASC) VISIBLE,
  INDEX `persona_direccion_idx` (`persona_direccionid` ASC) VISIBLE,
  INDEX `persona_contacto_idx` (`persona_contactoid` ASC) VISIBLE,
  CONSTRAINT `persona_sexo`
    FOREIGN KEY (`persona_sexoid`)
    REFERENCES `db_UBAM`.`tbl_cat_sexo` (`sexoid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `persona_direccion`
    FOREIGN KEY (`persona_direccionid`)
    REFERENCES `db_UBAM`.`tbl_ope_direccion` (`direccionid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `persona_contacto`
    FOREIGN KEY (`persona_contactoid`)
    REFERENCES `db_UBAM`.`tbl_ope_contacto` (`contactoid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_UBAM`.`tbl_ope_alumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_UBAM`.`tbl_ope_alumno` (
  `alumnoid` INT NOT NULL AUTO_INCREMENT,
  `alumno_personaid` INT NULL,
  `alumno_grupoid` INT NULL,
  `alumno_activo` INT NULL,
  PRIMARY KEY (`alumnoid`),
  INDEX `alumno_persona_idx` (`alumno_personaid` ASC) VISIBLE,
  INDEX `alumno_grupo_idx` (`alumno_grupoid` ASC) VISIBLE,
  CONSTRAINT `alumno_persona`
    FOREIGN KEY (`alumno_personaid`)
    REFERENCES `db_UBAM`.`tbl_ope_persona` (`personaid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `alumno_grupo`
    FOREIGN KEY (`alumno_grupoid`)
    REFERENCES `db_UBAM`.`tbl_cat_grupo` (`grupoid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_UBAM`.`tbl_ope_materia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_UBAM`.`tbl_ope_materia` (
  `materiaid` INT NOT NULL AUTO_INCREMENT,
  `materia_materia` VARCHAR(45) NULL,
  `materia_activo` INT NULL,
  PRIMARY KEY (`materiaid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_UBAM`.`tbl_rel_materiagrupo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_UBAM`.`tbl_rel_materiagrupo` (
  `materiagrupoid` INT NOT NULL AUTO_INCREMENT,
  `materiagrupo_materiaid` INT NULL,
  `materiagrupo_grupoid` INT NULL,
  PRIMARY KEY (`materiagrupoid`),
  INDEX `materiagrupo_materia_idx` (`materiagrupo_materiaid` ASC) VISIBLE,
  INDEX `materiagrupo_grupo_idx` (`materiagrupo_grupoid` ASC) VISIBLE,
  CONSTRAINT `materiagrupo_materia`
    FOREIGN KEY (`materiagrupo_materiaid`)
    REFERENCES `db_UBAM`.`tbl_ope_materia` (`materiaid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `materiagrupo_grupo`
    FOREIGN KEY (`materiagrupo_grupoid`)
    REFERENCES `db_UBAM`.`tbl_cat_grupo` (`grupoid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
