declare
    l_order_id    number;
    l_customer_id varchar2(30) := :P11_CUSTOMER_ID;
begin
    -- create collections
    --
    apex_collection.CREATE_OR_TRUNCATE_COLLECTION ('SDBA_CUSTOMERS');
    apex_collection.CREATE_OR_TRUNCATE_COLLECTION ('SDBA_ORDER_ITEMS');

    -- Create New Customer
    if :P11_CUSTOMER_OPTIONS = 'NEW' then
        apex_collection.add_member(
            p_collection_name => 'SDBA_CUSTOMERS',
            p_c001            => :P11_CUST_FIRST_NAME,
            p_c002            => :P11_CUST_LAST_NAME,
            p_c003            => :P11_CUST_STREET_ADDRESS1,
            p_c004            => :P11_CUST_STREET_ADDRESS2,
            p_c005            => :P11_CUST_CITY,
            p_c006            => :P11_CUST_STATE,
            p_c007            => :P11_CUST_POSTAL_CODE,
            p_c008            => :P11_CUST_EMAIL,
            p_c009            => :P11_PHONE_NUMBER1,
            p_c010            => :P11_PHONE_NUMBER2,
            p_c011            => :P11_URL,
            p_c012            => :P11_CREDIT_LIMIT,
            p_c013            => :P11_TAGS
        );
    end if;

    -- Loop through the ORDER collection and insert rows into the Order Line Item table
    for i in 1..apex_application.g_f01.count loop
        apex_collection.add_member(
            p_collection_name => 'SDBA_ORDER_ITEMS',
            p_c001            => to_number(apex_application.g_f01(i)), -- product_id
            p_c002            => to_number(apex_application.g_f02(i)), -- unit_price
            p_c003            => to_number(apex_application.g_f03(i))  -- quantity
        );
    end loop;
end;