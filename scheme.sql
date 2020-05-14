-- MySQL Script generated by MySQL Workbench
-- Thu May 14 16:11:36 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema taskforce
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema taskforce
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `taskforce` DEFAULT CHARACTER SET utf8 ;
USE `taskforce` ;

-- -----------------------------------------------------
-- Table `taskforce`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taskforce`.`category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `icon` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`title` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taskforce`.`cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taskforce`.`cities` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(255) NOT NULL,
  `latitude` DECIMAL(10,7) NULL,
  `longitude` DECIMAL(10,7) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taskforce`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taskforce`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `registered_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_user_cities1_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_cities1`
    FOREIGN KEY (`city_id`)
    REFERENCES `taskforce`.`cities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taskforce`.`task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taskforce`.`task` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category_id` INT NOT NULL,
  `city_id` INT NULL,
  `title` VARCHAR(255) NOT NULL,
  `customer_id` INT NOT NULL,
  `executor_id` INT NULL,
  `description` LONGTEXT NULL DEFAULT NULL,
  `address` VARCHAR(255) NULL DEFAULT NULL,
  `budget` INT NULL DEFAULT NULL,
  `deadline` TIMESTAMP NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `status` VARCHAR(45) NOT NULL,
  `latitude` DECIMAL(10,7) NULL,
  `longitude` DECIMAL(10,7) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_task_category1_idx` (`category_id` ASC) VISIBLE,
  INDEX `fk_task_cities1_idx` (`city_id` ASC) VISIBLE,
  INDEX `fk_task_user1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_task_user2_idx` (`executor_id` ASC) VISIBLE,
  CONSTRAINT `fk_task_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `taskforce`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_task_cities1`
    FOREIGN KEY (`city_id`)
    REFERENCES `taskforce`.`cities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_task_user1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `taskforce`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_task_user2`
    FOREIGN KEY (`executor_id`)
    REFERENCES `taskforce`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taskforce`.`chat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taskforce`.`chat` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `task_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_chat_task1_idx` (`task_id` ASC) VISIBLE,
  CONSTRAINT `fk_chat_task1`
    FOREIGN KEY (`task_id`)
    REFERENCES `taskforce`.`task` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taskforce`.`chat_message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taskforce`.`chat_message` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `chat_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `message` LONGTEXT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_chat_message_chat1_idx` (`chat_id` ASC) VISIBLE,
  INDEX `fk_chat_message_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_chat_message_chat1`
    FOREIGN KEY (`chat_id`)
    REFERENCES `taskforce`.`chat` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_chat_message_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `taskforce`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taskforce`.`task_review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taskforce`.`task_review` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `task_id` INT NOT NULL,
  `executor_id` INT NOT NULL,
  `message` MEDIUMTEXT NULL DEFAULT NULL,
  `rate` INT NOT NULL,
  `created_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_task_review_task1_idx` (`task_id` ASC) VISIBLE,
  INDEX `fk_task_review_user1_idx` (`executor_id` ASC) VISIBLE,
  CONSTRAINT `fk_task_review_task1`
    FOREIGN KEY (`task_id`)
    REFERENCES `taskforce`.`task` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_task_review_user1`
    FOREIGN KEY (`executor_id`)
    REFERENCES `taskforce`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taskforce`.`user_information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taskforce`.`user_information` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `birthday` TIMESTAMP NULL DEFAULT NULL,
  `about` MEDIUMTEXT NULL DEFAULT NULL,
  `skype` VARCHAR(45) NULL DEFAULT NULL,
  `telegram` VARCHAR(45) NULL DEFAULT NULL,
  `phone_number` VARCHAR(45) NULL DEFAULT NULL,
  `avatar` VARCHAR(255) NULL DEFAULT NULL,
  `address` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_information_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_information_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `taskforce`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taskforce`.`user_specialization`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taskforce`.`user_specialization` (
  `user_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `category_id`),
  INDEX `fk_user_specialization_user_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_user_specialization_category1_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_specialization_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `taskforce`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_specialization_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `taskforce`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taskforce`.`user_settings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taskforce`.`user_settings` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `notification_task` INT NULL DEFAULT 1,
  `notification_action` INT NULL DEFAULT 1,
  `notification_new_review` INT NULL DEFAULT 1,
  `profile_hidden` INT NULL DEFAULT NULL,
  `contacts_hidden` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_notifications_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_notifications_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `taskforce`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `taskforce`.`user_tasksdone_photo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taskforce`.`user_tasksdone_photo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `link` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_tasksdone_photo_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_tasksdone_photo_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `taskforce`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `taskforce`.`user_favorites`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taskforce`.`user_favorites` (
  `user_id` INT NOT NULL,
  `favorite_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `favorite_id`),
  INDEX `fk_user_favorites_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_user_favorites_user2_idx` (`favorite_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_favorites_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `taskforce`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_favorites_user2`
    FOREIGN KEY (`favorite_id`)
    REFERENCES `taskforce`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `taskforce`.`task_files`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taskforce`.`task_files` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `task_id` INT NOT NULL,
  `link` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_task_files_task1_idx` (`task_id` ASC) VISIBLE,
  CONSTRAINT `fk_task_files_task1`
    FOREIGN KEY (`task_id`)
    REFERENCES `taskforce`.`task` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `taskforce`.`task_response`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taskforce`.`task_response` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `task_id` INT NOT NULL,
  `responded_user_id` INT NOT NULL,
  `message` MEDIUMTEXT NULL DEFAULT NULL,
  `responded_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_task_response_task1_idx` (`task_id` ASC) VISIBLE,
  INDEX `fk_task_response_user1_idx` (`responded_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_task_response_task1`
    FOREIGN KEY (`task_id`)
    REFERENCES `taskforce`.`task` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_task_response_user1`
    FOREIGN KEY (`responded_user_id`)
    REFERENCES `taskforce`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
