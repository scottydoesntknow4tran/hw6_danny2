/**********************************************************************
 * NAME: Scott Tornquist
 * CLASS: Database Systems
 * DATE: 10/19/2021
 * HOMEWORK: HW#5B
 * DESCRIPTION: Lego bricks database
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
    years int unsigned,
    primary key (item_number, years),
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
insert into theme values ('Star-Wars','Galxy far far away', 'Disney');
insert into theme values ('Halo','MasterChief', 'Microsoft');

insert into lego_set values (001,'Death Star', '8+', 99.99, 37, 1600, '24,24,24', 1200);
insert into lego_set values (002,'SGT Johnson', '12+', 69.99, null, 800, null, 870);

insert into brick values (101, '2x4', 'red', .67);

insert into part_list value (201, 6);

insert into theme_years values ('Star-Wars', 1996);
insert into theme_years values ('Star-Wars', 2002);

insert into set_theme values ('Future',001);
insert into set_theme values ('Halo',001);

insert into set_years values (001, 1996);
insert into set_years values (001, 1994);
insert into set_years values (002, 1996);

insert into set_parts values (001, 201);

insert into brick_parts values (201,101);

insert into category values ('Children', 001);

-- TODO: add select statements (to print tables)

select * from theme;
select * from theme_years;
select * from lego_set;
select * from category;
select * from set_years;
select * from set_theme;
select * from brick;
select * from part_list;
select * from brick_parts;
select * from set_parts;

