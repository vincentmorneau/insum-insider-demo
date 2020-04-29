select 
       to_char(o.order_timestamp, 'MON RRRR') label, 
       sum (decode(p.category,'Accessories',oi.quantity * oi.unit_price,null)) "Accessories",
       sum (decode(p.category,'Mens',oi.quantity * oi.unit_price,null)) "Mens",
       sum (decode(p.category,'Womens',oi.quantity * oi.unit_price,null)) "Womens"
from demo_product_info p, demo_order_items oi, demo_orders o
where oi.product_id = p.product_id
and o.order_id = oi.order_id
group by to_char(o.order_timestamp, 'MON RRRR'), to_char(o.order_timestamp, 'RRRR MM')
order by to_char(o.order_timestamp, 'RRRR MM')