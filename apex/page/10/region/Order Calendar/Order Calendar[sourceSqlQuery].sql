select order_id,
    (   select cust_first_name||' '||cust_last_name 
        from demo_customers c
        where c.customer_id = o.customer_id )
        ||' ['||to_char(order_total,'FML999G999G999G999G990D00')||']' customer,
    order_timestamp
from demo_orders o