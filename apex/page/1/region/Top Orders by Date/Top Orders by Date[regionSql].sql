select to_char(o.order_timestamp,'Month DD, YYYY') order_day,
    SUM(o.order_total) sales,
    'f?p=&APP_ID.:4:'||:app_session
        ||'::&DEBUG.:RIR,4:IREQ_ORDER_DATE:'
        ||to_char(trunc(order_timestamp),'MM/DD/YYYY')  the_link
from demo_orders o
group by to_char(o.order_timestamp,'Month DD, YYYY'), order_timestamp
order by 2 desc nulls last
