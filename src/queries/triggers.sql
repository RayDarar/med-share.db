create trigger users_add_trigger
  after insert on users
  referencing new as new
  for each row
begin
  insert into users_log(user_id, datetime) values(:new.id, sysdate);
end;

create trigger posts_add_trigger
  after insert on posts
  referencing new as new
  for each row
begin
  insert into posts_log(post_id, datetime, action) values(:new.id, sysdate, 'insert');
end;

create trigger posts_update_trigger
  after update on posts
  referencing new as new
  for each row
begin
  insert into posts_log(post_id, datetime, action) values(:new.id, sysdate, 'update');
end;

