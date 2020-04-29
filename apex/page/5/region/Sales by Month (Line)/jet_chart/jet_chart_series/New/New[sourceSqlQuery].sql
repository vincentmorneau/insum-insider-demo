select trunc(o.order_timestamp) when,
    sum (oi.quantity * oi.unit_price) sales,
    p.category type
from demo_product_info p, demo_order_items oi, demo_orders o
where oi.product_id = p.product_id
    and o.order_id = oi.order_id
group by p.category,
    trunc(o.order_timestamp),
    to_char(o.order_timestamp, 'YYYYMM')
order by to_char(o.order_timestamp, 'YYYYMM') 