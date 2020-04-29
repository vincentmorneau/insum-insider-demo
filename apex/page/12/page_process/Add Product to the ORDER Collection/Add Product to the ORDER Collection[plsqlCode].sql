declare
  l_count number := 0;
begin
for x in (select p.rowid, p.* from demo_product_info p where product_id = :P12_PRODUCT_ID)
loop
  select count(*) 
  into l_count
  from wwv_flow_collections
  where collection_name = 'ORDER'
  and c001 =  x.product_id;
  if l_count >= 10 then
    exit;
  end if;
  apex_collection.add_member(p_collection_name => 'ORDER', 
    p_c001 => x.product_id, 
    p_c002 => x.product_name,
    p_c003 => x.list_price,
    p_c004 => 1,
    p_c010 => x.rowid);
end loop;
end;