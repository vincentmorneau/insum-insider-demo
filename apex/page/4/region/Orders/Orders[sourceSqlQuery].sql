select lpad(to_char(o.order_id),4,'0000') order_number,
    o.order_id,
    to_char(o.order_timestamp,'Month YYYY') order_month,
    trunc(o.order_timestamp) order_date,
    o.user_name sales_rep,
    o.order_total,
    c.cust_last_name||', '||c.cust_first_name customer_name,
    (   select count(*)
        from demo_order_items oi
        where oi.order_id = o.order_id
            and oi.quantity != 0 ) order_items,
    o.tags tags
from demo_orders o,
    demo_customers c
where o.customer_id = c.customer_id