drop table watch_history;
drop table payment;
drop table movie;
drop table publisher;
drop table users;

create table users(
	id number(5),
	fullname varchar(50),
	username varchar(30),
	email varchar(100),
	password varchar(200),
	gender varchar(1), -- 'f', 'm'
	dob date,
	created_at date,
	primary key(id)
);


create table payment(
	id number(5),
	user_id number(5),
	amount number(5),
	payment_date date,
	primary key(id, user_id),
	foreign key(user_id) references users(id)
);

create table publisher(
	id number(5),
	fullname varchar(50),
	founding_year date,
	primary key(id)
);

create table movie(
	id number(5),
	title varchar(50),
	description varchar(200),
	genre varchar(50),
	publishing_date date,
	publisher number(5),
	primary key(id),
	foreign key(publisher) references publisher(id)
);


create table watch_history(
	id number(5),
	user_id number(5),
	mid number(5),
	primary key(id),
	foreign key(user_id) references users(id),
	foreign key(mid) references movie(id)
);
