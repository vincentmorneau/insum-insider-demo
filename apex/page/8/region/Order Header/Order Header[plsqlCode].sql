begin
for x in (select c.cust_first_name,
                 c.cust_last_name, 
                 cust_street_address1, 
                 cust_street_address2, 
                 cust_city, 
                 cust_state, 
                 cust_postal_code 
           from demo_customers c, demo_orders o
          where c.customer_id = o.customer_id 
            and o.order_id = :P8_ORDER_ID)
loop
  htp.p('<span style="font-size:16px;font-weight:bold;">ORDER #' || apex_escape.html(:P8_ORDER_ID) || '</span><br />');
  htp.p(apex_escape.html(x.cust_first_name) || ' ' || apex_escape.html(x.cust_last_name) || '<br />');
  htp.p(apex_escape.html(x.cust_street_address1) || '<br />');
  if x.cust_street_address2 is not null then
      htp.p(apex_escape.html(x.cust_street_address2) || '<br />');
  end if;
  htp.p(apex_escape.html(x.cust_city) || ', ' || apex_escape.html(x.cust_state) || '  ' || apex_escape.html(x.cust_postal_code) || '<br /><br />');
end loop;
end;