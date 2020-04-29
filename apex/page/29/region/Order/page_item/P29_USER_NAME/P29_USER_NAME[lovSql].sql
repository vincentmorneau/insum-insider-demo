select distinct user_name d, user_name r from demo_orders 
union
select upper(:APP_USER) d, upper(:APP_USER) r from dual
order by 1