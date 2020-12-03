create or replace function get_medicine_available(p_id integer) 
return integer is
  v_result integer := 0;
begin
  select count(*) into v_result from drugs_to_ph
  where drug_id = p_id
  group by drug_id;
  
  if v_result != 0 then
    return 1;
  end if;
  return 0;
exception
  when NO_DATA_FOUND then
    return null;
end;