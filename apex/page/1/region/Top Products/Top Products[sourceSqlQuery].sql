Select p.product_name||' - '||SUM(oi.quantity)||' x '||to_char(p.list_price,'L99G999')||'' product,
       SUM(oi.quantity * oi.unit_price) sales,  p.product_id
from demo_order_items oi
,    demo_product_info p
where oi.product_id = p.product_id
group by p.Product_id, p.product_name, p.list_price
order by 2 desc