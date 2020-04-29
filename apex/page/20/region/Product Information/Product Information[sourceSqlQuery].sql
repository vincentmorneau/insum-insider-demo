select product_name,
product_description,
category,
list_price
from demo_product_info where product_id = :P20_PRODUCT_ID
order by 1