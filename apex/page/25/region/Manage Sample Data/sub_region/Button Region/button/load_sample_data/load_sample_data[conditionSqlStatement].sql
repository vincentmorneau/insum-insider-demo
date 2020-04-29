select null from demo_product_info where product_id <= 10
union all
select null from demo_customers where customer_id <= 10
union all
select null from demo_states
union all
select null from demo_constraint_lookup where constraint_name in ('DEMO_CUST_CREDIT_LIMIT_MAX','DEMO_CUSTOMERS_UK','DEMO_PRODUCT_INFO_UK','DEMO_ORDER_ITEMS_UK');