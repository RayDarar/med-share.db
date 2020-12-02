-- Package/Stored Procedures/Functions declarations

create or replace package dataset_management
is
  procedure add_pharmacy(
    key integer, 
    title varchar2, 
    phones varchar2, 
    address varchar2, 
    latitude number default null, 
    longitude number default null);
  procedure add_drug(
    key integer, 
    title varchar2, 
    status varchar2);
  procedure add_drug_to_ph(
    key integer, 
    ph_id integer, 
    drug_id integer,
    price number default null);
  procedure add_drug_analogs(
    key integer, 
    drug_id integer, 
    analog_id integer);
end;

create or replace package body dataset_management
is
  procedure add_pharmacy(
    key integer, 
    title varchar2, 
    phones varchar2, 
    address varchar2, 
    latitude number default null, 
    longitude number default null) is
    begin
      insert into pharmacies(id, title, phones, address, latitude, longitude) 
      values(key, title, phones, address, latitude, longitude);
    end;
    procedure add_drug(
      key integer, 
      title varchar2, 
      status varchar2) is
    begin
      insert into drugs(id, title, status) 
      values(key, title, status);
    end;
    procedure add_drug_to_ph(
      key integer, 
      ph_id integer, 
      drug_id integer,
      price number default null) is
    begin
      insert into drugs_to_ph(id, ph_id, drug_id, price)
      values (key, ph_id, drug_id, price);
    end;
    procedure add_drug_analogs(
      key integer, 
      drug_id integer, 
      analog_id integer) is
    begin
      insert into drugs_analogs(id, drug_id, analog_id)
      values (key, drug_id, analog_id);
    end;
end;
