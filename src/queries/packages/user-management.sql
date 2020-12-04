create or replace package user_management
is
  procedure register(
    phone varchar2, 
    fullname varchar2,
    password varchar2);
  procedure authenticate(
    p_phone varchar2,
    p_result out sys_refcursor);
end;

create or replace package body user_management
is
  procedure register(
    phone varchar2, 
    fullname varchar2,
    password varchar2) is
  begin
    insert into users(phone, fullname, password)
    values(phone, fullname, password);
  end;
  procedure authenticate(
    p_phone varchar2,
    p_result out sys_refcursor) is
  begin
    open p_result for
    select * from users
    where phone =  p_phone;
  end;
end;

select * from users;




