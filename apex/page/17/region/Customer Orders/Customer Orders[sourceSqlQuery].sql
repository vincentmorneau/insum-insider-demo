select c.customer_id,
       c.cust_last_name||', '||c.cust_first_name Customer_Name,
       sum (decode(p.category,'Accessories',oi.quantity * oi.unit_price,0)) "Accessories",
       sum (decode(p.category,'Mens',oi.quantity * oi.unit_price,0)) "Mens",
       sum (decode(p.category,'Womens',oi.quantity * oi.unit_price,0)) "Womens"
from demo_customers c
,    demo_orders o
,    demo_order_items oi
,    demo_product_info p
where c.customer_id = o.customer_id
and   o.order_id = oi.order_id
and   oi.product_id = p.product_id
group by c.customer_id, c.cust_last_name, c.cust_first_name
order by c.cust_last_name