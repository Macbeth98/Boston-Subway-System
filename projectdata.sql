USE r97dF5IqLS;


CREATE TABLE city
(
  city_code        INT            PRIMARY KEY 		AUTO_INCREMENT,
  city_name   	   VARCHAR(50),
  state_name       VARCHAR(50),
  UNIQUE KEY `city_state_name` (`state_name`,`city_name`)
);

CREATE TABLE station
(
  station_id        INT            PRIMARY KEY 		AUTO_INCREMENT,
  station_name		VARCHAR(50)    UNIQUE,
  station_address   VARCHAR(100),
  station_aminities VARCHAR(150),
  city_code           INT,
   CONSTRAINT city_fk_station
    FOREIGN KEY (city_code)
    REFERENCES city(city_code)
    on update restrict 
    on delete restrict
);

CREATE TABLE employees
(
  employee_id        		INT            PRIMARY KEY 		AUTO_INCREMENT,
  employee_name      		VARCHAR(50),
  employee_age       		VARCHAR(3),
  employee_sex       		VARCHAR(15),
  employee_address   		VARCHAR(60),
  employee_shift_timings    VARCHAR(30),
  employee_salary           VARCHAR(30)
  );

CREATE TABLE passenger
(
  passenger_id        INT            PRIMARY KEY 		AUTO_INCREMENT,
  passenger_name	  VARCHAR(50),
  passenger_age       VARCHAR(3),
  passenger_sex       VARCHAR(15),
  passenger_address   VARCHAR(60)
);

CREATE TABLE line
(
  line_name        VARCHAR(10)        PRIMARY KEY 
);

CREATE TABLE route
(
  route_id        INT            PRIMARY KEY 		AUTO_INCREMENT,
  route_length    INT,
  line_name          VARCHAR(10),
   CONSTRAINT line_fk_route
    FOREIGN KEY (line_name)
    REFERENCES line (line_name)
    on update cascade
    on delete cascade
);

CREATE TABLE tram
(
  tram_id        INT            PRIMARY KEY,
  tram_name      VARCHAR(60),
  days           VARCHAR(20),
  timing         VARCHAR(20),
  route_id		 INT,
  CONSTRAINT route_fk_tram
    FOREIGN KEY (route_id)
    REFERENCES route(route_id)
    on update cascade
    on delete cascade
);



CREATE TABLE motorman
(
  license_id        INT            PRIMARY KEY,
  tram_experience   VARCHAR(80),
  employee_id			INT			UNIQUE,
   CONSTRAINT employees_fk_motorman
    FOREIGN KEY (employee_id)
    REFERENCES employees (employee_id)
    on update cascade
    on delete cascade
);

CREATE TABLE manager
(
  employee_id       INT unique,
  station_id		INT unique,
  
  CONSTRAINT `PK_employee_station` PRIMARY KEY (employee_id, station_id),
  
 CONSTRAINT employees_fk_manager
    FOREIGN KEY (employee_id)
    REFERENCES employees (employee_id)
    on update cascade
    on delete cascade,
    
   CONSTRAINT station_fk_manager
    FOREIGN KEY (station_id)
    REFERENCES station (station_id)  
    on update cascade
    on delete cascade
);

CREATE TABLE administrative_staff
(
	responsibilities VARCHAR(100),
    staff_type       VARCHAR(10),
    employee_id      INT unique,
    station_id		 INT ,
    
    CONSTRAINT `PK_employee_station` PRIMARY KEY (employee_id, station_id),
    
  CONSTRAINT employees_fk_administrative_staff
    FOREIGN KEY (employee_id)
    REFERENCES employees (employee_id)
    on update cascade
    on delete cascade,
    
   CONSTRAINT station_fk_administrative_staff
    FOREIGN KEY (station_id)
    REFERENCES station (station_id)  
    on update cascade
    on delete cascade
);

CREATE TABLE cargo_unit
(
    tram_id				INT		PRIMARY KEY,
	cargo_capacity 		INT,
    cargo_blocks       	INT,
    CONSTRAINT tram_fk_cargo_unit
    FOREIGN KEY (tram_id)
    REFERENCES tram (tram_id)
	on update cascade
    on delete cascade
);

CREATE TABLE ticket
(
	ticket_id 		INT PRIMARY KEY auto_increment,
    date_time       datetime,
    route_id        INT,
    passenger_id	INT,
    employee_id		INT,
    tram_id			INT,
    CONSTRAINT route_fk_ticket
    FOREIGN KEY (route_id)
    REFERENCES route(route_id)
    on update No Action
    on delete No action,
    
    CONSTRAINT passenger_fk_ticket
    FOREIGN KEY (passenger_id)
    REFERENCES passenger (passenger_id)
    on update No Action
    on delete No action,
    
    CONSTRAINT administrative_staff_fk_ticket
    FOREIGN KEY (employee_id)
    REFERENCES administrative_staff (employee_id)
    on update No Action
    on delete No action,
    
    CONSTRAINT tram_fk_ticket
    FOREIGN KEY (tram_id)
    REFERENCES tram (tram_id)
    on update No Action
    on delete No action
);

CREATE TABLE luggage
(
	luggage_id 			INT PRIMARY KEY 		AUTO_INCREMENT,
    luggage_type        VARCHAR(30),
    luggage_weight		INT,
    tram_id				INT,
    ticket_id			INT,
     CONSTRAINT tram_fk_luggage
    FOREIGN KEY (tram_id)
    REFERENCES tram (tram_id)
    on update restrict
    on delete restrict,
    CONSTRAINT ticket_fk_luggage
    FOREIGN KEY (ticket_id)
    REFERENCES ticket (ticket_id)
    on update cascade
    on delete cascade
);

CREATE TABLE `route_station`
(
    `route_id` INT NOT NULL,
    `station_id` INT NOT NULL,
    stop_no		INT NOT NULL,
    CONSTRAINT `PK_rs` PRIMARY KEY  (`route_id`, `station_id`),
    CONSTRAINT rs_fk_route
    FOREIGN KEY (route_id)
    REFERENCES route (route_id)
    on update cascade
    on delete cascade,
    
    CONSTRAINT rs_fk_station
    FOREIGN KEY (station_id)
    REFERENCES station (station_id)
    on update cascade
    on delete cascade
);

create table motorman_tram
(
	employee_id		INT NOT NULL,
    tram_id			INT NOT NULL,
    CONSTRAINT `PK_motorman_tram` PRIMARY KEY  (`employee_id`, `tram_id`),
    CONSTRAINT motorman_tram_fk_motorman
    FOREIGN KEY (employee_id)
    REFERENCES motorman (employee_id)
    on update cascade
    on delete cascade,
    
    CONSTRAINT motorman_tram_fk_tram
    FOREIGN KEY (tram_id)
    REFERENCES tram (tram_id)
    on update cascade
    on delete cascade
);