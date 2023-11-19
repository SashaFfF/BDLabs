USE eventsdb;
/*
INSERT AgeLimit(AgeLimitValue) VALUES 
('0+'),
('6+'),
('12+'),
('16+'),
('18+');

INSERT Locations(City, Street, BuildingNumber) VALUES
('Минск', 'ул. Романовская Слобода', 28),
('Минск', 'ул. Притыцкого', 23),
('Минск', 'пр-т Победителей', 111),
('Минск', 'ул. Энгельса', 26),
('Минск', 'Центральная', 90),
('Минск', 'Садовая', 8);
# INSERT EventLocations()

INSERT EventTypes(EventType) VALUES
('Кино'),
('Спектакли'),
('Концерты');

INSERT Users(FirstName, LastName, Password, Email, Status) VALUES
('Иван', 'Иванов', '123456789', 'ivanov@gmail.com', DEFAULT),
('Петр', 'Петров', '1234000009', 'petrov@gmail.com', DEFAULT),
('Александра', 'Филипеня', '111222333', 'alexf@gmail.com', 'Администратор');

INSERT Admins(UserId) SELECT Id FROM Users WHERE Status = 'Администратор';

INSERT Clients(UserId) SELECT Id FROM Users WHERE Status = 'Клиент';

INSERT Locations(City, Street, BuildingNumber) VALUES
('Минск', 'ул. Романовская Слобода', 28),
('Минск', 'ул. Притыцкого', 23),
('Минск', 'пр-т Победителей', 111),
('Минск', 'ул. Энгельса', 26),
('Минск', 'Центральная', 90),
('Минск', 'Советская', 15),
('Минск', 'Садовая', 8);

INSERT EventLocations(BuildingName,  LocationId) VALUES
("Беларусь", 1),
('Аврора', 2),
('Минск-Арена', 3),
('Театр юного зрителя', 4);

INSERT Organizers(OrganizerName, LocationId, PhoneNumber) VALUES
('Организатор1', 5, '+375252222223'),
('Организатор2', 6, '+375290000003'),
('Организатор3', 7, '+375251111113');


INSERT Users(FirstName, LastName, Password, Email, Status) VALUES
('Валерия', 'Качановская', '000111222', 'lera@gmail.com', DEFAULT),
('Анастасия', 'Хрищанович', '987654321', 'nastkr@gmail.com', DEFAULT);

INSERT IGNORE Clients(UserId) SELECT Id FROM Users WHERE Status = 'Клиент';

INSERT Events(EventName, EventDescription, EventDate, EventTime, EventLocationId, EventTypeId, EventOrganizerId, AgeLimitId) VALUES 
('Кино1', 'Описание1', '2023-11-15', '12:00:00', 1, 1, 1, 2),
('Кино2', 'Описание2', '2023-11-25', '18:00:00', 1, 1, 2, 3),
('Кино3', 'Описание3', '2023-11-17', '10:00:00', 2, 1, 1, 1),
('Кино4', 'Описание4', '2023-11-20', '13:00:00', 2, 1, 2, 4),
('Спектакль1', 'Описание спектакля 1', '2023-11-20', '16:00:00', 4, 2, 1, 2),
('Кнцерт1', 'Описание концерта 1', '2023-11-19', '12:00:00', 3, 3, 2, 2);

INSERT Places(Hall, PlaceRow, Place) VALUES
(1, 1, 1),
(1, 1, 2),
(1, 2, 1), 
(1, 2, 2);

INSERT Tickets(Available, Price, PlaceId, EventId) VALUES
(true, 10, 1, 1),
(true, 10, 2, 1),
(true, 10, 3, 1),
(true, 10, 4, 1),

(true, 15, 1, 2),
(true, 15, 2, 2),
(true, 15, 3, 2),
(true, 15, 4, 2),

(true, 10, 1, 3),
(true, 10, 2, 3),
(true, 10, 3, 3),
(true, 10, 4, 3),

(true, 20, 1, 4),
(true, 20, 2, 4),
(true, 20, 3, 4),
(true, 20, 4, 4),

(true, 50, 1, 5),
(true, 50, 2, 5),
(true, 50, 3, 5),
(true, 50, 4, 5),

(true, 90, 1, 6),
(true, 90, 2, 6),
(true, 90, 3, 6),
(true, 90, 4, 6);

 INSERT Purchases(PurchaseDate, ClientId, TicketId) VALUES
 ('2023-10-25 09:00:00', 1, 1);
 
 UPDATE Tickets
 SET Available = false
 WHERE Id = 1;
 
 INSERT locationevents(EventId, EventLocationId) VALUES
(1, 1),
(2, 1),
(1, 1),
(2, 1),
(1, 1),
(2, 1);

*/
INSERT Events(EventName, EventDescription, EventDate, EventTime, EventTypeId, EventOrganizerId, AgeLimitId) VALUES 
('Кино1', 'Описание1', '2023-11-15', '12:00:00', 1, 1, 2),
('Кино2', 'Описание2', '2023-11-25', '18:00:00', 1, 2, 3),
('Кино3', 'Описание3', '2023-11-17', '10:00:00', 1, 1, 1),
('Кино4', 'Описание4', '2023-11-20', '13:00:00', 1, 2, 4),
('Спектакль1', 'Описание спектакля 1', '2023-11-20', '16:00:00', 2, 1, 2),
('Кнцерт1', 'Описание концерта 1', '2023-11-19', '12:00:00', 3, 2, 2);

INSERT Events(EventName, EventDescription, EventDate, EventTime, EventTypeId, EventOrganizerId, AgeLimitId) VALUES 
('Коцерт2', 'Описание концерта 2', '2023-11-19', '12:00:00', 3, null, 2);


INSERT Places(Hall, PlaceRow, Place) VALUES
(1, 1, 1),
(1, 1, 2),
(1, 2, 1), 
(1, 2, 2);

SELECT * FROM EVENTS;

INSERT Tickets(Available, Price, PlaceId, EventId) VALUES
(true, 10, 1, 13),
(true, 10, 2, 13),
(true, 10, 3, 13),
(true, 10, 4, 13),

(true, 15, 1, 14),
(true, 15, 2, 14),
(true, 15, 3, 14),
(true, 15, 4, 14),

(true, 10, 1, 15),
(true, 10, 2, 15),
(true, 10, 3, 15),
(true, 10, 4, 15),

(true, 20, 1, 16),
(true, 20, 2, 16),
(true, 20, 3, 16),
(true, 20, 4, 16),

(true, 50, 1, 17),
(true, 50, 2, 17),
(true, 50, 3, 17),
(true, 50, 4, 17),

(true, 90, 1, 18),
(true, 90, 2, 18),
(true, 90, 3, 18),
(true, 90, 4, 18);

INSERT Tickets(Available, Price, PlaceId, EventId) VALUES
(true, 60, 1, 19),
(true, 60, 2, 19),
(true, 60, 3, 19),
(true, 60, 4, 19);

 INSERT Purchases(PurchaseDate, ClientId, TicketId) VALUES
 ('2023-10-25 09:00:00', 2, 240);
 
INSERT Purchases(PurchaseDate, ClientId, TicketId) VALUES
('2023-10-25 10:00:00', 2, 239);
 
INSERT Purchases(PurchaseDate, ClientId, TicketId) VALUES
('2023-10-25 10:00:00', 1, 236);
 
 delete from purchases where Id In (5,6);
 
 select * from tickets;
 
 UPDATE Tickets
 SET Available = false
 WHERE Id = 240;

 UPDATE Tickets
 SET Available = false
 WHERE Id = 239;

 UPDATE Tickets
 SET Available = false
 WHERE Id = 236;

INSERT locationevents(EventId, EventLocationId) VALUES
(13, 1),
(14, 1),
(15, 2),
(16, 2),
(17, 3),
(18, 4);

INSERT locationevents(EventId, EventLocationId) VALUES
(19, 4),
(13, 2); /*добавлю еще вторую локацию для этого мероприятия */
