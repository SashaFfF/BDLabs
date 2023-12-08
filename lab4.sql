use eventsdb;

select EventName from events
where id in (select EventId from tickets where id = 217);

/*Название всех мероприятий, возрастное ограничение которых равно 12+*/
select EventName from events
where AgeLimitId = (select id from agelimit where AgeLimitValue = '12+');

select ageLimitValue from agelimit where id = 3;

/*Вывести цены билетов, которые меньше, чем средняя цена билета на мероприятие категории 'Кино' */
select distinct price from tickets
where price < (select avg(price) from tickets where eventId in
															(select id from events where EventTypeId = (select id from eventtypes where eventtype = 'Кино')));
/*тут все цены на мероприятия категории 'Кино'*/
select distinct price from tickets where eventId in (select id from events where EventTypeId = (select id from eventtypes where eventtype = 'Кино'));

/*Вывод всей информации о мероприятия в понятной форме без id (неявное соединение таблиц)*/
select ev.EventName, ev.EventDescription, ev.EventDate, ev.EventTime,
	   type.EventType, org.OrganizerName, lim.AgeLimitValue
       from events as ev, EventTypes as type, Organizers as org, AgeLimit as lim
       where ev.EventTypeId = type.Id and ev.EventOrganizerId = org.Id and ev.AgeLimitId = lim.Id;

  
/*  [INNER] JOIN, LEFT JOIN */       

/* цена на мероприятия + сортировка по убыванию цены */
SELECT distinct t.Price, ev.EventName
FROM Tickets AS t
JOIN Events AS ev ON t.EventId = ev.Id
ORDER BY t.Price DESC;

/* мероприятия (соединение больше 2 таблиц)*/
/* Пример использования left join
   мероприятия и названия их организаторов
   тут выводятся все мероприятия, если у него нет организатора, то будет выводится null
 */
SELECT ev.EventName, ev.EventDescription, ev.EventDate, ev.EventTime, type.EventType, org.OrganizerName, lim.AgeLimitValue
FROM Events as ev
JOIN EventTypes as type ON ev.EventTypeId = type.Id
LEFT JOIN Organizers as org ON ev.EventOrganizerId = org.Id
JOIN AgeLimit as lim ON ev.AgeLimitId = lim.Id;
     
/* список локации конкретного мероприятия (Id = 13)*/
select loc.City, loc.Street, loc.BuildingNumber,  evloc.BuildingName
from locationevents as l
join eventlocations as evloc on l.EventLocationId = evloc.Id AND l.EventId = 13
join locations as loc on loc.Id = evLoc.LocationId; 

/*список всех мероприятий и соответствующих им локаций*/
select ev.EventName, loc.City, loc.Street, loc.BuildingNumber, evloc.BuildingName
from locationevents as l
join eventlocations as evloc on l.EventLocationId = evloc.Id
join locations as loc on loc.Id = evloc.LocationId
join events as ev on l.EventId = ev.Id;

/* локация и кол-во мероприятий на этой локации*/
select loc.City, loc.Street, loc.BuildingNumber, count(loc.Id) as count_of_events
from locationevents as le
join events as ev on le.EventId = ev.Id
join eventlocations as evloc on le.EventLocationId = evloc.Id
join locations as loc on loc.Id = evloc.LocationId
group by loc.Id;

/* список всех клиентов */
select u.FirstName, u.LastName, u.Password, u.Email, u.Status, c.PhoneNumber
from users as u
join clients as c on u.Id = c.userId;

/* список всех админов */
select u.FirstName, u.LastName, u.Password, u.Email, u.Status
from users as u
join admins as a on u.Id = a.userId;

/* список всех сделок */
select p.PurchaseDate, u.FirstName, u.LastName, u.Password, u.Email, e.EventName, t.Price
from purchases as p
join clients as c on p.ClientId = c.Id
join users as u on u.Id = c.userId
join tickets as t on t.Id = p.TicketId
join events as e on t.eventId = e.Id;



/* UNION, GROUP BY, HAVING, OVER */

/*объединение мероприятий с возрастным ограничением 0+ и 6+ (UNION)*/
select ev.EventName as name, lim.AgeLimitValue 
from events as ev
join agelimit as lim on ev.AgeLimitId = lim.Id and lim.AgeLimitValue = '0+'
union select ev.EventName, lim.AgeLimitValue 
	  from events as ev
	  join agelimit as lim on ev.AgeLimitId = lim.Id and lim.AgeLimitValue = '6+';
  
/*группировка билетов по цене*/
select Price, count(*) as TicketCount
from tickets
where Available = true
group by price
having TicketCount > 1
order by price;

/* группировка билетов по мероприятиям  */
select  ev.EventName as Name, t.Price as Price, count(*) as TicketCount
from tickets as t
join events as ev on ev.Id = t.EventId
where t.Available = true
group by Price, Name
order by TicketCount;

/* группировка мероприятия по возрастному ограничению (сколько мероприятий приходится на каждое значение возрастного ограничения)*/
select lim.AgeLimitValue, count(*) as EventCount
from events as ev
join agelimit as lim on lim.Id = ev.AgeLimitId
group by lim.AgeLimitValue;

/* группировка мероприятий по категориям(типу) и среднее значение билета каждой категории */
select type.EventType, avg(t.Price)
from events as ev
join eventtypes as type on ev.EventTypeId = type.Id
join tickets as t on t.EventId = ev.Id
group by type.Id;

/* группировка мероприятий по локации (сколько в каждой локации идет мероприятий) */
select evloc.BuildingName, count(*) as EventCount
from locationevents as l
join eventlocations as evloc on evloc.Id = l.EventLocationId
group by l.EventLocationId;

/* мероприятия по типу группируются в окна, выводится средняя стоимость билета для этого типа мероприятия*/
select distinct ev.EventName, t.Price as TicketPrice, type.EventType, 
avg(t.Price) over(partition by ev.EventTypeId) as AvgPrice
from events as ev
join tickets as t on t.EventId = ev.Id
join eventtypes as type on type.Id =ev.eventTypeId;
 
select distinct ev.EventName, t.Price as TicketPrice, type.EventType,
avg(t.Price) over(partition by ev.EventTypeId order by t.Price rows between 1 preceding and 1 following ) as AvgPrice,
row_number() over(partition by ev.EventTypeId order by t.Price) as RowNumber,
lag(t.Price) over(partition by ev.EventTypeId order by t.Price) as PreviousPrice,
lead(Price) over(partition by ev.EventTypeId order by t.Price) as NextPrice
from events as ev
join tickets as t on t.EventId = ev.Id
join eventtypes as type on type.Id =ev.eventTypeId;

select distinct ev.EventName, type.EventType, t.Price as TicketPrice, (select count(id) from tickets where Tickets.EventId = ev.Id and Available =true) as TicketCount,
sum(t.Price) over(partition by ev.EventTypeId order by ev.EventName ) as Sum
from events as ev
join tickets as t on ev.Id = t.EventId and t.Available = true
join EventTypes as type on type.Id = ev.EventTypeId;


/*  EXISTS, CASE */

/* вывожу билеты из таблицы tickets, на которые есть заказы в таблице purchases*/
select * from tickets as t
where exists (select * from purchases as p where p.TicketId = t.Id);

select ev.EventName, t.Price,
case
	when t.Price < 20 then 'Цена ниже 20'
    when t.Price > 20 then 'Цена выше 20'
    else 'Цена равна 20'
end as CaseResult
from tickets as t
join events as ev on ev.Id = t.EventId
group by t.EventId, t.Price
order by ev.EventName;

select u.FirstName, u.LastName, c.PhoneNumber
from users as u
join clients as c on c.UserId = u.Id
order by 
(case 
	when c.PhoneNumber is null then u.FirstName
    else u.LastName
end );

/* Задача при сдаче 4 лабы */
/* клиент - мероприятие - за каждое мероприятие сколько отдал, если не отдал - null */

/*клиент - мероприятие - сколько отдал денег*/
select u.FirstName, u.LastName,
case 
	when p.TicketId = t.Id is null then null
    else t.Price
end as Price
from clients as c
right join users as u on u.Id = c.UserId
join purchases as p on c.Id = c.Id
join tickets as t on p.TicketId = t.Id;

select u.FirstName, p.Id, t.Price, ev.EventName
from users as u
join clients as c on c.UserId = u.Id
left join purchases as p on p.ClientId = c.Id
left join tickets as t on p.TicketId = t.Id
left join events as ev on t.EventId = ev.Id;


/* клиент - мероприятие - за каждое мероприятие сколько отдал, если не отдал то null */
/*клиент - мероприятие - сколько отдал денег*/

select distinct u.FirstName, u.LastName, ev.EventName, (select sum(t.Price)
														from tickets as t 
														join purchases as p on p.TicketId = t.Id
														right join clients as c on p.ClientId = c.Id
														group by c.Id
														having p.ClientId = c.Id) AS Pice
from events as ev
join tickets as t on t.EventId = ev.Id
left join purchases as p on p.TicketId = t.Id
right join clients as c on p.ClientId = c.Id
left join users as u on u.Id = c.UserId;