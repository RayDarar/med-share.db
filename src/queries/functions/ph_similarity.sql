create or replace function similarity_ph(string varchar2, substring varchar2)
return number is
begin
 return (length(lower(string)) - UTL_MATCH.EDIT_DISTANCE(lower(substring), lower(string))) / length(lower(substring));
  -- return UTL_MATCH.JARO_WINKLER_SIMILARITY(string, substring);
end;