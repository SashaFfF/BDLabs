use eventsdb;
/* create_user  */
CALL create_user('Ярослава', 'Семёнова', '1233214566547887', 'semenova21@gmail.com', 'Клиент');
CALL create_user('Никита', 'Андреев', '00001114789525', 'hik03@gmail.com', 'Клиент');
/* уже использующийся проль (проверка триггера)*/
CALL create_user('Алина', 'Андреева', '00001114789525', 'hik03@gmail.com', null);

CALL create_user('Коля', 'Андреев', '00001114789521', 'hik03@gmail.com', 'Клиент');


select* from users;
select * from clients;
select * from admins;
delete from users where FirstName = 'Коля';

/*  make_purchase */
CALL make_purchase(6, 267);
/* проверка покупки уже приобретенного билета (проверка триггера)*/
CALL make_purchase(5, 268);
/*CALL make_purchase(5, 230);*/

select * from tickets;
select * from purchases;

/* get_events_by_type_date */
CALL get_events_by_type_date('2023-11-15', 1);    /* по дате и типу */
CALL get_events_by_type_date('2023-11-20', null); /* тип не уичтываем, только по дате*/

select * from events;
select * from eventlocations;

/* get_events_by_location */
CALL get_events_by_location(3, '2023-11-20');

/* count_of_available_tickets_by_event */
CALL count_of_available_tickets_by_event(17);

/*  create_event */
CALL eventsdb.create_event('Спектакль2', 'Описание спектакля 2', '2023-12-20', '19:00:00', 4, 2, 1, 2);
/* прошедшая дата (проверка триггера)*/
CALL eventsdb.create_event('Спектакль3', 'Описание спектакля 2', '2023-09-20', '19:00:00', 4, 2, 1, 2);
