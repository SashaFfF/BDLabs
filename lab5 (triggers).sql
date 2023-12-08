/* Проверка на использование пароля*/
DELIMITER $$
CREATE DEFINER=`root`@`localhost` TRIGGER `users_BEFORE_INSERT` BEFORE INSERT ON `users` FOR EACH ROW BEGIN
	IF (SELECT Id FROM users WHERE users.Password = NEW.Password) IS NOT NULL THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Этот пароль уже используется';
	END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` TRIGGER `users_AFTER_INSERT` AFTER INSERT ON `users` FOR EACH ROW BEGIN
	IF NEW.Status = 'Клиент' THEN
		INSERT IGNORE Clients(UserId) VALUES (NEW.Id);
	ELSE 
        INSERT IGNORE Admins(UserId) VALUES (NEW.Id);
	END IF;
END $$
DELIMITER ;

/* Запрет на покупку уже приобретенного билета*/
DELIMITER $$
CREATE DEFINER=`root`@`localhost` TRIGGER `purchases_BEFORE_INSERT` BEFORE INSERT ON `purchases` FOR EACH ROW BEGIN
	IF (SELECT Available FROM tickets WHERE tickets.Id = NEW.TicketId) = false THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Этот билет уже приобретен';
	END IF;
END $$
DELIMITER ;

/*  Изменение значения поля Available у купленного билета на false  */
DELIMITER $$
CREATE DEFINER=`root`@`localhost` TRIGGER `purchases_AFTER_INSERT` AFTER INSERT ON `purchases` FOR EACH ROW
BEGIN
	UPDATE Tickets SET Available = false
    WHERE Tickets.Id = NEW.TicketId;
END $$
DELIMITER ;

/* Проверка даты мероприятия перед его добавлением  */
DELIMITER $$
CREATE DEFINER=`root`@`localhost` TRIGGER `events_BEFORE_INSERT` BEFORE INSERT ON `events` FOR EACH ROW BEGIN
	IF NEW.EventDate < current_date() THEN
		SIGNAL SQLSTATE '45000'
        SET message_text = 'Нельзя добавить мероприятие с прошедшей датой';
	END IF;
END $$
DELIMITER ;

