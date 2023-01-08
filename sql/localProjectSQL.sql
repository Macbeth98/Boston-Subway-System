create database projectdbms;
use projectdbms;
CREATE TABLE `city` (
  `city_code` int(11) NOT NULL AUTO_INCREMENT,
  `city_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`city_code`),
  UNIQUE KEY `city_state_name` (`state_name`,`city_name`)
) ;

CREATE TABLE `station` (
  `station_id` int(11) NOT NULL AUTO_INCREMENT,
  `station_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `station_address` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `station_aminities` varchar(150) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city_code` int(11) DEFAULT NULL,
  PRIMARY KEY (`station_id`),
  UNIQUE KEY `station_name` (`station_name`),
  KEY `city_fk_station` (`city_code`),
  CONSTRAINT `city_fk_station` FOREIGN KEY (`city_code`) REFERENCES `city` (`city_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ;


CREATE TABLE `employees` (
  `employee_id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `employee_dob` date NOT NULL,
  `employee_sex` enum('M','F') COLLATE utf8_unicode_ci DEFAULT NULL,
  `employee_address` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `employee_shift_timings` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `employee_salary` int(11) NOT NULL,
  PRIMARY KEY (`employee_id`)
) ;

CREATE TABLE `passenger` (
  `passenger_id` int(11) NOT NULL AUTO_INCREMENT,
  `passenger_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `passenger_email` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `passenger_dob` date DEFAULT NULL,
  `passenger_sex` enum('M','F') COLLATE utf8_unicode_ci DEFAULT NULL,
  `passenger_address` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`passenger_id`),
  UNIQUE KEY `passenger_email_UNIQUE` (`passenger_email`)
);

CREATE TABLE `line` (
  `line_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`line_name`)
) ;

CREATE TABLE `route` (
  `route_id` int(11) NOT NULL AUTO_INCREMENT,
  `route_length` int(11) DEFAULT NULL,
  `line_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`route_id`),
  KEY `line_fk_route` (`line_name`),
  CONSTRAINT `line_fk_route` FOREIGN KEY (`line_name`) REFERENCES `line` (`line_name`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `tram` (
  `tram_id` int(11) NOT NULL,
  `tram_name` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `days` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `timing` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `route_id` int(11) NOT NULL,
  `reverse` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`tram_id`),
  KEY `route_fk_tram` (`route_id`),
  CONSTRAINT `route_fk_tram` FOREIGN KEY (`route_id`) REFERENCES `route` (`route_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `motorman` (
  `license_id` int(11) NOT NULL,
  `tram_experience` int(11) NOT NULL,
  `employee_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`license_id`),
  UNIQUE KEY `employee_id` (`employee_id`),
  CONSTRAINT `employees_fk_motorman` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE `manager` (
  `employee_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  PRIMARY KEY (`employee_id`,`station_id`),
  UNIQUE KEY `employee_id` (`employee_id`),
  UNIQUE KEY `station_id` (`station_id`),
  CONSTRAINT `employees_fk_manager` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `station_fk_manager` FOREIGN KEY (`station_id`) REFERENCES `station` (`station_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

CREATE TABLE `administrative_staff` (
  `responsibilities` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `staff_type` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `employee_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  PRIMARY KEY (`employee_id`,`station_id`),
  UNIQUE KEY `employee_id` (`employee_id`),
  KEY `station_fk_administrative_staff` (`station_id`),
  CONSTRAINT `employees_fk_administrative_staff` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `station_fk_administrative_staff` FOREIGN KEY (`station_id`) REFERENCES `station` (`station_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `cargo_unit` (
  `tram_id` int(11) NOT NULL,
  `cargo_capacity` int(11) DEFAULT NULL,
  `cargo_blocks` int(11) DEFAULT NULL,
  PRIMARY KEY (`tram_id`),
  CONSTRAINT `tram_fk_cargo_unit` FOREIGN KEY (`tram_id`) REFERENCES `tram` (`tram_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

CREATE TABLE `route_station` (
  `route_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `stop_no` int(11) NOT NULL,
  PRIMARY KEY (`route_id`,`station_id`),
  KEY `rs_fk_station` (`station_id`),
  CONSTRAINT `rs_fk_route` FOREIGN KEY (`route_id`) REFERENCES `route` (`route_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rs_fk_station` FOREIGN KEY (`station_id`) REFERENCES `station` (`station_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

CREATE TABLE `ticket` (
  `ticket_id` int(11) NOT NULL AUTO_INCREMENT,
  `date_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `station_id` int(11) DEFAULT NULL,
  `route_id` int(11) DEFAULT NULL,
  `passenger_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `tram_id` int(11) DEFAULT NULL,
  `luggage` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ticket_id`),
  KEY `rs_fk_route_station` (`route_id`,`station_id`),
  KEY `passenger_fk_ticket` (`passenger_id`),
  KEY `administrative_staff_fk_ticket` (`employee_id`),
  KEY `tram_fk_ticket` (`tram_id`),
  CONSTRAINT `administrative_staff_fk_ticket` FOREIGN KEY (`employee_id`) REFERENCES `administrative_staff` (`employee_id`),
  CONSTRAINT `passenger_fk_ticket` FOREIGN KEY (`passenger_id`) REFERENCES `passenger` (`passenger_id`),
  CONSTRAINT `rs_fk_route_station` FOREIGN KEY (`route_id`, `station_id`) REFERENCES `route_station` (`route_id`, `station_id`),
  CONSTRAINT `tram_fk_ticket` FOREIGN KEY (`tram_id`) REFERENCES `tram` (`tram_id`)
);

CREATE TABLE `luggage` (
  `luggage_id` int(11) NOT NULL AUTO_INCREMENT,
  `luggage_type` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `luggage_weight` int(11) DEFAULT NULL,
  `tram_id` int(11) DEFAULT NULL,
  `ticket_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`luggage_id`),
  KEY `tram_fk_luggage` (`tram_id`),
  KEY `ticket_fk_luggage` (`ticket_id`),
  CONSTRAINT `ticket_fk_luggage` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`ticket_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tram_fk_luggage` FOREIGN KEY (`tram_id`) REFERENCES `tram` (`tram_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ;



CREATE TABLE `motorman_tram` (
  `employee_id` int(11) NOT NULL,
  `tram_id` int(11) NOT NULL,
  PRIMARY KEY (`employee_id`,`tram_id`),
  KEY `motorman_tram_fk_tram` (`tram_id`),
  CONSTRAINT `motorman_tram_fk_motorman` FOREIGN KEY (`employee_id`) REFERENCES `motorman` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `motorman_tram_fk_tram` FOREIGN KEY (`tram_id`) REFERENCES `tram` (`tram_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ;

INSERT INTO `city` VALUES (1,"Boston","MA");

INSERT INTO `station` VALUES (1,"Downtown Crossing","1 Down Street","Parking",1);
INSERT INTO `station` VALUES (2,"Park St","2 Park Street","ATM",1);
INSERT INTO `station` VALUES (3,"State","4 Down State","Lounge",1);
INSERT INTO `station` VALUES (4,"Govt Center","3 Center street","Parking",1);
INSERT INTO `station` VALUES (5,"Ruggles","1 Rugg Street","ATM",1);
INSERT INTO `station` VALUES (6,"Stony Brook","4 Brook Ave","Lounge",1);
INSERT INTO `station` VALUES (7,"JFK","2 Umass Ave","Parking",1);
INSERT INTO `station` VALUES (8,"Shawmut","3 Pond Ave","Parking",1);
INSERT INTO `station` VALUES (9,"Wollaston","3 Wood Street","Lounge",1);
INSERT INTO `station` VALUES (10,"South St","4 South street","Lounge",1);
INSERT INTO `station` VALUES (11,"Kent St","2 king street","Parking",1);
INSERT INTO `station` VALUES (12,"Newton Centre","22 center street","Parking",1);
INSERT INTO `station` VALUES (13,"Symphony","2 huntington ave","Parking",1);
INSERT INTO `station` VALUES (14,"Harvard","3 harvard sq","Parking",1);
INSERT INTO `station` VALUES (15,"Wood Island","34 wood ave","Lounge",1);
INSERT INTO `station` VALUES (16,"Assembly","21 assembly ave","ATM",1);
INSERT INTO `station` VALUES (17,"Copley","27 Copley St","ATM, Lounge",1);
INSERT INTO `station` VALUES (18,"BU Central","7 Central St","ATM, Lounge",1);
INSERT INTO `station` VALUES (19,"Longwood","2 Long St","ATM",1);
INSERT INTO `station` VALUES (20,"Union Square","28 Union St","ATM",1);
INSERT INTO `station` VALUES (21,"Alewife","30 Alewife Ave","ATM",1);


INSERT INTO `line` VALUES ("Green Line B");
INSERT INTO `line` VALUES ("Green Line C");
INSERT INTO `line` VALUES ("Green Line D");
INSERT INTO `line` VALUES ("Green Line E");
INSERT INTO `line` VALUES ("Orange Line");
INSERT INTO `line` VALUES ("Red Line");
INSERT INTO `line` VALUES ("Red Line M");
INSERT INTO `line` VALUES ("Blue Line");

delete from line;



INSERT INTO `route` VALUES (1,100,"Green Line B");
INSERT INTO `route` VALUES (2,200,"Green Line C");
INSERT INTO `route` VALUES (3,100,"Green Line D");
INSERT INTO `route` VALUES (4,400,"Green Line E");
INSERT INTO `route` VALUES (5,200,"Red Line");
INSERT INTO `route` VALUES (6,100,"Red Line M");
INSERT INTO `route` VALUES (7,100,"Blue Line");
INSERT INTO `route` VALUES (8,100,"Orange Line");

select * from route;

select * from station;

INSERT INTO `route_station` VALUES(1,10,1);
INSERT INTO `route_station` VALUES(1,18,2);
INSERT INTO `route_station` VALUES(1,17,3);
INSERT INTO `route_station` VALUES(1,2,4);
INSERT INTO `route_station` VALUES(1,4,5);
INSERT INTO `route_station` VALUES(1,20,6);


INSERT INTO `route_station` VALUES(3,12,1);
INSERT INTO `route_station` VALUES(3,19,2);
INSERT INTO `route_station` VALUES(3,17,3);
INSERT INTO `route_station` VALUES(3,2,4);
INSERT INTO `route_station` VALUES(3,4,5);
INSERT INTO `route_station` VALUES(3,20,6);

-- Red line
INSERT INTO `route_station` VALUES(5,9,1);
INSERT INTO `route_station` VALUES(5,7,2);
INSERT INTO `route_station` VALUES(5,1,3);
INSERT INTO `route_station` VALUES(5,2,4);
INSERT INTO `route_station` VALUES(5,14,5);
INSERT INTO `route_station` VALUES(5,21,6);

-- Orange Line
INSERT INTO `route_station` VALUES(8,6,1);
INSERT INTO `route_station` VALUES(8,5,2);
INSERT INTO `route_station` VALUES(8,1,3);
INSERT INTO `route_station` VALUES(8,3,4);
INSERT INTO `route_station` VALUES(8,16,5);


INSERT INTO `tram` VALUES (1,"South St","Mon/Tue/Wed","9am-1am",1, true);
INSERT INTO `tram` VALUES (2,"Newton Centre","Mon/Tue/Wed","9am-1am",3, true);

INSERT INTO `tram` VALUES (3,"Union Square","Thu/Fri/Sat","9am-10pm",1, false);
INSERT INTO `tram` VALUES (4,"Union Square","Thu/Fri/Sat","9am-10pm",3, false);


INSERT INTO `tram` VALUES (5,"Wollaston","Mon/Tue/Wed","9am-1am",5, true);
INSERT INTO `tram` VALUES (6,"Alewife","Mon/Tue/Wed","9am-1am",5, false);

INSERT INTO `tram` VALUES (7,"Stony Brook","Mon/Tue/Wed","9am-6pm",8, true);
INSERT INTO `tram` VALUES (8,"Assembly","Mon/Tue/Wed","9am-6pm",8, false);

INSERT INTO `cargo_unit` VALUES(1,200,4);
INSERT INTO `cargo_unit` VALUES(2,300,5);
INSERT INTO `cargo_unit` VALUES(3,100,3);
INSERT INTO `cargo_unit` VALUES(4,300,2);
INSERT INTO `cargo_unit` VALUES(5,200,5);
INSERT INTO `cargo_unit` VALUES(6,100,3);
INSERT INTO `cargo_unit` VALUES(7,100,3);
INSERT INTO `cargo_unit` VALUES(8,100,3);

select employee_dob from employees;


INSERT INTO `employees` VALUES (1, "smith",'1988-5-07',"M","1 Parker Street","7am to 3pm",20);
INSERT INTO `employees` VALUES (2, "damon",'1989-5-09',"M","2 marcella Street","9am to 4pm",21);
INSERT INTO `employees` VALUES (3, "tina",'1985-6-17',"F","22 calumet Street","3pm to 6pm",20);
INSERT INTO `employees` VALUES (4, "taylor",'1982-9-27',"M","1 smith Street","3pm to 6pm",20);
INSERT INTO `employees` VALUES (5, "gracia",'1989-5-16',"F","2 stagecoach rd","3pm to 6pm",20);
INSERT INTO `employees` VALUES (6, "sylvie",'1995-5-27',"F","10 Hill Street","7am to 3pm",20);
INSERT INTO `employees` VALUES (7, "Ashwin",'1990-8-17',"M","5 green Street","8am to 4pm",30);
INSERT INTO `employees` VALUES (8, "Aswath",'1992-3-15',"M","221 Parker Street","5pm to 1am",30);
INSERT INTO `employees` VALUES (9, "Janani",'1996-9-14',"F","12 smith Street","6pm to 1am",30);
INSERT INTO `employees` VALUES (10, "Madhu",'1988-8-24',"F","2 Center Street","9am to 3pm",30);
INSERT INTO `employees` VALUES (11, "James",'1993-11-07',"M","2 Green Street","9am to 3pm",30);
INSERT INTO `employees` VALUES (12, "Noah",'1987-7-12',"M","5 South Street","6pm to 1am",30);
INSERT INTO `employees` VALUES (13, "Jack",'1995-5-17',"M","45 Center Street","6pm to 1am",30);
INSERT INTO `employees` VALUES (14, "Liam",'1988-5-13',"M","8 Main Street","6pm to 1am",30);
INSERT INTO `employees` VALUES (15, "Anthony",'1994-10-03',"M","22 Parker Hill Ave","9am to 3pm",30);
INSERT INTO `employees` VALUES (16, "Aditi",'1996-4-13',"F","25 Parker Hill Ave","6pm to 1am",20);
INSERT INTO `employees` VALUES (17, "Neha",'1986-7-07',"F","22 Mission Main Ave","9am to 5pm",20);
INSERT INTO `employees` VALUES (18, "Naveen",'1988-6-17',"M","256 Center Street","2pm to 10pm",30);

insert into employees values (19, 'Arte Harms', '1991-9-18', 'F', '5543 Elmside Drive', '5 AM to 2 PM', 55);
insert into employees values (20, 'Giorgio Lambregts', '1997-09-10', 'F', '2 Ridgeview Point', '6 PM to 3AM', 61);
insert into employees values (21, 'Fayina Garrity', '1998-01-11', 'F', '9965 Veith Junction', '2 PM to 9 PM', 51);
insert into employees values (22, 'Ginger Cunde', '1996-01-22', 'M', '12784 Eagan Lane', '2pm to 4pm', 40);

insert into employees values (23, 'Claus Denne', '1989-9-11', 'F', '63 Holmberg Trail', '1pm to 9pm', 92); 
insert into employees values (24, 'Denny Tremollet', '1997-3-31', 'F', '68746 Bunker Hill Court', '9am to 5pm', 68);
insert into employees values (25, 'Marsha Woodings', '1998-4-25', 'M', '313 Oak Crossing', '10am to 6pm', 98);
insert into employees values (26, 'Pascale Favel', '1997-2-25', 'M', '22 Continental Place', '8am to 5pm', 33);
insert into employees values (27, 'Yorke Yewman', '1988-07-11', 'F', '3 West Street', '3pm to 10pm', 62);
insert into employees values (28, 'Fayre Brandino', '1987-7-8', 'M', '70285 Chinook Junction', '4pm to 12am', 58);
insert into employees values (29, 'Alon Purdie', '2000-7-18', 'F', '28414 Cottonwood Parkway', '2pm to 10pm', 27);
insert into employees values (30, 'Petronilla Mathewes', '1999-8-26', 'M', '30 Butternut Park', '10am to 4pm', 70);
insert into employees values (31, 'Erroll Parysiak', '1987-9-11', 'M', '372 Golden Leaf Trail', '10am to 6pm', 69);
insert into employees values (32, 'Genvieve Ysson', '1991-9-12', 'M', '8 Hoffman Alley', '9am to 5pm', 52);
insert into employees values (33, 'Ximenez Metzig', '1991-3-5', 'F', '3097 Anderson Avenue', '10am to 6pm', 82);
insert into employees values (34, 'Adelind Frankiss', '1998-10-27', 'F', '500 Carioca Junction', '6pm to 1am', 27);
insert into employees values (35, 'Mart Sherme', '1987-3-27', 'M', '4381 Farragut Place', '6pm to 12am', 89);
insert into employees values (36, 'Iggie McIlharga', '2000-8-24', 'F', '6105 Larry Street', '4pm to 10pm', 51);
insert into employees values (37, 'Britni Gerding', '1996-7-14', 'F', '9374 Mosinee Hill', '3pm to 10pm', 62);
insert into employees values (38, 'Vevay Kunkler', '1998-7-8', 'M', '8872 Laurel Place', '8am to 4pm', 51);
insert into employees values (39, 'Stevy Tuffield', '1995-11-20', 'F', '16227 Kipling Park', '12pm tp 7pm', 27);
insert into employees values (40, 'Lavena Acreman', '1997-3-1', 'M', '0 Old Shore Park', '11am to 6pm', 75);
insert into employees values (41, 'Morena Reach', '1987-6-9', 'F', '993 Kim Circle', '10am to 6pm', 75);
insert into employees values (42, 'Consalve Milhench', '1997-11-20', 'M', '488 Sachtjen Junction', '10am to 5pm', 56);
insert into employees values (43, 'Phoebe Osburn', '2994-6-8', 'M', '82 Oak Circle', '4pm to 11pm', 41);
insert into employees values (44, 'Paulie Simoncini', '1994-9-20', 'F', '939 Oxford Crossing', '3pm to 10pm', 91);
insert into employees values (45, 'Man Rounsefull', '1990-11-10', 'M', '692 Melvin Road', '3pm to 11pm', 29);
insert into employees values (46, 'Archaimbaud Keepe', '1981-1-21', 'F', '6039 Del Mar Hill', '4pm to 11pm', 30);
insert into employees values (47, 'Robby Faithfull', '2000-1-14', 'M', '39964 Sutherland Circle', '9am to 4pm', 76);
insert into employees values (48, 'Stavro Gamlin', '1990-3-16', 'F', '2 Maple Drive', '10am to 5pm', 93);
insert into employees values (49, 'Jeno Shoulders', '1996-1-24', 'F', '59879 Kensington Park', '9am to 4pm', 91);
insert into employees values (50, 'Clerkclaude Feenan', '1986-8-23', 'M', '397 Troy Center', '10am to 5pm', 91);

select * from employees;

insert into administrative_staff (employee_id, station_id, staff_type, responsibilities) values (1, 1, 'Admin', 'Checking');
insert into administrative_staff (employee_id, station_id, staff_type, responsibilities) values (2, 2, 'Admin', 'Issuing');
insert into administrative_staff (employee_id, station_id, staff_type, responsibilities) values (3, 3, 'Admin', 'Checking');
insert into administrative_staff (employee_id, station_id, staff_type, responsibilities) values (4, 4, 'Admin', 'Issuing');
insert into administrative_staff (employee_id, station_id, staff_type, responsibilities) values (5, 5, 'Admin', 'Issuing');
insert into administrative_staff (employee_id, station_id, staff_type, responsibilities) values (6, 6, 'Admin', 'Issuing');
insert into administrative_staff (employee_id, station_id, staff_type, responsibilities) values (7, 7, 'Admin', 'Issuing');
insert into administrative_staff (employee_id, station_id, staff_type, responsibilities) values (8, 8, 'Admin', 'Checking');
insert into administrative_staff (employee_id, station_id, staff_type, responsibilities) values (9, 9, 'Admin', 'Checking');
insert into administrative_staff (employee_id, station_id, staff_type, responsibilities) values (10, 10, 'Admin', 'Checking');
insert into administrative_staff (employee_id, station_id, staff_type, responsibilities) values (11, 11, 'Admin', 'Checking');
insert into administrative_staff (employee_id, station_id, staff_type, responsibilities) values (12, 12, 'Admin', 'Issuing');
insert into administrative_staff (employee_id, station_id, staff_type, responsibilities) values (13, 13, 'Admin', 'Checking');
insert into administrative_staff (employee_id, station_id, staff_type, responsibilities) values (14, 14, 'Admin', 'Checking');
insert into administrative_staff (employee_id, station_id, staff_type, responsibilities) values (15, 15, 'Admin', 'Issuing');
insert into administrative_staff (employee_id, station_id, staff_type, responsibilities) values (16, 16, 'Admin', 'Checking');
insert into administrative_staff (employee_id, station_id, staff_type, responsibilities) values (17, 17, 'Admin', 'Checking');
insert into administrative_staff (employee_id, station_id, staff_type, responsibilities) values (18, 18, 'Admin', 'Checking');
insert into administrative_staff (employee_id, station_id, staff_type, responsibilities) values (19, 19, 'Admin', 'Issuing');
insert into administrative_staff (employee_id, station_id, staff_type, responsibilities) values (20, 20, 'Admin', 'Checking');
insert into administrative_staff (employee_id, station_id, staff_type, responsibilities) values (21, 21, 'Admin', 'Checking');
insert into administrative_staff (employee_id, station_id, staff_type, responsibilities) values (51, 1, 'Worker', 'Ticket checking');


-- manager
insert into manager (employee_id, station_id) values (42, 1);
insert into manager (employee_id, station_id) values (22, 2);
insert into manager (employee_id, station_id) values (23, 3);
insert into manager (employee_id, station_id) values (24, 4);
insert into manager (employee_id, station_id) values (25, 5);
insert into manager (employee_id, station_id) values (26, 6);
insert into manager (employee_id, station_id) values (27, 7);
insert into manager (employee_id, station_id) values (28, 8);
insert into manager (employee_id, station_id) values (29, 9);
insert into manager (employee_id, station_id) values (30, 10);
insert into manager (employee_id, station_id) values (31, 11);
insert into manager (employee_id, station_id) values (32, 12);
insert into manager (employee_id, station_id) values (33, 13);
insert into manager (employee_id, station_id) values (34, 14);
insert into manager (employee_id, station_id) values (35, 15);
insert into manager (employee_id, station_id) values (36, 16);
insert into manager (employee_id, station_id) values (37, 17);
insert into manager (employee_id, station_id) values (38, 18);
insert into manager (employee_id, station_id) values (39, 19);
insert into manager (employee_id, station_id) values (40, 20);
insert into manager (employee_id, station_id) values (41, 21);

-- motorman
insert into motorman (license_id, tram_experience, employee_id) values (766024, 10, 43);
insert into motorman (license_id, tram_experience, employee_id) values (751348, 5, 44);
insert into motorman (license_id, tram_experience, employee_id) values (782479, 3, 45);
insert into motorman (license_id, tram_experience, employee_id) values (721270, 9, 46);
insert into motorman (license_id, tram_experience, employee_id) values (840108, 9, 47);
insert into motorman (license_id, tram_experience, employee_id) values (822709, 5, 48);
insert into motorman (license_id, tram_experience, employee_id) values (787520, 5, 49);
insert into motorman (license_id, tram_experience, employee_id) values (919604, 4, 50);


INSERT INTO `passenger` VALUES (1, "emma","emma@gmail.com",'1998-5-13',"F","1 Pond Street");
INSERT INTO `passenger` VALUES (2, "amelia","amelia@gmail.com",'1988-5-21',"F","2 moon Street");
INSERT INTO `passenger` VALUES (3, "Steve","steve@gmail.com",'1977-7-26',"M","1 smith Street");
INSERT INTO `passenger` VALUES (4, "Gabriel","gabriel@gmail.com",'1986-3-25',"F","5 Pond Street");
INSERT INTO `passenger` VALUES (5, "Sophia","sophia@gmail.com",'1991-6-17',"F","1 charles Street");
INSERT INTO `passenger` VALUES (6, "Scarlett","scarlett@gmail.com",'1992-4-26',"F","2 Mass Street");
INSERT INTO `passenger` VALUES (7, "Lucas","lucas@gmail.com",'1996-5-16',"M","1 carson Street");
INSERT INTO `passenger` VALUES (8, "Liam","liam@gmail.com",'1995-7-18',"M","2 Carson Street");
INSERT INTO `passenger` VALUES (9, "Grace","grace@gmail.com",'1989-5-16',"F","23 charles Street");
INSERT INTO `passenger` VALUES (10, "Emily","emily@gmail.com",'1997-6-27',"F","1 shawmut ave");
INSERT INTO `passenger` VALUES (11, "Olivia","olivia@gmail.com",'1999-3-10',"F","1 huntington ave");
INSERT INTO `passenger` VALUES (12, "Stevie","stevie@gmail.com",'1982-8-13',"F","11 smith Street");

drop function createTicket;

delimiter $$
create function createTicket(
	station_id int, route_id int, passenger_id int, 
    employee_id int, tram_id int, luggage Boolean
)
RETURNS INT
DETERMINISTIC READS SQL DATA
begin
	declare date_time DateTime;
    declare insertId int;
    
    IF station_id IS NULL THEN
		SIGNAL SQLSTATE '23000'
			SET MESSAGE_TEXT = 'Fatal cannot be null', MYSQL_ERRNO = 1048 ;
    END IF;
    
    IF route_id IS NULL THEN
		SIGNAL SQLSTATE '23000'
			SET MESSAGE_TEXT = 'Attack date cannot be null', MYSQL_ERRNO = 1048 ;
    END IF;
    
    IF passenger_id IS NULL THEN
		SIGNAL SQLSTATE '23000'
			SET MESSAGE_TEXT = 'Town cannot be null', MYSQL_ERRNO = 1048 ;
    END IF;
    
    IF employee_id IS NULL THEN
		SIGNAL SQLSTATE '23000'
			SET MESSAGE_TEXT = 'State cannot be null', MYSQL_ERRNO = 1048 ;
    END IF;
    
    IF tram_id IS NULL THEN
		SIGNAL SQLSTATE '23000'
			SET MESSAGE_TEXT = 'State cannot be null', MYSQL_ERRNO = 1048 ;
    END IF;
    
    IF luggage IS NULL THEN
		SIGNAL SQLSTATE '23000'
			SET MESSAGE_TEXT = 'State cannot be null', MYSQL_ERRNO = 1048 ;
    END IF;
    
    set date_time = Now();
    insert into ticket values (0, date_time, station_id, route_id, passenger_id, employee_id, tram_id, luggage);
    set insertId = (select LAST_INSERT_ID());
    return insertId;
end $$
delimiter ;


select createTicket(10, 1, 1, 1, 1, false);

select createTicket(10,1,2,1,1,false);
select createTicket(10,1,3,1,1,false);
select createTicket(10,1,4,1,1,false);
select createTicket(10,1,5,1,1,false);
select createTicket(10,1,6,1,1,false);



select createTicket(12,3,1,2,2,false);
select createTicket(12,3,7,2,2,false);
select createTicket(12,3,8,2,2,false);
select createTicket(12,3,9,2,2,false);
select createTicket(12,3,10,2,2,false);
select createTicket(12,3,11,2,2,false);
select createTicket(12,3,2,2,2,false);
select createTicket(12,3,3,2,2,false);
select createTicket(12,3,4,2,2,false);



select createTicket(19,3,1,3,2,false);
select createTicket(19,3,2,3,2,false);
select createTicket(19,3,3,3,2,false);
select createTicket(19,3,4,3,2,false);
select createTicket(19,3,5,3,2,false);
select createTicket(19,3,6,3,2,false);

select * from ticket;
delete from ticket;
insert into ticket values (null, null, 10, 1, 1, 1, 1, 0);


-- how many times a passenger has travelled in a route
drop procedure passengerroute;

DELIMITER //

 CREATE PROCEDURE passengerroute(IN rt_id INT)
 BEGIN
 
 IF rt_id IS NULL THEN
        SIGNAL SQLSTATE '23000' 
        SET MESSAGE_TEXT = 'Route id cannot be null', MYSQL_ERRNO = 1048 ;
 END IF;
 
 SELECT p.passenger_name, r.line_name, count(*) as travelled_in_route
 FROM ticket as t 
 INNER JOIN passenger as p on p.passenger_id = t.passenger_id 
 INNER JOIN route as r on r.route_id = t.route_id 
 WHERE t.route_id=rt_id
 GROUP BY p.passenger_id, r.route_id;
 
 END //
 
 delimiter ;

call passengerroute(1);


/*
	Routes being most used by Passengers.
*/
DELIMITER //
 CREATE PROCEDURE most_routes_used()
 BEGIN
 
 select r.*, coalesce(m.used_count, 0) as used_count from route as r left outer join (
	select route_id, count(*) as used_count from ticket group by route_id
 ) as m on r.route_id = m.route_id order by used_count desc;
 
 END //
 delimiter ;
 
 call most_routes_used();
 
 
 /*
	Routes previously travelled by Passenger.
 */
 drop procedure passenger_travel_history;
 
 DELIMITER //
 CREATE PROCEDURE passenger_travel_history(in passenger_id int)
 BEGIN
	IF passenger_id IS NULL THEN
        SIGNAL SQLSTATE '23000' 
        SET MESSAGE_TEXT = 'Route id cannot be null', MYSQL_ERRNO = 1048 ;
	END IF;
    
	select p.*, t.*, tr.*, r.*, s.* from passenger as p inner join ticket as t on p.passenger_id = t.passenger_id 
    inner join tram as tr on tr.tram_id = t.tram_id inner join route as r on r.route_id = t.route_id
    inner join station as s on s.station_id = t.station_id
    where p.passenger_id = passenger_id order by t.ticket_id desc;
 
 END //
 delimiter ;
 
 call passenger_travel_history(1);
 
 /*
	Get Passenger Tickets with Luggage Data.
 */
 Delimiter //
 create procedure get_passenger_tickets_with_luggage_data (in passenger_id int)
 BEGIN
	IF passenger_id IS NULL THEN
        SIGNAL SQLSTATE '23000' 
        SET MESSAGE_TEXT = 'Route id cannot be null', MYSQL_ERRNO = 1048 ;
	END IF;
    
	select t.*, l.* from ticket as t left outer join luggage as l on t.ticket_id = l.ticket_id;
 END //
 delimiter ;
 
 call get_passenger_tickets_with_luggage_data(1);
 


/*
      The cargo weight of a tram through the given time range. (Sum of the Weights).
*/

drop function tramcargoweight;

DELIMITER //
CREATE FUNCTION tramcargoweight(tr_id INT,dt_time varchar(30))
RETURNS INT
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE Total_weight INT;
    SELECT SUM(l.luggage_weight) INTO Total_weight
    FROM ticket ti
    INNER JOIN luggage l
    ON ti.ticket_id=l.ticket_id
    WHERE Date(ti.date_time) = Date(dt_time) AND ti.tram_id=tr_id;
    RETURN(Total_weight);
END //
delimiter ;

Select tramcargoweight(1, '2022-12-08'); 

select * from ticket;
select * from luggage;
delete from luggage;

/*
	Get tram with cargo data.
*/

select * from cargo_unit;

delimiter //
create procedure get_trams_with_cargo_data (in route_id int)
begin
	if route_id is null then
		select t.*, c.* from tram as t inner join cargo_unit as c on t.tram_id = c.tram_id;
	else
		select t.*, c.* from tram as t inner join cargo_unit as c on t.tram_id = c.tram_id where t.route_id = route_id; 
	end if;
end //
delimiter ;
call get_trams_with_cargo_data(null);
call get_trams_with_cargo_data("1");

/*
      Busy days of the week.
*/

drop procedure stationbusyday;

DELIMITER //
 CREATE PROCEDURE stationbusyday(IN inpfirstday datetime,IN inplastday datetime,IN inpstationid INT)
 BEGIN
 
 IF inpstationid IS NULL THEN
        SIGNAL SQLSTATE '23000' 
        SET MESSAGE_TEXT = 'Station id cannot be null', MYSQL_ERRNO = 1048 ;
 END IF;
 
 if inpfirstday IS NULL OR inplastday IS NULL THEN
 SELECT DATE(date_time) as date, count(*) AS Total_count
 FROM ticket
 WHERE  station_id=inpstationid
 GROUP BY DATE(date_time)
 ORDER BY Total_count DESC
 LIMIT 1;
 ELSE
 SELECT date_time,count(*) AS Total_count
 FROM ticket
 WHERE (date_time BETWEEN inpfirstday AND inplastday) AND station_id=inpstationid
 GROUP BY DATE(date_time)
 ORDER BY Total_count DESC
 LIMIT 1;
 END IF;
 END //
delimiter ;

CALL stationbusyday(null, null, 10);


-- Get the trams available for a route on a day. Like operator to match the days.   (Give route as some destination)

drop procedure tramsforroute;

DELIMITER //
 CREATE PROCEDURE tramsforroute(IN inprtid INT,IN inpday varchar(20))
 BEGIN
 -- DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT 'SQLException encountered' Message; 
 -- DECLARE EXIT HANDLER FOR SQLSTATE '23000' SELECT 'SQLSTATE 23000' ErrorCode;
 -- DECLARE TableNotFound CONDITION for 1146 ; 
 -- DECLARE EXIT HANDLER FOR TableNotFound SELECT 'Please create table first' Message; 
 IF inprtid IS NULL THEN
        SIGNAL SQLSTATE '23000'
        SET MESSAGE_TEXT = 'Route id cannot be null', MYSQL_ERRNO = 1048 ;
 END IF;
 IF inpday IS NULL THEN
        SIGNAL SQLSTATE '23000'
        SET MESSAGE_TEXT = 'Input day cannot be null', MYSQL_ERRNO = 1048 ;
 END IF;
 
 SELECT *
 FROM tram
  WHERE 
 route_id=1 
 AND
 days LIKE Concat('%$', inpday, '%') ESCAPE '$';
 END //
 delimiter ;
 
CALL tramsforroute(1, 'Tue');
 
 select * from tram;
 
 
 -- ALTER the passenger table to have cashback.
-- Create a Trigger to update the cashback value by 5 everytime the passenger buys a ticket.

ALTER TABLE passenger ADD cashback INT DEFAULT 0;

drop trigger cashback_trigger;

DELIMITER // 
CREATE TRIGGER cashback_trigger
AFTER INSERT ON ticket
FOR EACH ROW
BEGIN
	UPDATE passenger
           SET cashback = cashback + 1
           WHERE passenger_id = NEW.passenger_id;
END//
delimiter ;


/*
	Get stations in a route.
*/

drop procedure get_stations_in_route;

delimiter //
create procedure get_stations_in_route(in route_id int)
begin
	if route_id is null then 
		SIGNAL SQLSTATE '23000'
        SET MESSAGE_TEXT = 'Route id cannot be null', MYSQL_ERRNO = 1048 ;
	end if;
    
    select * from route_station as rs inner join station as s on rs.station_id = s.station_id where rs.route_id = route_id order by stop_no asc;
end //
delimiter ;

call get_stations_in_route(1);
select * from station;
select * from route_station;

/*
	get stations compatible for given station.
*/
drop procedure get_stations_for_given_station;

delimiter //
create procedure get_stations_for_given_station (in station_id_p int)
begin
	if station_id_p is null then 
		SIGNAL SQLSTATE '23000'
        SET MESSAGE_TEXT = 'Station id cannot be null', MYSQL_ERRNO = 1048 ;
	end if;
    
    select * from station where station_id in ( 
		select station_id from route_station where route_id in (select route_id from route_station where station_id = station_id_p) order by route_id, stop_no desc
    ) and station_id != station_id_p;
    
end //
delimiter ;

call get_stations_for_given_station(2);

/*
	get routes for a station.
*/
drop procedure routes_for_station;

delimiter //
create procedure routes_for_station(in station_id_p int)
begin
	if station_id_p is null then 
		SIGNAL SQLSTATE '23000'
        SET MESSAGE_TEXT = 'Station id cannot be null', MYSQL_ERRNO = 1048 ;
	end if;
    
    select * from route where route_id in (select route_id from route_station where station_id = station_id_p);
end //
delimiter ;

call routes_for_station(1);

-- get the trams from source and destination.

drop procedure get_tram_for_given_start_end_stations;

delimiter //
create procedure get_tram_for_given_start_end_stations (in start_station_id int, in end_station_id int)
begin
	declare start_route_id int;
    declare end_route_id int;
    
    if start_station_id is null then 
		SIGNAL SQLSTATE '23000'
        SET MESSAGE_TEXT = 'Start Station id cannot be null', MYSQL_ERRNO = 1048 ;
	end if;
    
    if end_station_id is null then 
		SIGNAL SQLSTATE '23000'
        SET MESSAGE_TEXT = 'End Station id cannot be null', MYSQL_ERRNO = 1048 ;
	end if;
    
    if start_station_id = end_station_id then
		SIGNAL SQLSTATE '23000'
        SET MESSAGE_TEXT = 'Start and End Station id cannot be the same', MYSQL_ERRNO = 1048 ;
	end if;
    
	select  t.*, rs1.route_id, rs1.stop_no as start_stop, rs2.stop_no as end_stop from (
	(select * from route_station where station_id = start_station_id) as rs1 
    inner join
    (select * from route_station where station_id = end_station_id) as rs2
    on rs1.route_id = rs2.route_id
	) inner join tram as t on rs1.route_id = t.route_id where t.reverse = (rs1.stop_no > rs2.stop_no);
end //
delimiter ;

call get_tram_for_given_start_end_stations(2, 1);

/*
	get route data for a tram
*/

drop procedure get_route_stations_for_tram;

delimiter //
create procedure get_route_stations_for_tram (in tram_id int)
begin
    
	if tram_id is null then 
		SIGNAL SQLSTATE '23000'
        SET MESSAGE_TEXT = 'Tram id cannot be null', MYSQL_ERRNO = 1048 ;
	end if;
    
     select s.*, rs.route_id, rs.stop_no from station as s inner join route_station as rs on s.station_id = rs.station_id 
     inner join tram as t on t.route_id = rs.route_id where t.tram_id = tram_id order by rs.stop_no;
     
end //
delimiter ;

call get_route_stations_for_tram(1);


/*
	Get route data for the given route.
*/
drop procedure get_route_data_for_route;

delimiter //
create procedure get_route_data_for_route (in route_id int)
begin
	if route_id is null then 
		SIGNAL SQLSTATE '23000'
        SET MESSAGE_TEXT = 'Tram id cannot be null', MYSQL_ERRNO = 1048 ;
	end if;
    
    select * from station as s inner join route_station as rs on s.station_id = rs.station_id where rs.route_id = route_id order by rs.stop_no;
end //
delimiter ;

call get_route_data_for_route(1);

select * from (select * from route_station where station_id = 1) as m;


select * from station;
select * from route_station;
select tram.* from route_station as rs inner join tram on tram.route_id = rs.route_id where rs.route_id = 1;
select * from ticket;
select * from route;
select * from tram;

-- Show Passenger
select * from passenger;
select * from passenger where passenger_email = "demouser@gmail.com";

/*    Get the number of times an employee has given ticket to a passenger for a route
*/

drop procedure passenger_emp_route;

DELIMITER //
CREATE PROCEDURE passenger_emp_route(IN rt_id INT)
BEGIN
	if rt_id is null then 
		SIGNAL SQLSTATE '23000'
        SET MESSAGE_TEXT = 'Route id cannot be null', MYSQL_ERRNO = 1048 ;
	end if;
SELECT passenger_name,employee_name,count(*)
FROM passenger p
INNER JOIN ticket t
ON p.passenger_id=t.passenger_id
INNER JOIN employees e
ON e.employee_id=t.employee_id
GROUP BY t.passenger_id,t.employee_id,rt_id;
END //
delimiter ;

CALL passenger_emp_route(5);










