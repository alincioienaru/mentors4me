drop schema if exists mentors4me;
create schema mentors4me;
use mentors4me;

#####################################################
drop table if exists role;
create table role(
id int unsigned auto_increment,
name varchar(32),
created_date datetime,
modified_date datetime,
constraint pk_role_id primary key(id)
);

delimiter $$
drop trigger if exists role_before_insert$$
create trigger role_before_insert
	before insert on role
    for each row
begin
	set NEW.created_date = now();
end$$

drop trigger if exists role_before_update$$
create trigger role_before_update
	before update on role
    for each row
begin
	set NEW.modified_date = now();
end$$
delimiter ;
#####################################################
insert into role (name) values('mentor'), ('reprezentat');
#####################################################


#####################################################
drop table if exists user;
create table user(
id int unsigned auto_increment,
email varchar(256),
password varchar(256),
role_id int unsigned,
phone varchar(32),
name varchar(256),
linkedin varchar(256),
facebook varchar(256),
city varchar(256),
zone varchar(256),
description varchar(256),
created_date datetime,
modified_date datetime,
constraint pk_user_id primary key(id),
constraint fk_user_role_id foreign key(role_id) references role(id)
);

delimiter $$
drop trigger if exists user_before_insert$$
create trigger user_before_insert
	before insert on user
    for each row
begin
	set NEW.created_date = now();
end$$

drop trigger if exists user_before_update$$
create trigger user_before_update
	before update on user
    for each row
begin
	set NEW.modified_date = now();
end$$
delimiter ;

#####################################################
drop table if exists mentor_detail;
create table mentor_detail(
id int unsigned auto_increment,
user_id int unsigned,
photo_path varchar(256), /* we should see if storing them in db or somewhere in the filesystem will be easier (the recommandation seems to be storing only the path in DB)*/
availability varchar(256), /* if we want a list of times and not a tex... we will need another table*/
created_date datetime,
modified_date datetime,
constraint pk_mentor_detail_id primary key(id),
constraint fk_mentor_detail_user_id foreign key(user_id) references user(id)
);


delimiter $$
drop trigger if exists mentor_detail_before_insert$$
create trigger mentor_detail_before_insert
	before insert on mentor_detail
    for each row
begin
	set NEW.created_date = now();
end$$

drop trigger if exists mentor_detail_before_update$$
create trigger mentor_detail_before_update
	before update on mentor_detail
    for each row
begin
	set NEW.modified_date = now();
end$$
delimiter ;

#####################################################
create table  repres_type(
id int unsigned auto_increment,
name varchar(256), /* sala de clasa, etc... */
constraint pk_repres_type_id primary key(id)
);

#####################################################
drop table if exists repres_detail;
create table mentor_repres(
id int unsigned auto_increment,
type_id int unsigned,
name varchar(256), /*(clasa x-a...) */
constraint pk_repres_detail_id primary key(id)
);

#####################################################
drop table if exists mentor_repres_status;
create table mentor_repres_status(
id int unsigned auto_increment,
name varchar(256), /*declined, invited, scheduled, postponed....*/
constraint pk_mentor_repres_status_id primary key(id)
);

#####################################################
drop table if exists mentor_repres;
create table mentor_repres(
id int unsigned auto_increment,
mentor_id int unsigned,
reprezentative_id int unsigned,
status_id int unsigned,
constraint pk_mentor_repres_id primary key(id)
);

#####################################################
drop table if exists mentor_repres_messages;
create table mentor_repres_messages(
id int unsigned auto_increment,
mentor_repres_id int unsigned,
write_time timestamp,
message varchar(512),
constraint pk_mentor_repres_messages_id primary key(id)
);
