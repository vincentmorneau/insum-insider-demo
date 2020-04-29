select p.product_name, 
       oi.unit_price, 
       oi.quantity, 
      (oi.unit_price * oi.quantity) total_cost   
from demo_order_items oi, demo_product_info p
where oi.product_id = p.product_id 
and oi.order_id = :P8_ORDER_ID
and oi.quantity <> 0