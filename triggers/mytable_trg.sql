create or replace trigger mytable_trg
after insert on mytable for each row
declare
begin
  null;
end;
