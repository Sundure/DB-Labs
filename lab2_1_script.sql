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

-- -----------------------------------------------------
-- Table `mydb`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product` (
  `maker` VARCHAR(10) NOT NULL,
  `model` VARCHAR(45) NOT NULL,
  `Type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`model`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PC`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PC` (
  `code` INT NOT NULL,
  `speed` SMALLINT NOT NULL,
  `ram` SMALLINT NOT NULL,
  `hd` REAL NOT NULL,
  `cd` VARCHAR(10) NOT NULL,
  `price` DECIMAL NULL,
  `Product_model` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`code`),
  INDEX `fk_PC_Product_idx` (`Product_model` ASC) VISIBLE,
  CONSTRAINT `fk_PC_Product`
    FOREIGN KEY (`Product_model`)
    REFERENCES `mydb`.`Product` (`model`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Laptop`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Laptop` (
  `code` INT NOT NULL,
  `speed` SMALLINT NOT NULL,
  `ram` SMALLINT NOT NULL,
  `hd` REAL NOT NULL,
  `screen` TINYINT NOT NULL,
  `price` DECIMAL NULL,
  `Product_model` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`code`),
  INDEX `fk_Laptop_Product1_idx` (`Product_model` ASC) VISIBLE,
  CONSTRAINT `fk_Laptop_Product1`
    FOREIGN KEY (`Product_model`)
    REFERENCES `mydb`.`Product` (`model`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Printer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Printer` (
  `code` INT NOT NULL,
  `color` CHAR(1) NOT NULL,
  `price` DECIMAL NULL,
  `type` VARCHAR(10) NOT NULL,
  `Product_model` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`code`),
  INDEX `fk_Printer_Product1_idx` (`Product_model` ASC) VISIBLE,
  CONSTRAINT `fk_Printer_Product1`
    FOREIGN KEY (`Product_model`)
    REFERENCES `mydb`.`Product` (`model`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Income`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Income` (
  `code` INT NOT NULL,
  `point` TINYINT NULL,
  `date` DATETIME NOT NULL,
  `inc` DECIMAL NULL,
  PRIMARY KEY (`code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Outcome`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Outcome` (
  `code` INT NOT NULL,
  `point` TINYINT NULL,
  `date` DATETIME NOT NULL,
  `inc` DECIMAL NULL,
  PRIMARY KEY (`code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Income_o`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Income_o` (
  `code` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `inc` DECIMAL NULL,
  PRIMARY KEY (`code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Outcome_o`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Outcome_o` (
  `code` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `inc` DECIMAL NULL,
  PRIMARY KEY (`code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Classes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Classes` (
  `class` VARCHAR(50) NOT NULL,
  `type` VARCHAR(2) NOT NULL,
  `country` VARCHAR(20) NOT NULL,
  `numGuns` TINYINT NULL,
  `bore` REAL NULL,
  `displacement` INT NULL,
  PRIMARY KEY (`class`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ships`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ships` (
  `name` VARCHAR(50) NOT NULL,
  `launched` SMALLINT NULL,
  `Classes_class` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`name`),
  INDEX `fk_Ships_Classes1_idx` (`Classes_class` ASC) VISIBLE,
  CONSTRAINT `fk_Ships_Classes1`
    FOREIGN KEY (`Classes_class`)
    REFERENCES `mydb`.`Classes` (`class`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Battles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Battles` (
  `name` VARCHAR(20) NOT NULL,
  `date` DATETIME NOT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Outcomes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Outcomes` (
  `battle` VARCHAR(20) NOT NULL,
  `ship` VARCHAR(50) NOT NULL,
  `result` VARCHAR(10) NOT NULL,
  `Battles_name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`battle`, `ship`, `Battles_name`),
  INDEX `fk_Outcomes_Battles1_idx` (`Battles_name` ASC) VISIBLE,
  CONSTRAINT `fk_Outcomes_Battles1`
    FOREIGN KEY (`Battles_name`)
    REFERENCES `mydb`.`Battles` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Company` (
  `ID_comp` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` CHAR(10) NOT NULL,
  PRIMARY KEY (`ID_comp`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Trip`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Trip` (
  `trip_no` INT UNSIGNED NOT NULL,
  `Company_ID_comp` INT UNSIGNED NOT NULL,
  `plane` CHAR(10) NOT NULL,
  `town_from` CHAR(25) NOT NULL,
  `town_to` CHAR(25) NOT NULL,
  `time_out` DATETIME NULL,
  `time_in` DATETIME NULL,
  PRIMARY KEY (`trip_no`),
  INDEX `fk_Trip_Company1_idx` (`Company_ID_comp` ASC) VISIBLE,
  CONSTRAINT `fk_Trip_Company1`
    FOREIGN KEY (`Company_ID_comp`)
    REFERENCES `mydb`.`Company` (`ID_comp`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Passenger`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Passenger` (
  `ID_psg` INT NOT NULL AUTO_INCREMENT,
  `name` CHAR(20) NOT NULL,
  PRIMARY KEY (`ID_psg`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pass_in_trip`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pass_in_trip` (
  `Trip_trip_no` INT UNSIGNED NOT NULL,
  `date` DATE NULL,
  `Passenger_ID_psg` INT NOT NULL,
  `place` CHAR(10) NOT NULL,
  INDEX `fk_Pass_in_trip_Trip1_idx` (`Trip_trip_no` ASC) VISIBLE,
  INDEX `fk_Pass_in_trip_Passenger1_idx` (`Passenger_ID_psg` ASC) VISIBLE,
  CONSTRAINT `fk_Pass_in_trip_Trip1`
    FOREIGN KEY (`Trip_trip_no`)
    REFERENCES `mydb`.`Trip` (`trip_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pass_in_trip_Passenger1`
    FOREIGN KEY (`Passenger_ID_psg`)
    REFERENCES `mydb`.`Passenger` (`ID_psg`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


INSERT INTO `Product` (`maker`, `model`, `Type`) VALUES
('MakerA', 'PC_101', 'PC'),
('MakerB', 'Lap_201', 'Laptop'),
('MakerC', 'PC_301', 'PC'),
('MakerC', 'Prn_302', 'Printer'),
('MakerA', 'PC_102', 'PC'),
('MakerB', 'Lap_202', 'Laptop'),
('MakerD', 'PC_401', 'PC'),
('MakerD', 'Prn_402', 'Printer'),
('MakerE', 'Lap_501', 'Laptop'),
('MakerE', 'Prn_502', 'Printer');

INSERT INTO `PC` (`code`, `speed`, `ram`, `hd`, `cd`, `price`, `Product_model`) VALUES
(1,  3000, 16, 1000.0, '16x', 800.00, 'PC_101'),
(2,  2500, 8, 500.0, '24x', 600.00, 'PC_301'),
(3,  3200, 16, 2000.0, '32x', 950.00, 'PC_102'),
(4,  2800, 16, 1000.0, '16x', 850.00, 'PC_401');

INSERT INTO `Laptop` (`code`,  `speed`, `ram`, `hd`, `screen`, `price`, `Product_model`) VALUES
(1,  2000, 8, 256.0, 15, 1200.00, 'Lap_201'),
(2,  2400, 16, 512.0, 17, 1500.00, 'Lap_202'),
(3,  1800, 8, 256.0, 14, 900.00, 'Lap_501');

INSERT INTO `Printer` (`code`,  `color`, `price`, `type`, `Product_model`) VALUES
(1,  'n', 150.00, 'Laser', 'Prn_302'),
(2,  'y', 250.00, 'Inkjet', 'Prn_402'),
(3,  'n', 120.00, 'Laser', 'Prn_502');

INSERT INTO `Classes` (`class`, `type`, `country`, `numGuns`, `bore`, `displacement`) VALUES
('Yamato', 'bb', 'Japan', 9, 18.1, 65000),
('Kongo', 'bb', 'USA', 8, 15.0, 32000),
('Bismarck', 'bb', 'Germany', 8, 15.0, 42000),
('Iowa', 'bb', 'USA', 9, 16.0, 45000),
('North Carolina', 'bb', 'USA', 9, 16.0, 35000),
('King George V', 'bb', 'UK', 10, 14.0, 35000),
('Fuso', 'bb', 'Japan', 12, 14.0, 29000),
('Nagato', 'bb', 'Japan', 8, 16.0, 32000),
('Tirpitz', 'bb', 'Germany', 8, 15.0, 42000),
('Richelieu', 'bb', 'France', 8, 15.0, 35000);

INSERT INTO `Ships` (`name`, `launched`, `Classes_class`) VALUES
('Yamato Ship',  1941, 'Yamato'),
('Kongo Ship',  1915, 'Kongo'),
('Bismarck Ship',  1939, 'Bismarck'),
('Iowa Ship',  1943, 'Iowa'),
('Washington',  1941, 'North Carolina'),
('Duke of York',  1940, 'King George V'),
('Fuso Ship',  1915, 'Fuso'),
('Nagato Ship',  1920, 'Nagato'),
('Tirpitz Ship',  1941, 'Tirpitz'),
('Richelieu Ship',  1940, 'Richelieu');

INSERT INTO `Company` (`name`) VALUES 
('SkyUp'), 
('Ryanair'),
('Wizz Air'),
('Lufthansa'),
('KLM'),
('Air France'),
('TurkishAir'),
('QatarAir'),
('Emirates'),
('Delta');

INSERT INTO `Passenger` (`name`) VALUES 
('Ivan Petrenko'), 
('Olena Kosh'),
('Andriy Boiko'),
('Maria Tkachenko'),
('Oleg Sydorenko'),
('Anna Kovalenko'),
('Dmitry Savchenko'),
('Iryna Shevchenko'),
('Yuri Kravchenko'),
('Natalia Olijnyk');

INSERT INTO `Trip` (`trip_no`, `Company_ID_comp`, `plane`, `town_from`, `town_to`, `time_out`, `time_in`) VALUES
(1122, 1, 'Boeing 737', 'Kyiv', 'London', '2023-10-15 10:00:00', '2023-10-15 12:00:00'),
(3344, 2, 'Airbus 320', 'Lviv', 'Berlin', '2023-11-20 14:00:00', '2023-11-20 15:30:00'),
(5566, 3, 'Airbus 321', 'Odesa', 'Warsaw', '2023-12-01 09:00:00', '2023-12-01 10:00:00'),
(7788, 4, 'Boeing 747', 'Kyiv', 'Munich', '2024-01-10 11:00:00', '2024-01-10 13:00:00'),
(9900, 5, 'Boeing 777', 'Lviv', 'Amsterdam', '2024-02-15 16:00:00', '2024-02-15 18:00:00'),
(1234, 6, 'Airbus 330', 'Kyiv', 'Paris', '2024-03-20 08:00:00', '2024-03-20 10:30:00'),
(5678, 7, 'Boeing 737', 'Odesa', 'Istanbul', '2024-04-25 19:00:00', '2024-04-25 21:00:00'),
(9012, 8, 'Airbus 350', 'Kyiv', 'Doha', '2024-05-30 22:00:00', '2024-05-31 03:00:00'),
(3456, 9, 'Airbus 380', 'Kyiv', 'Dubai', '2024-06-05 13:00:00', '2024-06-05 18:00:00'),
(7890, 10, 'Boeing 767', 'Kyiv', 'New York', '2024-07-10 10:00:00', '2024-07-10 20:00:00');

INSERT INTO `Pass_in_trip` (`Trip_trip_no`, `date`, `Passenger_ID_psg`, `place`) VALUES
(1122, '2023-10-15', 1, '14A'),
(3344, '2023-11-20', 2, '12B'),
(5566, '2023-12-01', 3, '1A'),
(7788, '2024-01-10', 4, '2C'),
(9900, '2024-02-15', 5, '3F'),
(1234, '2024-03-20', 6, '15D'),
(5678, '2024-04-25', 7, '16E'),
(9012, '2024-05-30', 8, '20A'),
(3456, '2024-06-05', 9, '21B'),
(7890, '2024-07-10', 10, '22C');

INSERT INTO `Outcome_o` (`code`, `date`, `inc`) VALUES
(1, '2023-05-14 10:30:00', 500.00),
(2, '2023-08-14 15:45:00', 300.00),
(3, '2023-09-10 11:00:00', 150.00),
(4, '2023-10-14 09:00:00', 600.00),
(5, '2023-11-14 14:20:00', 450.00),
(6, '2023-12-20 10:00:00', 200.00),
(7, '2024-01-14 16:30:00', 700.00),
(8, '2024-02-28 11:15:00', 100.00),
(9, '2024-03-14 13:45:00', 800.00),
(10, '2024-04-05 08:30:00', 250.00);

INSERT INTO `Income` (`code`, `point`, `date`, `inc`) VALUES
(1, 1, '2001-05-01 00:00:00', 1000.00),
(2, 2, '2001-06-15 00:00:00', 1500.00),
(3, 1, '2002-07-20 00:00:00', 1200.00),
(4, 3, '2002-08-10 00:00:00', 2000.00),
(5, 2, '2003-09-05 00:00:00', 1100.00),
(6, 1, '2003-10-12 00:00:00', 1300.00),
(7, 3, '2004-11-25 00:00:00', 1800.00),
(8, 2, '2004-12-30 00:00:00', 2500.00),
(9, 1, '2005-01-15 00:00:00', 900.00),
(10, 3, '2005-02-28 00:00:00', 1600.00);

INSERT INTO `Income_o` (`code`, `date`, `inc`) VALUES
(1, '2023-05-14 10:00:00', 1000.00),
(2, '2023-06-15 11:00:00', 1200.00),
(3, '2023-07-20 12:00:00', 800.00),
(4, '2023-08-14 13:00:00', 1500.00),
(5, '2023-09-10 14:00:00', 900.00),
(6, '2023-10-14 15:00:00', 2000.00),
(7, '2023-11-20 16:00:00', 1100.00),
(8, '2023-12-25 17:00:00', 1300.00),
(9, '2024-01-14 18:00:00', 1800.00),
(10, '2024-02-28 19:00:00', 2500.00);

INSERT INTO `Outcome` (`code`, `point`, `date`, `inc`) VALUES
(1, 1, '2023-05-14 10:30:00', 500.00),
(2, 2, '2023-06-15 11:30:00', 600.00),
(3, 1, '2023-07-20 12:30:00', 400.00),
(4, 3, '2023-08-14 13:30:00', 700.00),
(5, 2, '2023-09-10 14:30:00', 450.00),
(6, 1, '2023-10-14 15:30:00', 1000.00),
(7, 3, '2023-11-20 16:30:00', 550.00),
(8, 2, '2023-12-25 17:30:00', 650.00),
(9, 1, '2024-01-14 18:30:00', 900.00),
(10, 3, '2024-02-28 19:30:00', 1200.00);

INSERT INTO `Battles` (`name`, `date`) VALUES
('Midway', '1942-06-04 00:00:00'),
('Guadalcanal', '1942-11-12 00:00:00'),
('Coral Sea', '1942-05-04 00:00:00'),
('Leyte Gulf', '1944-10-23 00:00:00'),
('Philippine Sea', '1944-06-19 00:00:00'),
('Jutland', '1916-05-31 00:00:00'),
('Tsushima', '1905-05-27 00:00:00'),
('Trafalgar', '1805-10-21 00:00:00'),
('Lepanto', '1571-10-07 00:00:00'),
('Salamis', '0000-00-00 00:00:00');

INSERT INTO `Outcomes` (`battle`, `ship`, `result`, `Battles_name`) VALUES
('Midway', 'Yamato Ship', 'sunk', 'Midway'),
('Guadalcanal', 'Kongo Ship', 'ok', 'Guadalcanal'),
('Coral Sea', 'Yamato Ship', 'damaged', 'Coral Sea'),
('Leyte Gulf', 'Iowa Ship', 'ok', 'Leyte Gulf'),
('Philippine Sea', 'Washington', 'ok', 'Philippine Sea'),
('Jutland', 'Duke of York', 'damaged', 'Jutland'),
('Tsushima', 'Fuso Ship', 'sunk', 'Tsushima'),
('Trafalgar', 'Bismarck Ship', 'sunk', 'Trafalgar'),
('Lepanto', 'Nagato Ship', 'ok', 'Lepanto'),
('Salamis', 'Tirpitz Ship', 'damaged', 'Salamis');

SELECT *
FROM Classes 
WHERE country = 'Japan'
ORDER BY type DESC;

SELECT *
FROM Outcome_o
WHERE DAY(date) = 14;

SELECT Passenger.name, Pass_in_trip.date
FROM Passenger
JOIN Pass_in_trip ON Passenger.ID_psg = Pass_in_trip.Passenger_ID_psg;

SELECT Product.maker
FROM Product
WHERE type = 'PC' AND NOT (maker = ANY (
    SELECT maker
    FROM Product
    WHERE type = 'Laptop'
))
GROUP BY Product.maker;

SELECT Product.maker
FROM Product
WHERE type = 'Laptop' AND NOT (maker = ANY (
    SELECT Product.maker
    FROM Product
    WHERE type = 'Printer'
))
GROUP BY Product.maker;

SELECT DATE_FORMAT(date, '%d.%m.%Y')
FROM Income;

SELECT Product.maker, Printer.price
FROM Printer
JOIN Product ON Product.model = Printer.Product_model
WHERE color = 'n'
ORDER BY price ASC;

SELECT Product.maker, AVG(PC.hd)
FROM Product
JOIN PC ON Product.model = PC.Product_model
WHERE (maker = ANY(
    SELECT Product.maker
    FROM Product
    WHERE type = 'Printer'
))
GROUP BY Product.maker;

SELECT 
    s.name, 
    c.numGuns, 
    c.bore, 
    c.displacement, 
    c.type, 
    c.country, 
    s.launched, 
    c.class
FROM Ships s
JOIN Classes c ON s.Classes_class = c.class
WHERE (
    (CASE WHEN c.numGuns = 8 THEN 1 ELSE 0 END) +
    (CASE WHEN c.bore = 15 THEN 1 ELSE 0 END) +
    (CASE WHEN c.displacement = 32000 THEN 1 ELSE 0 END) +
    (CASE WHEN c.type = 'bb' THEN 1 ELSE 0 END) +
    (CASE WHEN c.country = 'USA' THEN 1 ELSE 0 END) +
    (CASE WHEN s.launched = 1915 THEN 1 ELSE 0 END) +
    (CASE WHEN c.class = 'Kongo' THEN 1 ELSE 0 END)
) >= 4;

SELECT 
    Product.type, 
    all_prices.Product_model, 
    MIN(all_prices.price)
FROM (
    SELECT Product_model, price FROM PC
    UNION ALL
    SELECT Product_model, price FROM Laptop
    UNION ALL
    SELECT Product_model, price FROM Printer
) AS all_prices
JOIN Product ON Product.model = all_prices.Product_model
GROUP BY Product.type, all_prices.Product_model;
