create or replace function similarity(string varchar2, substring varchar2)
return number is
begin
--  return (length(string) - UTL_MATCH.EDIT_DISTANCE(substring, string)) / length(substring);
  return UTL_MATCH.JARO_WINKLER_SIMILARITY(string, substring);
end;

-- Europharma
