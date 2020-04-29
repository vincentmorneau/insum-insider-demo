select oi.order_item_id, 
       oi.order_id, 
       oi.product_id, 
       oi.unit_price, 
       oi.quantity, 
       (oi.unit_price * oi.quantity) extended_price
from DEMO_ORDER_ITEMS oi, DEMO_PRODUCT_INFO pi 
where oi.ORDER_ID = :P29_ORDER_ID 
and oi.product_id = pi.product_id (+)
