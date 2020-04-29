select
    'Monthly Sales' as label,
     trim(to_char(nvl(sum(o.order_total),0),'L99G999')) as value,
    apex_util.prepare_url( 'f?p='||:APP_ID||':4:'||:APP_SESSION||':::4,RIR:IRGTE_ORDER_DATE:'||:P1_THIS_MONTH ) as url
from demo_orders o
where order_timestamp >= to_date(to_char(sysdate,'YYYYMM')||'01','YYYYMMDD')
union all
select 
    'Monthly Orders' as label,
    trim(to_char(count(distinct o.order_id),'999G999G999G999G990')) as value,
    apex_util.prepare_url( 'f?p='||:APP_ID||':4:'||:APP_SESSION||':::4,RIR:IRGTE_ORDER_DATE:'||:P1_THIS_MONTH ) as url
from demo_orders o
where order_timestamp >= to_date(to_char(sysdate,'YYYYMM')||'01','YYYYMMDD')
union all
select 'Total Products' as label,
        trim(to_char(count(distinct p.product_name),'999G999G999G999G990')) as value,
        apex_util.prepare_url( 'f?p='||:APP_ID||':3:'||:APP_SESSION||':::' ) as url
from demo_product_info p
union all
select 'Total Customers' as label,
        trim(to_char(count(*),'999G999G999G999G990')) as value,
        apex_util.prepare_url( 'f?p='||:APP_ID||':2:'||:APP_SESSION||':::' ) as url
from DEMO_CUSTOMERS