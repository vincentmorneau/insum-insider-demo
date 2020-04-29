declare
    l_order_id    number;
    l_customer_id varchar2(30) := :P11_CUSTOMER_ID;
begin

    -- Create New Customer
    if :P11_CUSTOMER_OPTIONS = 'NEW' then
        insert into DEMO_CUSTOMERS (
            CUST_FIRST_NAME,
            CUST_LAST_NAME,
            CUST_STREET_ADDRESS1,
            CUST_STREET_ADDRESS2,
            CUST_CITY,
            CUST_STATE,
            CUST_POSTAL_CODE,
            CUST_EMAIL,
            PHONE_NUMBER1,
            PHONE_NUMBER2,
            URL,
            CREDIT_LIMIT,
            TAGS)
          values (
            :P11_CUST_FIRST_NAME,
            :P11_CUST_LAST_NAME,
            :P11_CUST_STREET_ADDRESS1,
            :P11_CUST_STREET_ADDRESS2,
            :P11_CUST_CITY,
            :P11_CUST_STATE,
            :P11_CUST_POSTAL_CODE,
            :P11_CUST_EMAIL,
            :P11_PHONE_NUMBER1,
            :P11_PHONE_NUMBER2,
            :P11_URL,
            :P11_CREDIT_LIMIT,
            :P11_TAGS)
          returning customer_id into l_customer_id;

          :P11_CUSTOMER_ID := l_customer_id;
    end if;

    -- Insert a row into the Order Header table
    insert into demo_orders(customer_id, order_total, order_timestamp, user_name)
       values(l_customer_id, null, systimestamp, upper(:APP_USER)) returning order_id into l_order_id;
    commit;

    -- Loop through the ORDER collection and insert rows into the Order Line Item table
    for i in
    (
        select c001 as product_id,
               c002 as unit_price,
               c003 as quantity
          from apex_collections
         where collection_name = 'SDBA_ORDER_ITEMS'
           and c003 <> 0
         order by 2
    )
    loop
       insert into demo_order_items(order_item_id, order_id, product_id, unit_price, quantity) 
         values (null, l_order_id, i.product_id, i.unit_price, i.quantity);
    end loop;
    commit;

    -- Set the item P14_ORDER_ID to the order which was just placed
    :P14_ORDER_ID := l_order_id;

    -- Truncate the collection after the order has been placed
    apex_collection.truncate_collection(p_collection_name => 'SDBA_CUSTOMERS');
    apex_collection.truncate_collection(p_collection_name => 'SDBA_ORDER_ITEMS');
end;