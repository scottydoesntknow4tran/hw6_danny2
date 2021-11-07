/**********************************************************************
 * NAME: Scott Tornquist
 * CLASS: Database Management Systems
 * DATE: 10/28/2021
 * HOMEWORK: HW#6
 * DESCRIPTION: Lego Set Queries
 **********************************************************************/



-- TODO: add drop table statements
SET FOREIGN_KEY_CHECKS=0;
drop table if exists lego_set;
drop table if exists set_years;
drop table if exists brick;
drop table if exists brick_parts;
drop table if exists theme;
drop table if exists theme_years;
drop table if exists set_theme;
drop table if exists set_parts;
drop table if exists set_years;
drop table if exists category;
drop table if exists part_list;
SET FOREIGN_KEY_CHECKS=1;

-- TODO: add create table statements

create table theme (
    theme_name VARCHAR(20) not null,
    theme_description text not null,
    licenece text,
    primary key (theme_name)
);

create table brick (
    element_id int unsigned not null,
    brick_name text not null,
    color text not null,
    price double not null,
    primary key (element_id)
);

create table part_list (
    design_id int unsigned not null,
    number_of_bricks int unsigned not null,
    primary key (design_id)
);

create table theme_years(
    theme_name VARCHAR(20) not null,
    years int unsigned not null,
    primary key (theme_name, years),
    foreign key (theme_name) references theme(theme_name)
);

create table lego_set (
    item_number int unsigned not null,
    set_name text not null,
    age_range text not null,
    price double not null,
    min_fig_count int unsigned,
    vip_points int unsigned not null,
    height_width_depth text,
    total_brick_count int unsigned not null,
    primary key (item_number)
);

create table set_theme (
    theme_name VARCHAR(20) not null,
    item_number int unsigned not null,
    primary key (theme_name, item_number),
    foreign key(item_number) references lego_set(item_number),
    foreign key (theme_name) references theme(theme_name)
);

create table set_years (
    item_number int unsigned not null,
    start_year int unsigned,
    end_year int,
    primary key (item_number, start_year, end_year),
    foreign key (item_number) references lego_set(item_number)
);

create table set_parts(
    item_number int unsigned not null,
    design_id int unsigned not null,
    primary key(item_number, design_id),
    foreign key(item_number) references lego_set(item_number),
    foreign key (design_id) references part_list(design_id)
);

create table brick_parts(
    design_id int unsigned not null,
    element_id int unsigned not null,
    primary key (design_id, element_id),
    foreign key (design_id) references part_list(design_id),
    foreign key (element_id) references brick(element_id)
);

create table category (
    category_name VARCHAR(20) not null,
    item_number int unsigned not null,
    primary key (category_name, item_number),
    foreign key (item_number) references lego_set(item_number)
);



-- -- TODO: add insert statements
insert into theme values ('Future','utopian society', null);
insert into theme values ('Disney','Galxy far far away', 'Star-Wars');
insert into theme values ('Halo','MasterChief', 'Microsoft');

insert into lego_set values (001,'Death Star', '8+', 99.99, 37, 1600, '24,24,24', 1200);
insert into lego_set values (002,'SGT Johnson', '12+', 24, null, 800, null, 87);

insert into brick values (101, '2x4', 'red', .67);
insert into brick values (102, '1x2', 'red', .37);
insert into brick values (103, '1x2 Brick', 'Bright Blue', .97);
insert into brick values (104, '2x4 Plate', 'yellow', .67);
insert into brick values (105, '2x4 Plate', 'Bright Red', .87);
insert into brick values (106, '2x6 Plate', 'Bright Red', 1.37);
insert into brick values (107, '3x6', 'green', .27);
insert into brick values (108, '4x9', 'gold', 1.67);

insert into part_list value (201, 11);
insert into part_list value (202, 15);
insert into part_list value (203, 21);
insert into part_list value (204, 1);
insert into part_list value (205, 6);

insert into part_list value (211, 11);
insert into part_list value (212, 50);
insert into part_list value (213, 51);
insert into part_list value (214, 1);
insert into part_list value (215, 6);


insert into theme_years values ('Disney', 1996);
insert into theme_years values ('Disney', 2002);

insert into set_theme values ('Future',001);
insert into set_theme values ('Disney',001);
insert into set_theme values ('Halo',002);

insert into set_years values (001, 1995, 1996);
insert into set_years values (001, 1990, 1994);
insert into set_years values (002, 1980, 1990);
insert into set_years values (002, 2015, null);

insert into set_parts values (002, 201);
insert into set_parts values (002, 202);
insert into set_parts values (002, 203);
insert into set_parts values (002, 204);
insert into set_parts values (002, 205);

insert into set_parts values (001, 211);
insert into set_parts values (001, 212);
insert into set_parts values (001, 213);
insert into set_parts values (001, 214);
insert into set_parts values (001, 215);

insert into brick_parts values (201,101);
insert into brick_parts values (202,102);
insert into brick_parts values (203,103);
insert into brick_parts values (204,104);
insert into brick_parts values (205,105);

insert into brick_parts values (211,106);
insert into brick_parts values (212,102);
insert into brick_parts values (213,107);
insert into brick_parts values (214,104);
insert into brick_parts values (215,108);

insert into category values ('Children', 002);
insert into category values ('Building', 001);
insert into category values ('Sports', 001);
insert into category values ('Sports', 002);

-- TODO: add select statements (to print tables)

-- select * from theme;
-- select * from theme_years;
-- select * from lego_set;
-- select * from category;
-- select * from set_years;
-- select * from set_theme;
-- select * from brick;
-- select * from part_list;
-- select * from brick_parts;
-- select * from set_parts;

-- A DONE
select distinct lego_set.item_number, lego_set.set_name 
from part_list
    join brick_parts using (design_id)
    join brick using (element_id)
    join set_parts using (design_id)
    join lego_set using (item_number)
where part_list.number_of_bricks > 10 and lego_set.price < 25;

-- B DONE
select distinct lego_set.item_number, lego_set.set_name 
from part_list
    join brick_parts using (design_id)
    join brick using (element_id)
    join set_parts using (design_id)
    join lego_set using (item_number)
where (brick.brick_name = '2x4 Plate' and brick.color = 'Bright Red') or (brick.brick_name = '1x2 Brick' and brick.color = 'Bright Blue');

-- C DONE
select distinct lego_set.item_number, lego_set.set_name 
from lego_set
    join set_theme using (item_number)
    join category using (item_number)
where set_theme.theme_name = 'Disney' and category.category_name = 'Building';

-- D DONE
select distinct lego_set.item_number, lego_set.set_name 
from lego_set
    join category using (item_number)
where category.category_name = 'Building' and category.category_name = 'Building';

-- E DONE
select distinct lego_set.item_number, lego_set.set_name 
from lego_set
    join set_years s1 using (item_number)
    join set_years s2 using (item_number)
where s1.item_number = s2.item_number and s1.start_year != s2.start_year and s1.end_year != s2.end_year;

-- F DONE
select distinct lego_set.item_number, lego_set.set_name 
from lego_set
where lego_set.min_fig_count > 10 and lego_set.min_fig_count is not null and lego_set.vip_points > 200;

-- G DONE
select distinct lego_set.item_number, lego_set.set_name 
from lego_set
    join set_years s1 using (item_number)
where (s1.start_year >= 1996 and s1.start_year <= 2013) or  (s1.end_year <= 2013 and s1.end_year >= 1996)  or (s1.start_year <= 2013 and s1.end_year IS NULL);

-- H1 Return lego sets that were produced in overlaping years
select distinct lego_set.item_number, lego_set.set_name 
from lego_set
    join set_years s1 using (item_number)
    join set_years s2 using (item_number)
where (s1.start_year <= s2.end_year and s1.start_year >= s2.start_year) or (s2.start_year <= s1.end_year and s2.start_year >= s1.start_year);

-- H2 Return lego sets with one type of brick that is more than 20 percent of the total bricks
select distinct lego_set.item_number, lego_set.total_brick_count, part_list.number_of_bricks 
from part_list
    join brick_parts using (design_id)
    join brick using (element_id)
    join set_parts using (design_id)
    join lego_set using (item_number)
where (part_list.number_of_bricks/lego_set.total_brick_count) > .2;


-- H3 returns lego sets that share a theme or category but not both
select distinct lego_set.item_number, lego_set.set_name
from lego_set
    join set_theme s1 using (item_number)
    join set_theme s2 using (item_number)
    join category c1 using (item_number)
    join category c2 using (item_number)
where (s1.theme_name = s2.theme_name and c1.category_name != c2.category_name) or (s1.theme_name != s2.theme_name and c1.category_name = c2.category_name);
