-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb`;
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

DROP TABLE IF EXISTS `mydb`.`item`;
DROP TABLE IF EXISTS `mydb`.`game_sesion`;
DROP TABLE IF EXISTS `mydb`.`completed_achievements`;
DROP TABLE IF EXISTS `mydb`.`library`;
DROP TABLE IF EXISTS `mydb`.`screenshot`;
DROP TABLE IF EXISTS `mydb`.`requirements`;
DROP TABLE IF EXISTS `mydb`.`achievement`;
DROP TABLE IF EXISTS `mydb`.`game`;
DROP TABLE IF EXISTS `mydb`.`publisher`;
DROP TABLE IF EXISTS `mydb`.`user`;

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
  INDEX `fk_achievement_game1_idx` (`game_id` ASC) VISIBLE,
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

CREATE INDEX `idx_library_game_played` ON `mydb`.`library` (`game_id`, `played_minutes`);

CREATE INDEX `idx_library_user_played` ON `mydb`.`library` (`user_id`, `played_minutes`);

CREATE INDEX `idx_sesion_ended_at` ON `mydb`.`game_sesion` (`ended_at`);

INSERT INTO `mydb`.`user` (`id`, `name`, `nickname`, `email`, `password`, `registration_date`) VALUES
(1, 'Олександр Петренко', 'alex_pro', 'alex@gmail.com', 'pass123', '2025-01-10 12:00:00'),
(2, 'Марія Коваленко', 'mary_k', 'mary@gmail.com', 'pass123', '2025-01-15 14:30:00'),
(3, 'John Smith', 'john_s', 'john@yahoo.com', 'pass123', '2025-02-01 09:15:00'),
(4, 'Emma Watson', 'emma_w', 'emma@outlook.com', 'pass123', '2025-02-10 18:20:00'),
(5, 'Максим Шевченко', 'max_shev', 'max@gmail.com', 'pass123', '2025-02-20 11:00:00'),
(6, 'Anna Müller', 'anna_m', 'anna@gmx.de', 'pass123', '2025-03-01 16:45:00'),
(7, 'Андрій Бойко', 'andriy_b', 'andriy@gmail.com', 'pass123', '2025-03-05 08:30:00'),
(8, 'Carlos Santana', 'carlos_s', 'carlos@gmail.com', 'pass123', '2025-03-12 21:10:00'),
(9, 'Софія Мельник', 'sophie_m', 'sophie@gmail.com', 'pass123', '2025-03-15 13:00:00'),
(10, 'Kenji Sato', 'kenji_s', 'kenji@yahoo.jp', 'pass123', '2025-03-18 19:00:00');

INSERT INTO `mydb`.`publisher` (`id`, `name`) VALUES
(1, 'Valve'),
(2, 'Ubisoft'),
(3, 'Electronic Arts'),
(4, 'CD Projekt Red'),
(5, 'Rockstar Games'),
(6, 'Bethesda'),
(7, 'Square Enix'),
(8, 'Capcom'),
(9, 'Bandai Namco'),
(10, 'Larian Studios');

INSERT INTO `mydb`.`game` (`id`, `name`, `release_date`, `price`, `is_available`, `publisher_id`) VALUES
(1, 'Action Cyberpunk', '2020-12-10 00:00:00', 60, 1, 4),
(2, 'The Witcher 3', '2015-05-19 00:00:00', 40, 1, 4),
(3, 'Action Counter-Strike', '2023-09-27 00:00:00', 0, 1, 1),
(4, 'Assassin Creed Valhalla', '2020-11-10 00:00:00', 50, 1, 2),
(5, 'Action Battlefield', '2021-11-19 00:00:00', 40, 1, 3),
(6, 'Red Dead Redemption 2', '2019-11-05 00:00:00', 60, 1, 5),
(7, 'Skyrim Special Edition', '2016-10-28 00:00:00', 40, 1, 6),
(8, 'Resident Evil 4', '2023-03-24 00:00:00', 40, 1, 8),
(9, 'Elden Ring', '2022-02-25 00:00:00', 60, 1, 9),
(10, 'Baldurs Gate 3', '2023-08-03 00:00:00', 60, 1, 10),
(11, 'Half-Life 2', '2004-11-16 00:00:00', 10, 0, 1),
(12, 'Final Fantasy VII Remake', '2021-12-16 00:00:00', 70, 1, 7);

INSERT INTO `mydb`.`requirements` (`game_id`, `gpu`, `cpu`, `ram`) VALUES
(1, 'RTX 2060', 'i7-6700', '16 GB'),
(2, 'GTX 660', 'i5-2500K', '6 GB'),
(3, 'GTX 1060', 'i5-7500', '8 GB'),
(4, 'RTX 2070', 'i7-8700', '16 GB'),
(5, 'RTX 3060', 'i7-9700K', '32 GB'),
(6, 'GTX 770', 'i7-4770K', '12 GB'),
(7, 'GTX 780', 'i5-2500K', '8 GB'),
(8, 'GTX 1050 Ti', 'Ryzen 5 3600', '16 GB'),
(9, 'GTX 1060', 'i5-8400', '12 GB'),
(10, 'GTX 970', 'i5-4690', '8 GB'),
(11, 'GeForce 7800', 'Pentium 4', '1 GB'),
(12, 'GTX 1080', 'i7-8700', '16 GB');

INSERT INTO `mydb`.`achievement` (`achievement_id`, `name`, `description`, `game_id`) VALUES
(1, 'First Blood', 'Complete the first mission', 1),
(2, 'Night City Legend', 'Finish the main story', 1),
(3, 'Monster Slayer', 'Defeat 100 monsters', 2),
(4, 'Gwent Master', 'Win 20 Gwent matches', 2),
(5, 'Ace', 'Win a round against five enemies', 3),
(6, 'Viking Raider', 'Raid 10 English settlements', 4),
(7, 'Jarl of Ravensthorpe', 'Complete the main story', 4),
(8, 'Conqueror', 'Win 50 matches', 5),
(9, 'Outlaw', 'Complete the first chapter', 6),
(10, 'Dragonborn', 'Absorb a dragon soul', 7),
(11, 'Tarnished', 'Defeat the first boss', 9),
(12, 'Tav Adventurer', 'Finish the first act', 10);

INSERT INTO `mydb`.`library` (`game_id`, `user_id`, `played_minutes`, `first_played_at`) VALUES
(4, 1, 1200, '2025-01-11 15:00:00'),
(4, 2, 1800, '2025-01-16 10:00:00'),
(4, 3, 900, '2025-02-02 12:00:00'),
(4, 5, 1100, '2025-02-21 20:00:00'),
(4, 7, 750, '2025-03-06 14:00:00'),
(1, 1, 2500, '2025-01-12 18:00:00'),
(3, 5, 5000, '2025-02-21 20:00:00'),
(2, 2, 3000, '2025-01-20 19:00:00'),
(2, 4, 2200, '2025-02-12 21:00:00'),
(5, 6, 600, '2025-03-03 17:00:00'),
(6, 8, 4000, '2025-03-14 22:00:00'),
(7, 9, 1500, '2025-03-16 12:00:00'),
(9, 10, 3500, '2025-03-20 20:00:00'),
(10, 3, 2800, '2025-02-05 23:00:00'),
(8, 4, 0, NULL);

INSERT INTO `mydb`.`screenshot` (`id`, `name`, `content`, `game_id`, `user_id`) VALUES
(1, 'night_city_view.jpg', UNHEX('FFD8FFE000104A464946'), 1, 1),
(2, 'valhalla_raid.jpg', UNHEX('FFD8FFE000104A464946'), 4, 1),
(3, 'valhalla_longship.jpg', UNHEX('FFD8FFE000104A464946'), 4, 2),
(4, 'witcher_swamp.jpg', UNHEX('FFD8FFE000104A464946'), 2, 2),
(5, 'cs_dust_final.jpg', UNHEX('FFD8FFE000104A464946'), 3, 5),
(6, 'rdr2_sunset.jpg', UNHEX('FFD8FFE000104A464946'), 6, 8),
(7, 'elden_boss_fight.jpg', UNHEX('FFD8FFE000104A464946'), 9, 10),
(8, 'bg3_party.jpg', UNHEX('FFD8FFE000104A464946'), 10, 3),
(9, 'skyrim_mountains.jpg', UNHEX('FFD8FFE000104A464946'), 7, 9),
(10, 'witcher_novigrad.jpg', UNHEX('FFD8FFE000104A464946'), 2, 4);

INSERT INTO `mydb`.`completed_achievements` (`achievement_id`, `user_id`) VALUES
(1, 1),
(2, 1),
(6, 1),
(6, 2),
(3, 2),
(4, 2),
(12, 3),
(6, 3),
(3, 4),
(5, 5),
(6, 5),
(8, 6),
(9, 8),
(10, 9),
(11, 10);

INSERT INTO `mydb`.`game_sesion` (`id`, `started_at`, `ended_at`, `game_id`, `user_id`) VALUES
(1, '2025-04-01 10:00:00', '2025-04-01 12:30:00', 4, 1),
(2, '2025-04-02 14:00:00', NULL, 1, 1),
(3, '2025-04-03 16:00:00', '2025-04-03 18:00:00', 3, 5),
(4, '2025-04-04 18:00:00', NULL, 4, 2),
(5, '2025-04-05 20:00:00', '2025-04-05 22:15:00', 2, 2),
(6, '2025-04-06 09:30:00', '2025-04-06 10:45:00', 6, 8),
(7, '2025-04-07 19:00:00', '2025-04-07 23:00:00', 9, 10),
(8, '2025-04-08 21:00:00', NULL, 10, 3),
(9, '2025-04-09 15:00:00', '2025-04-09 16:30:00', 7, 9),
(10, '2025-04-10 17:20:00', '2025-04-10 19:00:00', 2, 4),
(11, '2025-04-11 20:00:00', '2025-04-11 21:40:00', 5, 6),
(12, '2025-04-12 18:00:00', '2025-04-12 20:30:00', 3, 5);

INSERT INTO `mydb`.`item` (`id`, `name`, `description`, `user_id`) VALUES
(1, 'Golden Sword', 'Rare weapon skin', 1),
(2, 'Viking Helmet', 'Cosmetic helmet', 1),
(3, 'Wolf Medallion', 'Collectible medallion', 2),
(4, 'Neon Jacket', 'Cyberpunk-style outfit', 3),
(5, 'Dragon Mount', 'Rare mount', 4),
(6, 'AK-47 Redline', 'Weapon skin for CS', 5),
(7, 'Steel Shield', NULL, 6),
(8, 'Cowboy Hat', 'Western-style hat', 8),
(9, 'Elden Ring Badge', 'Profile badge', 10),
(10, 'Mage Staff', 'Epic weapon', 9);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
