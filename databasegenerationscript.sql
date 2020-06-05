-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema fitnesstrackerdb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema fitnesstrackerdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fitnesstrackerdb` DEFAULT CHARACTER SET utf8 ;
USE `fitnesstrackerdb` ;

-- -----------------------------------------------------
-- Table `fitnesstrackerdb`.`trainer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitnesstrackerdb`.`trainer` (
  `trainer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(255) NOT NULL,
  `last_name` VARCHAR(255) NOT NULL,
  `phone_number` VARCHAR(10) NOT NULL,
  `email` VARCHAR(400) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`trainer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitnesstrackerdb`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitnesstrackerdb`.`client` (
  `client_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(255) NOT NULL,
  `last_name` VARCHAR(255) NOT NULL,
  `phone_number` VARCHAR(10) NOT NULL,
  `email` VARCHAR(400) NOT NULL,
  `trainer_id` INT NULL,
  `emergency_phone` VARCHAR(10) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`client_id`),
  INDEX `fk_client_trainer_idx` (`trainer_id` ASC) VISIBLE,
  CONSTRAINT `fk_client_trainer`
    FOREIGN KEY (`trainer_id`)
    REFERENCES `fitnesstrackerdb`.`trainer` (`trainer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitnesstrackerdb`.`exercise_strength_training`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitnesstrackerdb`.`exercise_strength_training` (
  `exercise_strength_training_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `primary_muscle_groups` VARCHAR(255) NOT NULL,
  `secondary_muscle_groups` VARCHAR(255) NULL,
  PRIMARY KEY (`exercise_strength_training_id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitnesstrackerdb`.`exercise_cardio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitnesstrackerdb`.`exercise_cardio` (
  `exercise_cardio_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `primary_muscle_groups` VARCHAR(255) NOT NULL,
  `secondary_muscle_groups` VARCHAR(255) NULL,
  PRIMARY KEY (`exercise_cardio_id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitnesstrackerdb`.`client_strength_training`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitnesstrackerdb`.`client_strength_training` (
  `client_strength_training_id` INT NOT NULL AUTO_INCREMENT,
  `client_id` INT NOT NULL,
  `exercise_strength_training_id` INT NOT NULL,
  `weight` INT NOT NULL,
  `reps` INT NOT NULL,
  `sets` INT NOT NULL,
  `trainer_id` INT NOT NULL,
  `notes` LONGTEXT NULL,
  `completed` TINYINT NULL,
  PRIMARY KEY (`client_strength_training_id`),
  INDEX `fk_clientStrengthTraining_idx` (`client_id` ASC) VISIBLE,
  INDEX `fk_exerciseStrengthTraining_idx` (`exercise_strength_training_id` ASC) VISIBLE,
  INDEX `fk_strengthTraining_trainer_idx` (`trainer_id` ASC) VISIBLE,
  CONSTRAINT `fk_clientStrengthTraining`
    FOREIGN KEY (`client_id`)
    REFERENCES `fitnesstrackerdb`.`client` (`client_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_exerciseStrengthTraining`
    FOREIGN KEY (`exercise_strength_training_id`)
    REFERENCES `fitnesstrackerdb`.`exercise_strength_training` (`exercise_strength_training_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_strengthTraining_trainer`
    FOREIGN KEY (`trainer_id`)
    REFERENCES `fitnesstrackerdb`.`trainer` (`trainer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitnesstrackerdb`.`client_cardio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitnesstrackerdb`.`client_cardio` (
  `client_cardio_id` INT NOT NULL AUTO_INCREMENT,
  `client_id` INT NOT NULL,
  `exercise_cardio_id` INT NOT NULL,
  `trainer_id` INT NULL,
  `distance` INT NULL,
  `duration` TIME NULL,
  `calories_burnt` INT NULL,
  `completed` TINYINT NULL,
  `notes` LONGTEXT NULL,
  `time_started` TIME NULL,
  `time_ended` TIME NULL,
  PRIMARY KEY (`client_cardio_id`),
  INDEX `fk_clientCardio_idx` (`client_id` ASC) VISIBLE,
  INDEX `fk_exerciseCardio_idx` (`exercise_cardio_id` ASC) VISIBLE,
  INDEX `fk_cardioTrainer_idx` (`trainer_id` ASC) VISIBLE,
  CONSTRAINT `fk_clientCardio`
    FOREIGN KEY (`client_id`)
    REFERENCES `fitnesstrackerdb`.`client` (`client_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_exerciseCardio`
    FOREIGN KEY (`exercise_cardio_id`)
    REFERENCES `fitnesstrackerdb`.`exercise_cardio` (`exercise_cardio_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cardioTrainer`
    FOREIGN KEY (`trainer_id`)
    REFERENCES `fitnesstrackerdb`.`trainer` (`trainer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitnesstrackerdb`.`client_physical_attributes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitnesstrackerdb`.`client_physical_attributes` (
  `physical_attributes_id` INT NOT NULL AUTO_INCREMENT,
  `height` INT NOT NULL,
  `weight` INT NOT NULL,
  `age` INT NOT NULL,
  `gender` VARCHAR(25) NOT NULL,
  `last_updated` TIMESTAMP NOT NULL,
  `client_id` INT NOT NULL,
  `trainer_id` INT NOT NULL,
  PRIMARY KEY (`physical_attributes_id`),
  INDEX `fk_physicalAttributes_client_idx` (`client_id` ASC) VISIBLE,
  INDEX `fk_physicalAttributes_trainer_idx` (`trainer_id` ASC) VISIBLE,
  CONSTRAINT `fk_physicalAttributes_client`
    FOREIGN KEY (`client_id`)
    REFERENCES `fitnesstrackerdb`.`client` (`client_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_physicalAttributes_trainer`
    FOREIGN KEY (`trainer_id`)
    REFERENCES `fitnesstrackerdb`.`trainer` (`trainer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fitnesstrackerdb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fitnesstrackerdb`.`user` (
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
