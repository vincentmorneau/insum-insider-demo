SELECT
    b.cust_last_name || ', ' || b.cust_first_name as list_title,
    'fa-user' as icon,
    nvl(SUM(a.ORDER_TOTAL),0) order_total,
    count(a.order_id) as order_cnt,
    b.customer_id id,
    b.CUST_STREET_ADDRESS1,
    b.CUST_STREET_ADDRESS2,
    b.CUST_CITY,
    b.CUST_STATE,
    b.CUST_POSTAL_CODE,
    b.CUST_EMAIL,
    apex_page.get_url(p_page => 7,  p_items => 'P7_CUSTOMER_ID,P7_BRANCH', p_values => b.customer_id ||','|| '1') link,
    ' ' link_attr,
    ' ' link_class,
    ' ' list_badge,
    ' ' list_class,
    ' ' list_text,
    b.PHONE_NUMBER1,
    b.PHONE_NUMBER2,
    b.CREDIT_LIMIT,
    b.tags
FROM
    demo_orders a,
    DEMO_CUSTOMERS b
WHERE
    a.customer_id = b.customer_id
GROUP BY
    b.customer_id,
    b.cust_last_name || ', ' || b.cust_first_name,
    b.CUST_STREET_ADDRESS1,
    b.CUST_STREET_ADDRESS2,
    b.CUST_CITY,
    b.CUST_STATE,
    b.CUST_POSTAL_CODE,
    b.CUST_EMAIL,
    b.PHONE_NUMBER1,
    b.PHONE_NUMBER2,
    b.CREDIT_LIMIT,
    b.tags
ORDER BY
    3 DESC