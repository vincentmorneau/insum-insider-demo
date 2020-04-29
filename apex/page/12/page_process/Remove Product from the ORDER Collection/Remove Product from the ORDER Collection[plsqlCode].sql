for x in 
  (select seq_id, c001 from apex_collections 
    where collection_name = 'ORDER' and c001 = :P12_PRODUCT_ID)
loop
apex_collection.delete_member(p_collection_name => 'ORDER', p_seq => x.seq_id);
--htp.p('removed an item');
end loop;