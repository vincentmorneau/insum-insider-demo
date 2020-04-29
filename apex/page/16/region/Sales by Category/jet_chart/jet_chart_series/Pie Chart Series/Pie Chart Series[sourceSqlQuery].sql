select null, p.category label, sum(o.order_total) total_sales
from demo_orders o, demo_order_items oi, demo_product_info p
where o.order_id = oi.order_id
    and oi.product_id = p.product_id
group by category order by 3 desc