select count(*)
  from demo_orders o,
       demo_customers c
 where o.customer_id = c.customer_id