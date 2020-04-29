select o.order_timestamp when,
    sum (oi.quantity * oi.unit_price) sales,
    p.category type
from demo_product_info p, demo_order_items oi, demo_orders o
where oi.product_id = p.product_id
    and o.order_id = oi.order_id
group by p.category,
    o.order_timestamp
order by o.order_timestamp