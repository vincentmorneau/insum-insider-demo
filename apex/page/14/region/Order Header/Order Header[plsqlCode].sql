declare
    procedure draw_customer_row
    (
        p_first_name in varchar2,
        p_last_name  in varchar2,
        p_address1   in varchar2,
        p_address2   in varchar2,
        p_city       in varchar2,
        p_state      in varchar2,
        p_zipcode    in varchar2
    )
    is
    begin
        htp.p(apex_escape.html(p_first_name) || ' ' || apex_escape.html(p_last_name) || '<br />');
        htp.p(apex_escape.html(p_address1) || '<br />');
        if p_address2 is not null then
          htp.p(apex_escape.html(p_address2) || '<br />');
        end if;
        htp.p(apex_escape.html(p_city) || ', ' || apex_escape.html(p_state) || '  ' || apex_escape.html(p_zipcode) || '<br /><br />');
    end;
begin
    if :P11_CUSTOMER_OPTIONS = 'NEW' then
        for x in (select c001 as cust_first_name,
                         c002 as cust_last_name, 
                         c003 as cust_street_address1, 
                         c004 as cust_street_address2, 
                         c005 as cust_city, 
                         c006 as cust_state, 
                         c007 as cust_postal_code
                      from apex_collections
                     where collection_name = 'SDBA_CUSTOMERS'
                 )
        loop
            draw_customer_row
            (
                p_first_name => x.cust_first_name,
                p_last_name  => x.cust_last_name,
                p_address1   => x.cust_street_address1,
                p_address2   => x.cust_street_address2,
                p_city       => x.cust_city,
                p_state      => x.cust_state,
                p_zipcode    => x.cust_postal_code
            );
        end loop;
    else
        for x in (select c.cust_first_name,
                         c.cust_last_name, 
                         cust_street_address1, 
                         cust_street_address2, 
                         cust_city, 
                         cust_state, 
                         cust_postal_code 
                   from demo_customers c
                  where c.customer_id = :P14_CUSTOMER_ID)
        loop
            draw_customer_row
            (
                p_first_name => x.cust_first_name,
                p_last_name  => x.cust_last_name,
                p_address1   => x.cust_street_address1,
                p_address2   => x.cust_street_address2,
                p_city       => x.cust_city,
                p_state      => x.cust_state,
                p_zipcode    => x.cust_postal_code
            );
        end loop;
    end if;
end;