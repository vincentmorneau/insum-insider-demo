with data as (
select 'M' as link_type,
       null as parent,
       'All Categories' as id,
       'All Categories' as name,
       null as sub_id
  from demo_product_info
union
select distinct('C') as link_type,
       'All Categories' as parent,
       category as id,
       category as name,
       null as sub_id
  from demo_product_info
union
select 'P' as link_type,
       category parent,
       to_char(product_id) id,
       product_name as name,
       product_id as sub_id
  from demo_product_info
union
select 'O' as link_type,
       to_char(product_id) as parent,
       null as id,
       (select c.cust_first_name || ' ' || c.cust_last_name  
          from demo_customers c, demo_orders o
         where c.customer_id = o.customer_id
           and o.order_id    = oi.order_id ) || ', ordered '||to_char(oi.quantity) as name,
       order_id as sub_id
  from demo_order_items oi
  where oi.quantity != 0
)
select case when connect_by_isleaf = 1 then 0
            when level = 1             then 1
            else                           -1
       end as status, 
       level, 
       name as title, 
       'icon-tree-folder' as icon, 
       id as value, 
       'View' as tooltip, 
       case when link_type = 'M'
            then apex_util.prepare_url('f?p='||:APP_ID||':3:'||:APP_SESSION||'::NO:RIR')
            when link_type = 'C'
            then apex_util.prepare_url('f?p='||:APP_ID||':3:'||:APP_SESSION||'::NO:CIR:IR_CATEGORY:'
                 ||name)
            when link_type = 'P'
            then apex_util.prepare_url('f?p='||:APP_ID||':6:'||:APP_SESSION||'::NO::P6_PRODUCT_ID,P6_BRANCH:'
                 ||sub_id||',19')
            when link_type = 'O'
            then apex_util.prepare_url('f?p='||:APP_ID||':29:'||:APP_SESSION||'::NO::P29_ORDER_ID,P29_LAST_PAGE:'
                 || sub_id || ',19')
            else null
            end as link 
from data
start with parent is null
connect by prior id = parent
order siblings by name