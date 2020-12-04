create or replace package posts_management
is
  procedure get_autocomplete(
    p_query varchar2,
    p_result out sys_refcursor);
  procedure get_posts(
    p_query varchar2,
    p_result out sys_refcursor,
    p_offset integer,
    p_count out integer);
  procedure get_post(
    p_id integer,
    p_result out sys_refcursor);
  procedure add_post(
    user_id integer, 
    title varchar2, 
    status varchar2, 
    storage varchar2, 
    expires date, 
    contacts varchar2);
end;

create or replace package body posts_management
is
  procedure get_autocomplete(
    p_query varchar2,
    p_result out sys_refcursor) is
  begin
    open p_result for
    select id, title, similarity(title, p_query) as score from posts
    where similarity(title, p_query) > 80
    order by score desc
    FETCH NEXT 5 ROWS ONLY;
  end;
  procedure get_posts(
    p_query varchar2,
    p_result out sys_refcursor,
    p_offset integer,
    p_count out integer) is
  begin
    open p_result for
    select id, title, status, storage, expires, contacts, post_status, similarity(title, p_query) as score
    from posts
    where similarity(title, p_query) > 80
    and post_status = 'published'
    order by score desc
    OFFSET p_offset ROWS
    FETCH NEXT 5 ROWS ONLY;
    
    select count(*) into p_count from posts
    where similarity(title, p_query) > 80
    and post_status = 'published';
  end;
  procedure get_post(
    p_id integer,
    p_result out sys_refcursor) is
  begin
    open p_result for
    select * from posts
    where id = p_id;
  end;
  procedure add_post(
    user_id integer, 
    title varchar2, 
    status varchar2, 
    storage varchar2, 
    expires date, 
    contacts varchar2) is
  begin
    insert into posts(user_id, title, status, storage, expires, contacts, post_status)
    values(user_id, title, status, storage, expires, contacts, 'processing');
  end;
end;


select * from users;




