select apex_escape.html(product_name) || ' [$' || list_price || ']' d, product_id r from demo_product_info
where product_avail = 'Y'
order by 1