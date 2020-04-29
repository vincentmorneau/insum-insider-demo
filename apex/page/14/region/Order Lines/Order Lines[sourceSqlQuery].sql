select (select product_name from demo_product_info p where product_id = c001) as product_name,
       c002 as unit_price,
       c003 as quantity,
       (c002 * c003) as total_cost
  from apex_collections
 where collection_name = 'SDBA_ORDER_ITEMS'
   and c003 <> 0
 order by 1