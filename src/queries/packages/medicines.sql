create or replace package medicines
is
  procedure get_autocomplete(
    p_query varchar2,
    p_result out sys_refcursor);
  procedure get_medicines(
    p_query varchar2,
    p_result out sys_refcursor,
    p_offset integer default 0);
  procedure get_medicine(
    p_id integer,
    p_result out sys_refcursor);
  procedure get_analogs(
    p_id integer,
    p_result out sys_refcursor);
end;

create or replace package body medicines
is
  procedure get_autocomplete(
    p_query varchar2,
    p_result out sys_refcursor) is
  begin
    open p_result for
    select id, title, similarity(title, p_query) as score from drugs
    order by score desc
    FETCH NEXT 10 ROWS ONLY;
  end;
  procedure get_medicines(
    p_query varchar2,
    p_result out sys_refcursor,
    p_offset integer default 0) is
  begin
    open p_result for
    select id, title, status, similarity(title, p_query) as score from drugs
    order by score desc
    OFFSET p_offset ROWS
    FETCH NEXT 10 ROWS ONLY;
  end;
  procedure get_medicine(
    p_id integer,
    p_result out sys_refcursor) is
  begin
    open p_result for
    select * from drugs
    where id = p_id;
  end;
  procedure get_analogs(
    p_id integer,
    p_result out sys_refcursor) is
  begin
    open p_result for
    select d.id, d.title, d.status, a.analog_id 
    from drugs d join drugs_analogs a on (d.id = a.analog_id)
    where a.drug_id = p_id;
  end;
end;









