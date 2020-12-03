create or replace package medicines
is
  procedure get_autocomplete(
    p_query varchar2,
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
    order by score desc;
  end;
end;
