USE eventsdb;
SELECT * FROM admins;
SELECT * FROM agelimit;
SELECT * FROM clients;
SELECT * FROM eventlocations;
SELECT * FROM events;
SELECT * FROM eventtypes;
SELECT * FROM locationevents;
SELECT * FROM locations;
SELECT * FROM organizers;
SELECT * FROM places;
SELECT * FROM purchases;
SELECT * FROM tickets;
SELECT * FROM users;

SELECT DISTINCT Price FROM Tickets;

SELECT * FROM users
WHERE FirstName IN ('Петр', 'Иван');

SELECT * FROM Locations
WHERE BuildingNumber BETWEEN 10 AND 20;

SELECT * FROM Locations
WHERE BuildingNumber NOT BETWEEN 10 AND 20;

SELECT EventName FROM Events
WHERE EventName LIKE 'Кино_';

SELECT EventName, EventDescription FROM events
WHERE EventDescription REGEXP '^Описание';

SELECT * FROM Clients
WHERE PhoneNumber IS NULL;

SELECT Street, BuildingNumber FROM Locations
ORDER BY BuildingNumber
LIMIT 3;

SELECT Street, BuildingNumber FROM Locations
ORDER BY BuildingNumber DESC;

SELECT AVG(DISTINCT Price) AS AVG_PRICE,
	   MIN(DISTINCT Price) AS MIN_PRICE,
       MAX(DISTINCT Price) AS MAX_PRICE,
       SUM(DISTINCT PRICE) AS SUM_PRICE,
       COUNT(Id) AS COUNT_TICKET
FROM Tickets;

SELECT Available, COUNT(*) AS Available_count
FROM Tickets
GROUP BY  Available;

select price, count(*) as price_count
from tickets
where price > 10
group by price;

select price, count(*) as price_count
from tickets
group by price
having price > 10;

select * from tickets
where price > (select avg(price) from tickets);
