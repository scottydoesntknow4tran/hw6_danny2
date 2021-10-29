/**********************************************************************
 * NAME: Scott Tornquist
 * CLASS: Database Systems
 * DATE: 10/19/2021
 * HOMEWORK: HW#5A
 * DESCRIPTION: CIA World Factbook table making practice
 **********************************************************************/


-- TODO: add drop table statements
SET FOREIGN_KEY_CHECKS=0;
drop table if exists country;
drop table if exists province;
drop table if exists city;
drop table if exists border;
SET FOREIGN_KEY_CHECKS=1;
-- TODO: add create table statements
create table country (
    country_code VARCHAR(10) not null,
    country_name text not null,
    gdp int,
    inflation double,
    primary key (country_code)
);

create table province(
    province_name VARCHAR(20) not null,
    country_code VARCHAR(10) not null,
    area int,
    primary key (province_name, country_code),
    foreign key (country_code) references country(country_code)
);

create table city(
    city_name VARCHAR(20) not null,
    province_name VARCHAR(20) not null,
    country_code VARCHAR(10) not null,
    population_ int,
    primary key (city_name, province_name, country_code),
    foreign KEY (province_name, country_code) references province(province_name, country_code)
);

create table border(
    country_code_1 VARCHAR(10) not null,
    country_code_2 VARCHAR(10) not null,
    border_length int unsigned,
    primary key (country_code_1, country_code_2),
    foreign key (country_code_1) references country(country_code),
    foreign key (country_code_1) references country(country_code),
    check (country_code_1 != country_code_2)
);


-- TODO: add insert statements
insert into country values ('USA','United States of America', 100, 6.9);
insert into country values ('MEX','Mexico', 90, 5.9);
insert into country values ('CAN','Canada', 101, 4.9);

insert into province values ('Washington','USA', 100000);
insert into province values ('Oregon','USA', 1000100);
insert into province values ('Idaho','USA', 900000);

insert into province values ('North','MEX', 100010);
insert into province values ('South','MEX', 1006000);
insert into province values ('East','MEX', 100770);

insert into province values ('Ontario','CAN', 200000);
insert into province values ('Brrrr','CAN', 2000020);
insert into province values ('Green','CAN', 2011000);

insert into city value ('Seattle','Washington','USA',300);
insert into city value ('Spokane','Washington','USA',1000);
insert into city value ('Sammamish','Washington','USA',300);

insert into city value ('Portland','Oregon','USA',304);
insert into city value ('Eugene','Oregon','USA',310);
insert into city value ('Beaverton','Oregon','USA',328);

insert into city value ('Coured Alene','Idaho','USA',7200);
insert into city value ('Potato','Idaho','USA',720);
insert into city value ('Boise','Idaho','USA',5723);

insert into city value ('Mexico City','North','MEX',4002);
insert into city value ('Puebla','North','MEX',232);
insert into city value ('Puerta Vallarta','North','MEX',720);

insert into city value ('a','South','MEX',720);
insert into city value ('b','South','MEX',60);
insert into city value ('c','South','MEX',645);

insert into city value ('qw','East','MEX',926);
insert into city value ('ok','East','MEX',2600);
insert into city value ('eb','East','MEX',684);

insert into city value ('Alberta','Ontario','CAN',926);
insert into city value ('Vancouver','Ontario','CAN',860);
insert into city value ('Alberkerky','Ontario','CAN',760);

insert into city value ('gy','Brrrr','CAN',670);
insert into city value ('qt','Brrrr','CAN',8656);
insert into city value ('ls','Brrrr','CAN',6872);

insert into city value ('po','Green','CAN',951);
insert into city value ('kn','Green','CAN',337);
insert into city value ('tc','Green','CAN',7014);

insert into border value ('USA','MEX',1005);
insert into border value ('USA','CAN',2060);

-- TODO: add select statements (to print tables)

select * from country;
select * from province;
select * from city;
select * from border;

