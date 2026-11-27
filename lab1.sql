-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `nickname` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `registration_date` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`publisher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`publisher` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`game`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`game` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `release_date` DATETIME NOT NULL,
  `price` INT UNSIGNED NULL,
  `is_available` TINYINT UNSIGNED NOT NULL,
  `publisher_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_game_publisher1_idx` (`publisher_id` ASC) VISIBLE,
  CONSTRAINT `fk_game_publisher1`
    FOREIGN KEY (`publisher_id`)
    REFERENCES `mydb`.`publisher` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`achievement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`achievement` (
  `achievement_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  `game_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`achievement_id`),
  CONSTRAINT `fk_achievement_game1`
    FOREIGN KEY (`game_id`)
    REFERENCES `mydb`.`game` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`requirements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`requirements` (
  `gpu` VARCHAR(45) NULL,
  `cpu` VARCHAR(45) NULL,
  `ram` VARCHAR(45) NULL,
  `game_id` INT UNSIGNED NOT NULL,
  INDEX `fk_requirements_game1_idx` (`game_id` ASC) VISIBLE,
  PRIMARY KEY (`game_id`),
  CONSTRAINT `fk_requirements_game1`
    FOREIGN KEY (`game_id`)
    REFERENCES `mydb`.`game` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`screenshot`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`screenshot` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `content` MEDIUMBLOB NOT NULL,
  `game_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_screenshot_game1_idx` (`game_id` ASC) VISIBLE,
  INDEX `fk_screenshot_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_screenshot_game1`
    FOREIGN KEY (`game_id`)
    REFERENCES `mydb`.`game` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_screenshot_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`library`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`library` (
  `game_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `played_minutes` INT UNSIGNED NOT NULL,
  `first_played_at` DATETIME NULL,
  PRIMARY KEY (`game_id`, `user_id`),
  INDEX `fk_library_has_game_game1_idx` (`game_id` ASC) VISIBLE,
  INDEX `fk_library_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_library_has_game_game1`
    FOREIGN KEY (`game_id`)
    REFERENCES `mydb`.`game` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_library_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`completed_achievements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`completed_achievements` (
  `achievement_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`achievement_id`, `user_id`),
  INDEX `fk_completed_achievements_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_completed_achievements_achievement1`
    FOREIGN KEY (`achievement_id`)
    REFERENCES `mydb`.`achievement` (`achievement_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_completed_achievements_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`game_sesion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`game_sesion` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `started_at` DATETIME NOT NULL,
  `ended_at` DATETIME NULL,
  `game_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  INDEX `fk_game_sesion_game1_idx` (`game_id` ASC) VISIBLE,
  INDEX `fk_game_sesion_user1_idx` (`user_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_game_sesion_game1`
    FOREIGN KEY (`game_id`)
    REFERENCES `mydb`.`game` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_game_sesion_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`item` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  `user_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_item_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_item_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


INSERT INTO `mydb`.`user` (`id`, `name`, `nickname`, `email`, `password`, `registration_date`) VALUES
(1, 'Олександр Коваленко', 'alex_kov', 'alex.kov@example.com', 'pass12345', '2024-01-15 10:30:00'),
(2, 'Марія Шевченко', 'masha_sh', 'maria.sh@example.com', 'qwerty987', '2024-02-20 14:15:00'),
(3, 'Дмитро Бондаренко', 'dima_pro', 'dmitro.b@example.com', 'secret2024', '2024-03-10 18:45:00'),
(4, 'Анна Ткаченко', 'anna_tk', 'anna.tk@example.com', 'anna_pass1', '2024-05-05 09:00:00'),
(5, 'Іван Мельник', 'ivan_m', 'ivan.melnyk@example.com', 'melnyk777', '2024-06-12 21:20:00');

INSERT INTO `mydb`.`publisher` (`id`, `name`) VALUES
(1, 'GSC Game World'),
(2, 'CD Projekt Red'),
(3, 'Valve'),
(4, 'Frogwares'),
(5, '4A Games');

INSERT INTO `mydb`.`game` (`id`, `name`, `release_date`, `price`, `is_available`, `publisher_id`) VALUES
(1, 'S.T.A.L.K.E.R. 2', '2024-11-20 00:00:00', 1399, 1, 1),
(2, 'The Witcher 3', '2015-05-19 00:00:00', 729, 1, 2),
(3, 'Counter-Strike 2', '2023-09-27 00:00:00', 0, 1, 3),
(4, 'Sherlock Holmes: The Awakened', '2023-04-11 00:00:00', 899, 1, 4),
(5, 'Metro Exodus', '2019-02-15 00:00:00', 675, 1, 5);

INSERT INTO `mydb`.`achievement` (`achievement_id`, `name`, `description`, `game_id`) VALUES
(1, 'Перший крок у Зону', 'Увійдіть у Зону вперше', 1),
(2, 'Мисливець на чудовиськ', 'Виконайте 10 замовлень', 2),
(3, 'Ейс', 'Знищіть всю команду ворога за раунд', 3),
(4, 'Майстер дедукції', 'Розкрийте першу справу без підказок', 4),
(5, 'Визволитель', 'Пройдіть гру з хорошою кінцівкою', 5);

INSERT INTO `mydb`.`requirements` (`gpu`, `cpu`, `ram`, `game_id`) VALUES
('RTX 3070', 'Intel Core i7-11700', '16 GB', 1),
('GTX 1060', 'Intel Core i5-7400', '8 GB', 2),
('GTX 1050 Ti', 'Intel Core i5-7500', '8 GB', 3),
('GTX 1660', 'Intel Core i5-8400', '12 GB', 4),
('RTX 2060', 'Intel Core i7-8700', '16 GB', 5);

INSERT INTO `mydb`.`screenshot` (`id`, `name`, `content`, `game_id`, `user_id`) VALUES
(1, 'Припять на світанку', 0x89504E470D0A1A0A, 1, 1),
(2, 'Захід сонця у Велені', 0x89504E470D0A1A0B, 2, 2),
(3, 'Перемога на Mirage', 0x89504E470D0A1A0C, 3, 3),
(4, 'Бейкер-стріт вночі', 0x89504E470D0A1A0D, 4, 4),
(5, 'Потяг Аврора в пустелі', 0x89504E470D0A1A0E, 5, 5);

INSERT INTO `mydb`.`library` (`game_id`, `user_id`, `played_minutes`, `first_played_at`) VALUES
(1, 1, 1250, '2024-11-20 18:00:00'),
(2, 2, 4320, '2024-03-01 12:00:00'),
(3, 3, 9800, '2024-03-11 19:30:00'),
(4, 4, 640, '2024-05-10 15:10:00'),
(5, 5, 1890, '2024-06-15 20:00:00');

INSERT INTO `mydb`.`completed_achievements` (`achievement_id`, `user_id`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO `mydb`.`game_sesion` (`id`, `started_at`, `ended_at`, `game_id`, `user_id`) VALUES
(1, '2024-11-21 18:00:00', '2024-11-21 21:30:00', 1, 1),
(2, '2024-04-02 14:00:00', '2024-04-02 17:45:00', 2, 2),
(3, '2024-04-15 20:00:00', '2024-04-15 23:10:00', 3, 3),
(4, '2024-05-12 16:00:00', '2024-05-12 18:20:00', 4, 4),
(5, '2024-06-20 19:00:00', '2024-06-20 22:00:00', 5, 5);

INSERT INTO `mydb`.`item` (`id`, `name`, `description`, `user_id`) VALUES
(1, 'Артефакт Компас', 'Рідкісний артефакт із Зони', 1),
(2, 'Срібний меч Арондит', 'Легендарний меч відьмака', 2),
(3, 'AK-47 | Азімов', 'Скін на штурмову гвинтівку', 3),
(4, 'Лупа Шерлока', 'Інструмент для пошуку доказів', 4),
(5, 'Протигаз спартанця', 'Захист від радіації', 5);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
