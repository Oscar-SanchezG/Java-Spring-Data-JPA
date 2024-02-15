-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `pizzeria` ;

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`pizza`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`pizza` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`pizza` (
  `id_pizza` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `description` VARCHAR(150) NOT NULL,
  `price` DECIMAL(5,2) NOT NULL,
  `vegetarian` TINYINT NULL,
  `vegan` TINYINT NULL,
  `available` TINYINT NOT NULL,
  PRIMARY KEY (`id_pizza`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`customer` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`customer` (
  `id_customer` VARCHAR(15) NOT NULL,
  `name` VARCHAR(60) NOT NULL,
  `address` VARCHAR(100) NULL,
  `email` VARCHAR(50) NOT NULL,
  `phone_number` VARCHAR(20) NULL,
  PRIMARY KEY (`id_customer`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pizza_order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`pizza_order` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`pizza_order` (
  `id_order` INT NOT NULL AUTO_INCREMENT,
  `id_customer` VARCHAR(15) NOT NULL,
  `date` DATETIME NOT NULL,
  `total` DECIMAL(6,2) NOT NULL,
  `method` CHAR(1) NOT NULL COMMENT 'D = delivery\nS = on site\nC = carryout',
  `additional_notes` VARCHAR(200) NULL,
  PRIMARY KEY (`id_order`),
  INDEX `fk_ORDER_CUSTOMER1_idx` (`id_customer` ASC) VISIBLE,
  CONSTRAINT `fk_ORDER_CUSTOMER1`
    FOREIGN KEY (`id_customer`)
    REFERENCES `pizzeria`.`customer` (`id_customer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`order_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`order_item` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`order_item` (
  `id_item` INT NOT NULL AUTO_INCREMENT,
  `id_order` INT NOT NULL,
  `id_pizza` INT NOT NULL,
  `quantity` DECIMAL(2,1) NOT NULL,
  `price` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`id_item`, `id_order`),
  INDEX `fk_ORDER_ITEM_ORDER_idx` (`id_order` ASC) VISIBLE,
  INDEX `fk_ORDER_ITEM_PIZZA1_idx` (`id_pizza` ASC) VISIBLE,
  CONSTRAINT `fk_ORDER_ITEM_ORDER`
    FOREIGN KEY (`id_order`)
    REFERENCES `pizzeria`.`pizza_order` (`id_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ORDER_ITEM_PIZZA1`
    FOREIGN KEY (`id_pizza`)
    REFERENCES `pizzeria`.`pizza` (`id_pizza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`user` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`user` (
  `username` VARCHAR(20) NOT NULL,
  `password` VARCHAR(200) NOT NULL,
  `email` VARCHAR(50) NULL,
  `locked` TINYINT NOT NULL,
  `disabled` TINYINT NOT NULL,
  PRIMARY KEY (`username`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`user_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`user_role` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`user_role` (
  `username` VARCHAR(20) NOT NULL,
  `role` VARCHAR(20) NOT NULL COMMENT 'CUSTOMER\nADMIN',
  `granted_date` DATETIME NOT NULL,
  PRIMARY KEY (`username`, `role`),
  CONSTRAINT `fk_user_role_user1`
    FOREIGN KEY (`username`)
    REFERENCES `pizzeria`.`user` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
