select p.product_id, 
       p.product_name, 
       p.list_price, 
       apex_item.hidden(1, p.product_id) ||
          apex_item.hidden(2, p.list_price) || 
          apex_item.select_list(
              p_idx           =>   3,
              p_value         =>   nvl(c.c003,'Add to Cart'),
              p_list_values   =>   '1,2,3,4,5,6,7,8,9,10',
              p_show_null     =>   'YES',
              p_null_value    =>   0,
              p_null_text     =>   '0',
              p_item_id       =>   'f03_#ROWNUM#',
              p_item_label    =>   'f03_#ROWNUM#',
              p_show_extra    =>   'NO') "add_to_cart"
from demo_product_info p, apex_collections c
where p.product_avail = 'Y'
  and c.collection_name (+) = 'SDBA_ORDER_ITEMS'
  and c.c001 (+) = p.product_id
