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
  procedure get_my_posts(
    p_user_id integer,
    p_result out sys_refcursor);
  procedure add_post(
    user_id integer, 
    title varchar2, 
    status varchar2,
    amount varchar2,
    storage varchar2, 
    expires date, 
    contacts varchar2);
  procedure get_confirmation_posts(
    p_result out sys_refcursor);
  procedure confirm_post(
    p_id integer);
  procedure deny_post(
    p_id integer);
  procedure archive_post(
    p_id integer);
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
    select p.id, p.title, p.status, p.amount, p.storage, p.expires, p.contacts, p.post_status, similarity(title, p_query) as score, u.fullname
    from posts p join users u on (p.user_id = u.id)
    where similarity(title, p_query) > 80
    and post_status = 'published'
    order by score desc
    OFFSET p_offset ROWS
    FETCH NEXT 5 ROWS ONLY;
    
    select count(*) into p_count from posts
    where similarity(title, p_query) > 80
    and post_status = 'published';
  end;
  procedure get_my_posts(
    p_user_id integer,
    p_result out sys_refcursor) is
  begin
    open p_result for
    select * from posts
    where user_id = p_user_id;
  end;
  procedure add_post(
    user_id integer, 
    title varchar2, 
    status varchar2, 
    amount varchar2,
    storage varchar2, 
    expires date, 
    contacts varchar2) is
  begin
    insert into posts(user_id, title, status, amount, storage, expires, contacts, post_status)
    values(user_id, title, status, amount, storage, expires, contacts, 'processing');
  end;
  procedure get_confirmation_posts(
    p_result out sys_refcursor) is
  begin
    open p_result for
    select p.id, p.title, p.status, p.amount, p.storage, p.expires, p.contacts, p.post_status, u.fullname
    from posts p join users u on (p.user_id = u.id)
    where post_status = 'processing';
  end;
  procedure confirm_post(
    p_id integer) is
  begin
    update posts
    set post_status = 'published'
    where id = p_id;
  end;
  procedure deny_post(
    p_id integer) is
  v_statement varchar2(200) := 'update posts set post_status = ''deny'' where id = ' || p_id;
  begin
    execute immediate v_statement;
  end;
  procedure archive_post(
    p_id integer) is
  v_statement varchar2(200) := 'update posts set post_status = ''archived'' where id = ' || p_id;
  begin
    execute immediate v_statement;
  end;
end;





