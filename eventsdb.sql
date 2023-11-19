USE eventsdb;

CREATE TABLE Locations 
(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    City VARCHAR(30) NOT NULL,
    Street VARCHAR(50) NOT NULL,
    BuildingNumber INT NOT NULL
);

ALTER TABLE Locations 
ADD CONSTRAINT city_empty CHECK(City != "");

ALTER TABLE Locations
ADD CONSTRAINT street_empty CHECK(Street !="");

CREATE TABLE EventLocations
(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    BuildingName VARCHAR(50),
    LocationId INT,
    FOREIGN KEY (LocationId) REFERENCES Locations(Id) ON DELETE CASCADE
);
CREATE TABLE EventTypes
(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    EventType VARCHAR(30) NOT NULL
);

ALTER TABLE EventTypes
ADD CONSTRAINT type_empty CHECK(EventType != "");

CREATE TABLE Organizers
(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    OrganizerName VARCHAR(100) NOT NULL,
    PhoneNumber CHAR(13) NOT NULL,
    LocationId INT,
    FOREIGN KEY (LocationId) REFERENCES Locations(Id) ON DELETE CASCADE
);
CREATE TABLE AgeLimit
(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    AgeLimitValue ENUM('0+', '6+', '12+', '16+', '18+') NOT NULL
);
CREATE TABLE Events
(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    EventName VARCHAR(100) NOT NULL,
    EventDescription VARCHAR(3000),
    EventDate DATE NOT NULL,
    EventTime TIME NOT NULL,
    EventLocationId INT,
    EventTypeId INT, 
    EventOrganizerId INT, 
    AgeLimitId INT,
    FOREIGN KEY (EventLocationId) REFERENCES EventLocations(Id) ON DELETE CASCADE,
    FOREIGN KEY (EventTypeId) REFERENCES EventTypes(Id) ON DELETE CASCADE,
    FOREIGN KEY (EventOrganizerId) REFERENCES Organizers(Id) ON DELETE SET NULL,
    FOREIGN KEY (AgeLimitId) REFERENCES AgeLimit(Id) ON DELETE SET NULL
);

ALTER TABLE Events
DROP FOREIGN KEY EventLocationId;

alter table events 
drop key EventLocationId;

ALTER TABLE Events DROP COLUMN EventLocationId;

CREATE TABLE LocationEvents
(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    EventId INT,
    EventLocationId INT,
    FOREIGN KEY (EventId) REFERENCES Events(Id) ON DELETE CASCADE,
    FOREIGN KEY (EventLocationId) REFERENCES EventLocations(Id) ON DELETE CASCADE
);
CREATE TABLE Users
(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(30) NOT NULL, 
    LastName VARCHAR(30) NOT NULL, 
    Password VARCHAR(20) NOT NULL, 
    Email VARCHAR(30) NOT NULL 
);
CREATE TABLE Admins
(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    UserId INT,
    FOREIGN KEY (UserId) REFERENCES Users(Id) ON DELETE CASCADE
);
CREATE TABLE Clients
(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    PhoneNumber CHAR(13),
    UserId INT,
    FOREIGN KEY (UserId) REFERENCES Users(Id) ON DELETE CASCADE
);
CREATE TABLE Places
(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    Hall INT,
    PlaceRow INT, 
    Place INT
);
CREATE TABLE Tickets
(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    Available BOOL NOT NULL,
    Price INT NOT NULL,
    PlaceId INT,
    EventId INT,
    FOREIGN KEY (PlaceId) REFERENCES Places(Id) ON DELETE CASCADE,
    FOREIGN KEY (EventId) REFERENCES Events(Id) ON DELETE CASCADE
);
CREATE TABLE Purchases
(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    PurchaseDate DATETIME NOT NULL,
    ClientId INT,
    TicketId INT,
    FOREIGN KEY (ClientId) REFERENCES Clients(Id) ON DELETE CASCADE,
    FOREIGN KEY (TicketId) REFERENCES Tickets(Id) ON DELETE CASCADE
);

ALTER TABLE Users
MODIFY Status ENUM('Администратор', 'Клиент') DEFAULT 'Клиент';

ALTER TABLE Admins
MODIFY UserId INT UNIQUE;
ALTER TABLE Clients
MODIFY UserId INT UNIQUE;



