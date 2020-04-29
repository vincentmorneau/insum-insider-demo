select initcap(s.state_name) label, 
    SUM(oi.quantity * oi.unit_price) sales,
    null the_link
from demo_orders o, demo_order_items oi, demo_customers p, demo_states s
where o.order_id = oi.order_id
    and o.customer_id = p.customer_id
    and p.cust_state = s.st
    and (nvl(:P31_PRODUCT_ID,'0') = '0' or :P31_PRODUCT_ID = oi.product_id)
group by state_name 
order by 3 desc