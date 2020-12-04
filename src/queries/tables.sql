drop table drugs_analogs;
drop table drugs_to_ph;
drop table drugs;
drop table pharmacies;
drop table users;
drop table posts;

create table pharmacies (
  id integer primary key,
  title varchar2(200) not null,
  phones varchar(200) not null,
  address varchar2(200) not null,
  latitude number,
  longitude number
);

create table drugs (
  id integer primary key,
  title varchar2(1000) not null,
  status varchar2(20) not null
);

create table drugs_to_ph (
  id integer primary key,
  ph_id integer not null,
  drug_id integer not null,
  price number,
  foreign key(ph_id) references pharmacies(id),
  foreign key(drug_id) references drugs(id)
);

create table drugs_analogs (
  id integer primary key,
  drug_id integer not null,
  analog_id integer not null,
  foreign key(drug_id) references drugs(id),
  foreign key(analog_id) references drugs(id)
);

create table users (
  id integer GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) primary key,
  phone varchar2(20) unique not null,
  fullname varchar2(100) not null,
  password varchar2(200) not null
);

create table posts (
  id integer GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) primary key,
  user_id integer not null,
  title varchar2(200) not null,
  status varchar2(20) not null,
  amount varchar2(200) not null,
  storage varchar2(200) not null,
  expires date not null,
  contacts varchar2(100) not null,
  post_status varchar2(20) not null,
  foreign key(user_id) references users(id)
);








