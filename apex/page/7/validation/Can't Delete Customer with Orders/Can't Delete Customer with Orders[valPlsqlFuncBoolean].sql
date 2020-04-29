begin
  for c1 in (select 'x' from demo_orders where customer_id = :P7_CUSTOMER_ID) loop
    RETURN FALSE;
  end loop;
  RETURN TRUE;
end;