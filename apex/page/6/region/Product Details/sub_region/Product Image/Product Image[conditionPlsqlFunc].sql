declare
begin
  if :P6_PRODUCT_ID is not null then
    for c1 in (select nvl(dbms_lob.getlength(product_image),0) l
               from demo_product_info
               where product_id = :P6_PRODUCT_ID)
    loop
      if c1.l > 0 then
        return true;
      end if;
    end loop;
  end if;
  return false;
end;