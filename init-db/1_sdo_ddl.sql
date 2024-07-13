-- MySQL Script generated by MySQL Workbench
-- Tue Nov 21 20:42:02 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema sdo_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `sdo_db` ;

-- -----------------------------------------------------
-- Schema sdo_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sdo_db` DEFAULT CHARACTER SET utf8 ;
USE `sdo_db` ;

-- -----------------------------------------------------
-- Table `sdo_db`.`Centre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sdo_db`.`Centre` ;

CREATE TABLE IF NOT EXISTS `sdo_db`.`Centre` (
  `ct_id` INT NOT NULL AUTO_INCREMENT,
  `ct_name` VARCHAR(100) NOT NULL,
  `ct_address` VARCHAR(150) NOT NULL,
  `ct_country` VARCHAR(150) NOT NULL,
  `ct_city` VARCHAR(150) NOT NULL,
  `ct_zip_code` VARCHAR(50) NOT NULL,
  `ct_nb_ambulance` INT NULL,
  PRIMARY KEY (`ct_id`),
  UNIQUE INDEX `idCentre_UNIQUE` (`ct_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sdo_db`.`Patient_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sdo_db`.`Patient_Type` ;

CREATE TABLE IF NOT EXISTS `sdo_db`.`Patient_Type` (
  `ptt_id` INT NOT NULL AUTO_INCREMENT,
  `ptt_name` SET('GIVERS', 'RECEIVERS') NOT NULL DEFAULT 'GIVERS',
  `ptt_desc` TEXT NULL,
  PRIMARY KEY (`ptt_id`),
  UNIQUE INDEX `ptt_id_UNIQUE` (`ptt_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sdo_db`.`Blood_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sdo_db`.`Blood_Type` ;

CREATE TABLE IF NOT EXISTS `sdo_db`.`Blood_Type` (
  `bt_id` INT NOT NULL AUTO_INCREMENT,
  `bt_blood` VARCHAR(10) NOT NULL,
  `bt_rhesus` VARCHAR(45) NOT NULL,
  `bt_phenotype` VARCHAR(45) NOT NULL,
  `bt_kell` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`bt_id`),
  UNIQUE INDEX `gs_id_UNIQUE` (`bt_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sdo_db`.`Patient_Status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sdo_db`.`Patient_Status` ;

CREATE TABLE IF NOT EXISTS `sdo_db`.`Patient_Status` (
  `ps_id` INT NOT NULL AUTO_INCREMENT,
  `ps_name` SET('NEW', 'PENDING', 'TRANSPLANT FINDED', 'OP. ON GOING', 'OP. DONE') NOT NULL DEFAULT 'NEW',
  `ps_desc` TEXT NULL,
  PRIMARY KEY (`ps_id`),
  UNIQUE INDEX `ps_id_UNIQUE` (`ps_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sdo_db`.`Patient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sdo_db`.`Patient` ;

CREATE TABLE IF NOT EXISTS `sdo_db`.`Patient` (
  `pt_id` INT NOT NULL AUTO_INCREMENT,
  `pt_ptt_id` INT NOT NULL,
  `pt_bt_id` INT  NOT NULL,
  `pt_ps_id` INT NOT NULL,
  `pt_name` VARCHAR(100) NOT NULL,
  `pt_firstname` VARCHAR(150) NOT NULL,
  `pt_address` VARCHAR(100) NULL,
  `pt_city` VARCHAR(100) NULL,
  `pt_country` VARCHAR(150) NULL,
  `pt_zip_code` VARCHAR(50) NULL,
  `pt_weight` INT NOT NULL,
  `pt_height` INT NOT NULL,
  `pt_weight_unit` VARCHAR(5) NULL,
  `pt_height_unit` VARCHAR(5) NULL,
  `pt_birthdate` DATE NOT NULL,
  `pt_birth_country` VARCHAR(150) NOT NULL,
  `pt_birth_city` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`pt_id`),
  UNIQUE INDEX `patient_id_UNIQUE` (`pt_id` ASC) VISIBLE,
  INDEX `fk_Patient_Patient_Type1_idx` (`pt_ptt_id` ASC) VISIBLE,
  INDEX `fk_Patient_Blood_Type1_idx` (`pt_bt_id` ASC) VISIBLE,
  INDEX `fk_Patient_Patient_Status1_idx` (`pt_ps_id` ASC) VISIBLE,
  CONSTRAINT `fk_Patient_Patient_Type1`
    FOREIGN KEY (`pt_ptt_id`)
    REFERENCES `sdo_db`.`Patient_Type` (`ptt_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Patient_Blood_Type1`
    FOREIGN KEY (`pt_bt_id`)
    REFERENCES `sdo_db`.`Blood_Type` (`bt_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Patient_Patient_Status1`
    FOREIGN KEY (`pt_ps_id`)
    REFERENCES `sdo_db`.`Patient_Status` (`ps_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sdo_db`.`Transplant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sdo_db`.`Transplant` ;

CREATE TABLE IF NOT EXISTS `sdo_db`.`Transplant` (
  `tr_id` INT NOT NULL AUTO_INCREMENT,
  `tr_type` VARCHAR(150) NOT NULL,
  `tr_desc` TEXT NULL DEFAULT NOW(),
  `tr_duration` INT NOT NULL,
  `tr_duration_unit` VARCHAR(10) NULL,
  PRIMARY KEY (`tr_id`),
  UNIQUE INDEX `organe_id_UNIQUE` (`tr_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sdo_db`.`Illness`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sdo_db`.`Illness` ;

CREATE TABLE IF NOT EXISTS `sdo_db`.`Illness` (
  `ill_id` INT NOT NULL AUTO_INCREMENT,
  `ill_pt_id` INT NOT NULL,
  `ill_name` VARCHAR(500) NOT NULL,
  `ill_date_start` DATETIME NULL,
  `ill_date_end` DATETIME NULL,
  `ill_specialist` VARCHAR(100) NULL,
  `ill_comment` TEXT NULL,
  `ill_country` VARCHAR(150) NOT NULL,
  `ill_city` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`ill_id`),
  UNIQUE INDEX `Ill_id_UNIQUE` (`ill_id` ASC) VISIBLE,
  INDEX `fk_Illness_Patient1_idx` (`ill_pt_id` ASC) VISIBLE,
  CONSTRAINT `fk_Illness_Patient1`
    FOREIGN KEY (`ill_pt_id`)
    REFERENCES `sdo_db`.`Patient` (`pt_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sdo_db`.`Presription`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sdo_db`.`Presription` ;

CREATE TABLE IF NOT EXISTS `sdo_db`.`Presription` (
  `pr_id` INT NOT NULL AUTO_INCREMENT,
  `pr_pt_id` INT NOT NULL,
  `pr_date_start` DATETIME NOT NULL,
  `pr_date_end` DATETIME NULL,
  `pr_treatment` VARCHAR(500) NOT NULL,
  `pr_medicine` VARCHAR(450) NULL,
  `pr_duration` INT NULL,
  `pr_duration_unit` VARCHAR(10) NULL,
  PRIMARY KEY (`pr_id`),
  UNIQUE INDEX `pr_id_UNIQUE` (`pr_id` ASC) VISIBLE,
  INDEX `fk_Presription_Patient_idx` (`pr_pt_id` ASC) VISIBLE,
  CONSTRAINT `fk_Presription_Patient`
    FOREIGN KEY (`pr_pt_id`)
    REFERENCES `sdo_db`.`Patient` (`pt_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sdo_db`.`Giver_Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sdo_db`.`Giver_Type` ;

CREATE TABLE IF NOT EXISTS `sdo_db`.`Giver_Type` (
  `gvt_id` INT NOT NULL AUTO_INCREMENT,
  `gvt_name` SET('ALIVE', 'NOT ALIVE') NOT NULL DEFAULT 'NOT ALIVE',
  `gvt_desc` TEXT NULL,
  PRIMARY KEY (`gvt_id`),
  UNIQUE INDEX `dn_id_UNIQUE` (`gvt_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sdo_db`.`Heliport`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sdo_db`.`Heliport` ;

CREATE TABLE IF NOT EXISTS `sdo_db`.`Heliport` (
  `ht_id` INT NOT NULL AUTO_INCREMENT,
  `ht_ct_id` INT NOT NULL,
  `ht_name` VARCHAR(120) NOT NULL,
  `ht_address` VARCHAR(150) NOT NULL,
  `ht_country` VARCHAR(150) NOT NULL,
  `ht_city` VARCHAR(150) NOT NULL,
  `ht_zip_code` VARCHAR(150) NOT NULL,
  `ht_has_helico` TINYINT NULL,
  PRIMARY KEY (`ht_id`),
  UNIQUE INDEX `ht_id_UNIQUE` (`ht_id` ASC) VISIBLE,
  INDEX `fk_Heliport_Centre1_idx` (`ht_ct_id` ASC) VISIBLE,
  CONSTRAINT `fk_Heliport_Centre1`
    FOREIGN KEY (`ht_ct_id`)
    REFERENCES `sdo_db`.`Centre` (`ct_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sdo_db`.`Givers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sdo_db`.`Givers` ;

CREATE TABLE IF NOT EXISTS `sdo_db`.`Givers` (
  `pdt_pt_id` INT NOT NULL,
  `pdt_dn_id` INT NOT NULL,
  `pdt_date` DATETIME NOT NULL DEFAULT NOW(),
  PRIMARY KEY (`pdt_pt_id`, `pdt_dn_id`),
  INDEX `fk_Patient_has_Donneur_Type_Donneur_Type1_idx` (`pdt_dn_id` ASC) VISIBLE,
  INDEX `fk_Patient_has_Donneur_Type_Patient1_idx` (`pdt_pt_id` ASC) VISIBLE,
  CONSTRAINT `fk_Patient_has_Donneur_Type_Patient1`
    FOREIGN KEY (`pdt_pt_id`)
    REFERENCES `sdo_db`.`Patient` (`pt_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Patient_has_Donneur_Type_Donneur_Type1`
    FOREIGN KEY (`pdt_dn_id`)
    REFERENCES `sdo_db`.`Giver_Type` (`gvt_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sdo_db`.`Operations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sdo_db`.`Operations` ;

CREATE TABLE IF NOT EXISTS `sdo_db`.`Operations` (
  `op_id` INT NOT NULL AUTO_INCREMENT,
  `op_pt_id` INT NOT NULL,
  `op_date_start` DATETIME NOT NULL,
  `op_date_end` DATETIME NULL,
  `op_desc` TEXT NULL,
  `op_status` SET('OK', 'KO') NOT NULL DEFAULT 'OK',
  PRIMARY KEY (`op_id`),
  INDEX `fk_Patient_has_Operation_Status_Patient1_idx` (`op_pt_id` ASC) VISIBLE,
  UNIQUE INDEX `op_id_UNIQUE` (`op_id` ASC) VISIBLE,
  CONSTRAINT `fk_Patient_has_Operation_Status_Patient1`
    FOREIGN KEY (`op_pt_id`)
    REFERENCES `sdo_db`.`Patient` (`pt_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sdo_db`.`Give`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sdo_db`.`Give` ;

CREATE TABLE IF NOT EXISTS `sdo_db`.`Give` (
  `gv_id` INT NOT NULL AUTO_INCREMENT,
  `gv_pt_id` INT NOT NULL,
  `gv_tr_id` INT NOT NULL,
  `gv_date` DATETIME NOT NULL DEFAULT NOW(),
  `gv_date_expiration` DATETIME NOT NULL,
  `gv_comment` TEXT NULL,
  PRIMARY KEY (`gv_id`),
  INDEX `fk_Give_Transplant1_idx` (`gv_tr_id` ASC) VISIBLE,
  INDEX `fk_Give_Patient1_idx` (`gv_pt_id` ASC) VISIBLE,
  UNIQUE INDEX `gv_id_UNIQUE` (`gv_id` ASC) VISIBLE,
  CONSTRAINT `fk_Give_Patient1`
    FOREIGN KEY (`gv_pt_id`)
    REFERENCES `sdo_db`.`Patient` (`pt_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Give_Transplant1`
    FOREIGN KEY (`gv_tr_id`)
    REFERENCES `sdo_db`.`Transplant` (`tr_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sdo_db`.`Transfert`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sdo_db`.`Transfert` ;

CREATE TABLE IF NOT EXISTS `sdo_db`.`Transfert` (
  `tf_id` INT NOT NULL AUTO_INCREMENT,
  `tf_ct_id` INT NOT NULL,
  `tf_pt_id` INT NULL,
  `tf_gv_id` INT NULL,
  `tf_date_departure` DATETIME NOT NULL DEFAULT NOW(),
  `tf_date_arrival` DATETIME NULL,
  PRIMARY KEY (`tf_id`),
  INDEX `fk_Centre_has_Patient_Patient1_idx` (`tf_pt_id` ASC) VISIBLE,
  INDEX `fk_Centre_has_Patient_Centre1_idx` (`tf_ct_id` ASC) VISIBLE,
  INDEX `fk_Transfert_Give_idx` (`tf_gv_id` ASC) VISIBLE,
  UNIQUE INDEX `tf_id_UNIQUE` (`tf_id` ASC) VISIBLE,
  CONSTRAINT `fk_Centre_has_Patient_Centre1`
    FOREIGN KEY (`tf_ct_id`)
    REFERENCES `sdo_db`.`Centre` (`ct_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Centre_has_Patient_Patient1`
    FOREIGN KEY (`tf_pt_id`)
    REFERENCES `sdo_db`.`Patient` (`pt_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transfert_Give`
    FOREIGN KEY (`tf_gv_id`)
    REFERENCES `sdo_db`.`Give` (`gv_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sdo_db`.`Receive`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sdo_db`.`Receive` ;

CREATE TABLE IF NOT EXISTS `sdo_db`.`Receive` (
  `rv_id` INT NOT NULL AUTO_INCREMENT,
  `rv_pt_id` INT NOT NULL,
  `rv_gv_id` INT NOT NULL,
  `rv_date` DATETIME NOT NULL DEFAULT NOW(),
  `rv_comment` TEXT NULL,
  PRIMARY KEY (`rv_id`),
  INDEX `fk_Receive_Give2_idx` (`rv_gv_id` ASC) VISIBLE,
  INDEX `fk_Receive_Patient2_idx` (`rv_pt_id` ASC) VISIBLE,
  UNIQUE INDEX `rv_id_UNIQUE` (`rv_id` ASC) VISIBLE,
  CONSTRAINT `fk_Receive_Patient2`
    FOREIGN KEY (`rv_pt_id`)
    REFERENCES `sdo_db`.`Patient` (`pt_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Receive_Give2`
    FOREIGN KEY (`rv_gv_id`)
    REFERENCES `sdo_db`.`Give` (`gv_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sdo_db`.`Losses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sdo_db`.`Losses` ;

CREATE TABLE IF NOT EXISTS `sdo_db`.`Losses` (
  `lo_id` INT NOT NULL AUTO_INCREMENT,
  `lo_ct_id` INT NOT NULL,
  `lo_gv_id` INT NULL,
  `lo_pt_id` INT NULL,
  `lo_saved_date` DATETIME NOT NULL,
  `lo_comment` TEXT NULL,
  PRIMARY KEY (`lo_id`),
  UNIQUE INDEX `lo_id_UNIQUE` (`lo_id` ASC) VISIBLE,
  INDEX `fk_Losses_Give1_idx` (`lo_gv_id` ASC) VISIBLE,
  INDEX `fk_Losses_Patient1_idx` (`lo_pt_id` ASC) VISIBLE,
  INDEX `fk_Losses_Centre1_idx` (`lo_ct_id` ASC) VISIBLE,
  CONSTRAINT `fk_Losses_Give1`
    FOREIGN KEY (`lo_gv_id`)
    REFERENCES `sdo_db`.`Give` (`gv_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Losses_Patient1`
    FOREIGN KEY (`lo_pt_id`)
    REFERENCES `sdo_db`.`Patient` (`pt_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Losses_Centre1`
    FOREIGN KEY (`lo_ct_id`)
    REFERENCES `sdo_db`.`Centre` (`ct_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sdo_db`.`Needs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sdo_db`.`Needs` ;

CREATE TABLE IF NOT EXISTS `sdo_db`.`Needs` (
  `nd_id` INT NOT NULL AUTO_INCREMENT,  
  `nd_tr_id` INT NOT NULL,
  `nd_pt_id` INT NOT NULL,
  `nd_date` DATETIME NOT NULL DEFAULT NOW(),
  PRIMARY KEY (`nd_id`),
  UNIQUE INDEX `nd_id_UNIQUE`(`nd_id` ASC) VISIBLE,
  INDEX `fk_Needs_Patient1_idx` (`nd_pt_id` ASC) VISIBLE,
  INDEX `fk_Needs_Transplant1_idx` (`nd_tr_id` ASC) VISIBLE,
  CONSTRAINT `fk_Needs_Transplant1`
    FOREIGN KEY (`nd_tr_id`)
    REFERENCES `sdo_db`.`Transplant` (`tr_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Needs_Patient1`
    FOREIGN KEY (`nd_pt_id`)
    REFERENCES `sdo_db`.`Patient` (`pt_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;