use r97dF5IqLS;

SELECT * from city;
insert into city set `city_code` = null, `city_name` = 'Cambridge11', `state_name` = 'MA';

select p.name, p.passenger_id, count(t.ticket_id) from passenger as p inner join tickets as t on t.passenger_id = p.passenger_id inner join route as r group by p.passenger_id;

-- How many times a passenger has travelled in a route.
select p.name, r.line_name, count(*) from tickets as t inner join passenger as p on p.passenger_id = t.passenger_id 
inner join route as r on r.route_id = t.route_id group by p.passenger_id, p.route_id;

-- Error Handling Required for Procedures and Functions.

/*
	The cargo weight of a tram through the given time range. (Sum of the Weights).
*/

/*
	Busy days of the week.
*/

/*
	get the routes available for a given source and destination. In review
*/

-- Get the trams available for a route on a day. Like operator to match the days.
-- 