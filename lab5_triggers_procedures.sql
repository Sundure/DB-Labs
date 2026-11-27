USE `mydb`;

DROP TABLE IF EXISTS `game_review`;
DROP TABLE IF EXISTS `publisher_delete_log`;
DROP TRIGGER IF EXISTS `trg_review_before_insert`;
DROP TRIGGER IF EXISTS `trg_review_before_update`;
DROP TRIGGER IF EXISTS `trg_game_before_delete`;
DROP TRIGGER IF EXISTS `trg_game_price_no_00`;
DROP TRIGGER IF EXISTS `trg_publisher_log_delete`;
DROP TRIGGER IF EXISTS `trg_user_allowed_names`;
DROP PROCEDURE IF EXISTS `sp_insert_publisher`;
DROP PROCEDURE IF EXISTS `sp_add_game_to_user_library`;
DROP PROCEDURE IF EXISTS `sp_insert_10_noname_publishers`;
DROP PROCEDURE IF EXISTS `sp_get_max_game_price`;
DROP PROCEDURE IF EXISTS `sp_split_publishers_cursor`;
DROP FUNCTION IF EXISTS `fn_get_max_price`;

CREATE TABLE `game_review` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `rating` TINYINT UNSIGNED NOT NULL,
  `comment` VARCHAR(255) NULL,
  `game_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;

DELIMITER $$

CREATE TRIGGER `trg_review_before_insert`
BEFORE INSERT ON `game_review`
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT 1 FROM `game` WHERE `id` = NEW.game_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Помилка цілісності: гри з таким game_id не існує!';
    END IF;
END$$

CREATE TRIGGER `trg_review_before_update`
BEFORE UPDATE ON `game_review`
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT 1 FROM `game` WHERE `id` = NEW.game_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Помилка цілісності: гри з таким game_id не існує!';
    END IF;
END$$

CREATE TRIGGER `trg_game_before_delete`
BEFORE DELETE ON `game`
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM `game_review` WHERE `game_id` = OLD.id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Помилка цілісності: неможливо видалити гру, бо на неї є відгуки у game_review!';
    END IF;
END$$

CREATE PROCEDURE `sp_insert_publisher`(IN p_name VARCHAR(45))
BEGIN
    INSERT INTO `publisher` (`name`) VALUES (p_name);
    SELECT LAST_INSERT_ID() AS inserted_id, p_name AS name;
END$$

CREATE PROCEDURE `sp_add_game_to_user_library`(
    IN p_user_nickname VARCHAR(45),
    IN p_game_name VARCHAR(45),
    IN p_played_minutes INT UNSIGNED
)
BEGIN
    DECLARE v_user_id INT UNSIGNED;
    DECLARE v_game_id INT UNSIGNED;

    SELECT `id` INTO v_user_id FROM `user` WHERE `nickname` = p_user_nickname LIMIT 1;
    SELECT `id` INTO v_game_id FROM `game` WHERE `name` = p_game_name LIMIT 1;

    IF v_user_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Користувача з таким nickname не знайдено';
    END IF;

    IF v_game_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Гру з такою назвою не знайдено';
    END IF;

    INSERT INTO `library` (`game_id`, `user_id`, `played_minutes`, `first_played_at`)
    VALUES (v_game_id, v_user_id, p_played_minutes, NOW());

    SELECT v_user_id AS user_id, p_user_nickname AS nickname, v_game_id AS game_id, p_game_name AS game_name, p_played_minutes AS played_minutes;
END$$

CREATE PROCEDURE `sp_insert_10_noname_publishers`()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 10 DO
        INSERT INTO `publisher` (`name`) VALUES (CONCAT('Noname', i));
        SET i = i + 1;
    END WHILE;
    SELECT 'Успішно додано 10 записів Noname1..Noname10' AS result;
END$$

CREATE FUNCTION `fn_get_max_price`()
RETURNS INT UNSIGNED
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_max_price INT UNSIGNED;
    SELECT MAX(`price`) INTO v_max_price FROM `game`;
    RETURN IFNULL(v_max_price, 0);
END$$

CREATE PROCEDURE `sp_get_max_game_price`()
BEGIN
    SELECT `fn_get_max_price`() AS max_game_price;
END$$

CREATE PROCEDURE `sp_split_publishers_cursor`()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id INT UNSIGNED;
    DECLARE v_name VARCHAR(45);
    DECLARE v_stamp VARCHAR(20);
    DECLARE v_tbl1 VARCHAR(64);
    DECLARE v_tbl2 VARCHAR(64);

    DECLARE cur_pub CURSOR FOR SELECT `id`, `name` FROM `publisher`;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    SET v_stamp = DATE_FORMAT(NOW(), '%Y%m%d_%H%i%s');
    SET v_tbl1 = CONCAT('publisher_part1_', v_stamp);
    SET v_tbl2 = CONCAT('publisher_part2_', v_stamp);

    SET @sql1 = CONCAT('CREATE TABLE `', v_tbl1, '` LIKE `publisher`');
    PREPARE stmt1 FROM @sql1;
    EXECUTE stmt1;
    DEALLOCATE PREPARE stmt1;

    SET @sql2 = CONCAT('CREATE TABLE `', v_tbl2, '` LIKE `publisher`');
    PREPARE stmt2 FROM @sql2;
    EXECUTE stmt2;
    DEALLOCATE PREPARE stmt2;

    OPEN cur_pub;
    read_loop: LOOP
        FETCH cur_pub INTO v_id, v_name;
        IF done THEN
            LEAVE read_loop;
        END IF;

        IF RAND() < 0.5 THEN
            SET @ins = CONCAT('INSERT INTO `', v_tbl1, '` (`id`, `name`) VALUES (', v_id, ', ', QUOTE(v_name), ')');
        ELSE
            SET @ins = CONCAT('INSERT INTO `', v_tbl2, '` (`id`, `name`) VALUES (', v_id, ', ', QUOTE(v_name), ')');
        END IF;

        PREPARE stmt_ins FROM @ins;
        EXECUTE stmt_ins;
        DEALLOCATE PREPARE stmt_ins;
    END LOOP;
    CLOSE cur_pub;

    SELECT v_tbl1 AS created_table_1, v_tbl2 AS created_table_2;
END$$

CREATE TRIGGER `trg_game_price_no_00`
BEFORE INSERT ON `game`
FOR EACH ROW
BEGIN
    IF NEW.price IS NOT NULL AND NEW.price > 0 AND (NEW.price % 100 = 0) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Ціна гри не може закінчуватися двома нулями!';
    END IF;
END$$

CREATE TABLE `publisher_delete_log` (
  `log_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `deleted_publisher_id` INT UNSIGNED NOT NULL,
  `deleted_publisher_name` VARCHAR(45) NOT NULL,
  `deleted_at` DATETIME NOT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE = InnoDB$$

CREATE TRIGGER `trg_publisher_log_delete`
AFTER DELETE ON `publisher`
FOR EACH ROW
BEGIN
    INSERT INTO `publisher_delete_log` (`deleted_publisher_id`, `deleted_publisher_name`, `deleted_at`)
    VALUES (OLD.id, OLD.name, NOW());
END$$

CREATE TRIGGER `trg_user_allowed_names`
BEFORE INSERT ON `user`
FOR EACH ROW
BEGIN
    IF NEW.name NOT IN ('Svitlana', 'Petro', 'Olha', 'Taras') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Дозволені лише імена: Svitlana, Petro, Olha, Taras';
    END IF;
END$$

DELIMITER ;

INSERT INTO `game_review` (`rating`, `comment`, `game_id`) VALUES (5, 'Чудова гра!', 1);
