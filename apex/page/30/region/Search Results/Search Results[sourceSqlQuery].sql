select
    search_title,
    apex_util.prepare_url(search_link) search_link,
    search_desc,
    'Type' as label_01,
    type as value_01,
    null search_date
from (
    select  1 display_seq,
        customer_id id,
        'Customer' type,
        cust_last_name||', '||cust_first_name search_title,
        cust_street_address1||' '||cust_street_address2||', '||cust_city||' '||cust_state||' '||cust_postal_code search_desc,
        'f?p='||:APP_ID||':7:'||:APP_SESSION||':::7:P7_CUSTOMER_ID,P7_BRANCH:'||apex_escape.html(customer_id)||',30' search_link
    from demo_customers
    where ( instr(upper(cust_first_name),upper(:P30_SEARCH)) > 0 
            or instr(upper(cust_last_name),upper(:P30_SEARCH)) > 0 
            or instr(upper(cust_email),upper(:P30_SEARCH)) > 0 
            or instr(upper(cust_street_address1),upper(:P30_SEARCH)) > 0 
            or instr(upper(cust_street_address2),upper(:P30_SEARCH)) > 0 
            or instr(upper(cust_city),upper(:P30_SEARCH)) > 0 
            or instr(upper(cust_state),upper(:P30_SEARCH)) > 0 
            or instr(upper(cust_postal_code),upper(:P30_SEARCH)) > 0 
            or instr(upper(phone_number1),upper(:P30_SEARCH)) > 0 
            or instr(upper(phone_number2),upper(:P30_SEARCH)) > 0 
            or :P30_SEARCH is null )
        and instr(:P30_OPTIONS,'C') > 0
    union all
    select 2 display_seq,
        product_id id,
        'Product' type,
        product_name title,
        category||' $'||list_price||' '
            ||( case when length(product_description) > 50 then
                    substr(product_description,1,50)||'...'
                else
                    product_description
                end ) detail,
        'f?p='||:APP_ID||':6:'||:APP_SESSION||':::6:P6_PRODUCT_ID,P6_BRANCH:'||apex_escape.html(product_id)||',30' search_link
    from demo_product_info
    where ( instr(upper(product_name),upper(:P30_SEARCH)) > 0 
            or instr(upper(product_description),upper(:P30_SEARCH)) > 0 
            or instr(upper(category),upper(:P30_SEARCH)) > 0 
            or instr(upper(list_price),upper(:P30_SEARCH)) > 0 
            or :P30_SEARCH is null )
        and instr(:P30_OPTIONS,'P') > 0
    union all
    select distinct 3 display_seq,
        o.order_id id,
        'Order' type,
        o.order_timestamp||' $'||o.order_total title,
        c.cust_last_name||', '||c.cust_first_name detail,
        'f?p='||:APP_ID||':29:'||:APP_SESSION||':SEARCH::29:P29_ORDER_ID,P29_LAST_PAGE:'||apex_escape.html(o.order_id)||',30' search_link
    from demo_orders o,
        demo_customers c,
        demo_order_items oi,
        demo_product_info p
    where o.customer_id = c.customer_id
        and o.order_id = oi.order_id
        and oi.product_id = p.product_id
        and ( instr(upper(o.order_total),upper(:P30_SEARCH)) > 0 
            or instr(upper(o.order_timestamp),upper(:P30_SEARCH)) > 0 
            or instr(upper(o.order_total),upper(:P30_SEARCH)) > 0 
            or instr(upper(c.cust_first_name),upper(:P30_SEARCH)) > 0 
            or instr(upper(c.cust_last_name),upper(:P30_SEARCH)) > 0 
            or instr(upper(p.product_name),upper(:P30_SEARCH)) > 0 
            or instr(upper(p.product_description),upper(:P30_SEARCH)) > 0 
            or instr(upper(p.category),upper(:P30_SEARCH)) > 0 
            or :P30_SEARCH is null )
        and instr(:P30_OPTIONS,'O') > 0
    union all
    select 4 display_seq,
        customer_id id,
        'Customer' type,
        cust_last_name||', '||cust_first_name title,
        cust_street_address1||' '||cust_street_address2||', '||cust_city||' '||cust_state||' '||cust_postal_code detail,
        'f?p='||:APP_ID||':7:'||:APP_SESSION||':::7:P7_CUSTOMER_ID,P7_BRANCH:'||apex_escape.html(customer_id)||',30' search_link
    from demo_customers
    where instr(upper(tags),upper(:P30_SEARCH)) > 0 
        and instr(:P30_OPTIONS,'T') > 0
    union all
    select 4 display_seq,
        product_id id,
        'Product' type,
        product_name title,
        category||' $'||list_price||' '
            ||( case when length(product_description) > 50 then
                    substr(product_description,1,50)||'...'
                else
                    product_description
                end ) detail,
        'f?p='||:APP_ID||':6:'||:APP_SESSION||':::6:P6_PRODUCT_ID,P6_BRANCH:'||apex_escape.html(product_id)||',30' search_link
    from demo_product_info
    where instr(upper(tags),upper(:P30_SEARCH)) > 0 
        and instr(:P30_OPTIONS,'T') > 0
    union all
    select distinct 4 display_seq,
        o.order_id id,
        'Order' type,
        o.order_timestamp||' $'||o.order_total title,
        c.cust_last_name||', '||c.cust_first_name detail,
        'f?p='||:APP_ID||':29:'||:APP_SESSION||':SEARCH::29:P29_ORDER_ID:'||apex_escape.html(o.order_id) search_link
    from demo_orders o,
        demo_customers c,
        demo_order_items oi,
        demo_product_info p
    where o.customer_id = c.customer_id
        and o.order_id = oi.order_id
        and oi.product_id = p.product_id
        and instr(upper(o.tags),upper(:P30_SEARCH)) > 0 
        and instr(:P30_OPTIONS,'T') > 0
) order by display_seq, search_title