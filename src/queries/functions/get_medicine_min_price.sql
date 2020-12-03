create or replace function get_medicine_min_price(p_id integer) 
return integer is
  v_result integer := null;
begin
  select min(price) into v_result from drugs_to_ph
  where drug_id = p_id
  group by drug_id;

  return v_result;
exception
  when NO_DATA_FOUND then
    return null;
end;