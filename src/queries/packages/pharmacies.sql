create or replace package stores
is
  procedure get_autocomplete(
    p_query varchar2,
    p_result out sys_refcursor);
  procedure get_pharmacies(
    p_query varchar2,
    p_result out sys_refcursor,
    p_offset integer,
    p_count out integer);
  procedure get_pharmacy_by_drug(
    p_drug_id integer,
    p_result out sys_refcursor,
    p_count out integer);
end;

create or replace package body stores
is
  procedure get_autocomplete(
    p_query varchar2,
    p_result out sys_refcursor) is
  begin
    open p_result for
    select id, title, similarity_ph(title, p_query) as score from pharmacies
    where similarity_ph(title, p_query) > 0.5
    order by score desc
    FETCH NEXT 5 ROWS ONLY;
  end;
  procedure get_pharmacies(
    p_query varchar2,
    p_result out sys_refcursor,
    p_offset integer,
    p_count out integer) is
  begin
    open p_result for
    select id, title, address, phones, latitude, longitude, similarity_ph(title, p_query) as score from pharmacies
    where similarity_ph(title, p_query) > 0.5
    order by score desc
    OFFSET p_offset ROWS
    FETCH NEXT 5 ROWS ONLY;
    
    select count(*) into p_count from pharmacies
    where similarity(title, p_query) > 0.5;
  end;
  procedure get_pharmacy_by_drug(
    p_drug_id integer,
    p_result out sys_refcursor,
    p_count out integer) is
  begin
    open p_result for
    select p.id, p.title, p.address, p.phones, p.latitude, p.longitude , d.price
    from drugs_to_ph d join pharmacies p on (p.id = d.ph_id)
    where d.drug_id = p_drug_id;
    
    select count(*) into p_count
    from drugs_to_ph d join pharmacies p on (p.id = d.ph_id)
    where d.drug_id = p_drug_id;
  end;
end;





