/**********************************************************************
 * NAME: Scott Tornquist
 * CLASS: Database Management Systems
 * DATE: 10/28/21
 * HOMEWORK: 6
 * DESCRIPTION: Queries  on
 **********************************************************************/


-- HW5----------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO: add drop table statements
-- SET FOREIGN_KEY_CHECKS=0;
-- drop table if exists country;
-- drop table if exists province;
-- drop table if exists city;
-- drop table if exists border;
-- SET FOREIGN_KEY_CHECKS=1;
-- -- TODO: add create table statements
-- create table country (
--     country_code VARCHAR(10) not null,
--     country_name text not null,
--     gdp int,
--     inflation double,
--     primary key (country_code)
-- );

-- create table province(
--     province_name VARCHAR(20) not null,
--     country_code VARCHAR(10) not null,
--     area int,
--     primary key (province_name, country_code),
--     foreign key (country_code) references country(country_code)
-- );

-- create table city(
--     city_name VARCHAR(20) not null,
--     province_name VARCHAR(20) not null,
--     country_code VARCHAR(10) not null,
--     population_ int,
--     primary key (city_name, province_name, country_code),
--     foreign KEY (province_name, country_code) references province(province_name, country_code)
-- );

-- create table border(
--     country_code_1 VARCHAR(10) not null,
--     country_code_2 VARCHAR(10) not null,
--     border_length int unsigned,
--     primary key (country_code_1, country_code_2),
--     foreign key (country_code_1) references country(country_code),
--     foreign key (country_code_1) references country(country_code),
--     check (country_code_1 != country_code_2)
-- );

-- -- TODO: add insert statements
-- insert into country values ('USA','United States of America', 100, 4.5);
-- insert into country values ('MEX','Mexico', 90, 5.9);
-- insert into country values ('CAN','Canada', 101, 4.9);

-- insert into province values ('Washington','USA', 100000);
-- insert into province values ('Oregon','USA', 1000100);
-- insert into province values ('Idaho','USA', 900000);

-- insert into province values ('North','MEX', 100010);
-- insert into province values ('South','MEX', 1006000);
-- insert into province values ('East','MEX', 100770);

-- insert into province values ('Ontario','CAN', 200000);
-- insert into province values ('Brrrr','CAN', 2000020);
-- insert into province values ('Green','CAN', 2011000);

-- insert into city value ('Seattle','Washington','USA',300);
-- insert into city value ('Spokane','Washington','USA',1000);
-- insert into city value ('Sammamish','Washington','USA',300);

-- insert into city value ('Portland','Oregon','USA',304);
-- insert into city value ('Eugene','Oregon','USA',310);
-- insert into city value ('Beaverton','Oregon','USA',328);

-- insert into city value ('Coured Alene','Idaho','USA',7200);
-- insert into city value ('Potato','Idaho','USA',720);
-- insert into city value ('Boise','Idaho','USA',5723);

-- insert into city value ('Mexico City','North','MEX',4002);
-- insert into city value ('Puebla','North','MEX',232);
-- insert into city value ('Puerta Vallarta','North','MEX',720);

-- insert into city value ('a','South','MEX',720);
-- insert into city value ('b','South','MEX',60);
-- insert into city value ('c','South','MEX',645);

-- insert into city value ('qw','East','MEX',926);
-- insert into city value ('ok','East','MEX',2600);
-- insert into city value ('eb','East','MEX',684);

-- insert into city value ('Alberta','Ontario','CAN',926);
-- insert into city value ('Vancouver','Ontario','CAN',860);
-- insert into city value ('Alberkerky','Ontario','CAN',760);

-- insert into city value ('gy','Brrrr','CAN',670);
-- insert into city value ('qt','Brrrr','CAN',8656);
-- insert into city value ('ls','Brrrr','CAN',6872);

-- insert into city value ('po','Green','CAN',951);
-- insert into city value ('kn','Green','CAN',337);
-- insert into city value ('tc','Green','CAN',7014);

-- insert into border value ('USA','MEX',1005);
-- insert into border value ('USA','CAN',2060);

-- TODO: add select statements (to print tables)




-- HW6----------------------------------------------------------------------------------------------------------------------------------------------------------
-- TODO: add drop table statements
-- A DONE
select * 
from country 
where gdp >= 100 and inflation < 5;

-- B DONE
select country.country_code, country.country_name, country.inflation, province.province_name, province.area 
from province,country 
where province.area <= 200000 and country.inflation > 5;

-- C DONE
select country.country_code, country.country_name, country.inflation, province.province_name, province.area 
from province cross join country 
where province.area <= 200000 and country.inflation > 5;

-- D DONE
select distinct c.country_code, c.country_name, p.province_name, p.area 
from country c, province p, city k 
where p.country_code = c.country_code and p.country_code = k.country_code and p.province_name = k.province_name and k.population_ >= 1000;

-- E DONE
select distinct country.country_code, country.country_name, province.province_name, province.area 
from country
    join province using (country_code)
    join city using (country_code, province_name) 
where city.population_ >= 1000;

-- F DONE

select distinct c.country_code, c.country_name, p.province_name, p.area 
from country c,province p, city k1, city k2 
where p.country_code = c.country_code and p.country_code = k1.country_code and p.country_code = k2.country_code and p.province_name = k1.province_name and p.province_name = k2.province_name and k1.population_ >1000 and k2.population_ >1000 and k1.city_name!=k2.city_name;

-- G DONE
select distinct country.country_code, country.country_name, province.province_name, province.area 
from country
    join province using (country_code)
    join city k1 using (country_code, province_name) 
    join city k2 using (country_code, province_name)
where k1.city_name!=k2.city_name and k1.population_ >= 5000 and k2.population_ >= 5000;

-- H 
-- select distinct c1.country_code, c2.country_code, p1.province_name, p2.province_name, k1.city_name, k2.city_name, k1.population_
-- from country c1
--     join country c2 using (country_code)
--     join province p1 using (country_code)
--     join province p2 using (country_code)
--     join city k1 using (country_code)
--     join city k2 using (country_code)
-- where k1.population_= k2.population_ and c1.country_name != c2.country_name or p1.province_name != p2.province_name or k1.city_name != k2.city_name;

-- I DONE
select distinct c1.country_code, c1.country_name
from country c1, country c2, border b
where c1.country_code != c2.country_code and ((b.country_code_1 = c1.country_code and b.country_code_2 = c2.country_code) or (b.country_code_2 = c1.country_code and b.country_code_1 = c2.country_code)) 
    and c1.gdp >= 100 and c1.inflation < 5 and c2.gdp < 100 and c2.inflation > 5;


 -- J DONE
 select distinct c1.country_code, c1.country_name
 from country c1
    cross join country c2 
    cross join border b
 where c1.country_code != c2.country_code and ((b.country_code_1 = c1.country_code and b.country_code_2 = c2.country_code) or (b.country_code_2 = c1.country_code and b.country_code_1 = c2.country_code)) 
    and c1.gdp >= 100 and c1.inflation < 5 and c2.gdp < 100 and c2.inflation > 5;


-- h
-- select city.city_name, province.province_name, country.country_code  
-- from province, country ,city /*on (city.population_ =city.population_)*/
-- where city.city_name != city.city_name or province.province_name !=province.province_name or country.country_code != country.country_code;

-- TODO: add create table statements



-- TODO: add insert statements



-- TODO: add select statements (to print tables)



