declare
  l_customer_id varchar2(30) := :P11_CUSTOMER_ID;
begin
--
-- display customer information
--
sys.htp.p('<div class="demoCustomerInfo">');
if :P11_CUSTOMER_OPTIONS = 'EXISTING' then
  for x in (select * from demo_customers where customer_id = l_customer_id) loop
    sys.htp.p('<strong>Customer:</strong>');
    sys.htp.p('<p>');
    sys.htp.p(apex_escape.html(x.cust_first_name) || ' ' ||
    apex_escape.html(x.cust_last_name) || '<br />');
    sys.htp.p(apex_escape.html(x.cust_street_address1) || '<br />');
    if x.cust_street_address2 is not null then
      sys.htp.p(apex_escape.html(x.cust_street_address2) || '<br />');
    end if;
    sys.htp.p(apex_escape.html(x.cust_city) || ', ' ||
    apex_escape.html(x.cust_state) || '  ' ||
    apex_escape.html(x.cust_postal_code));
    sys.htp.p('</p>');
  end loop;
else
  sys.htp.p('<strong>Customer:</strong>');
  sys.htp.p('<p>');
  sys.htp.p(apex_escape.html(:P11_CUST_FIRST_NAME) || ' ' || apex_escape.html(:P11_CUST_LAST_NAME) || '<br />');
  sys.htp.p(apex_escape.html(:P11_CUST_STREET_ADDRESS1) || '<br />');
  if :P11_CUST_STREET_ADDRESS2 is not null then
    sys.htp.p(apex_escape.html(:P11_CUST_STREET_ADDRESS2) || '<br />');
  end if;
  sys.htp.p(apex_escape.html(:P11_CUST_CITY) || ', ' ||
  apex_escape.html(:P11_CUST_STATE) || '  ' ||
  apex_escape.html(:P11_CUST_POSTAL_CODE));
  sys.htp.p('</p>');
end if;
sys.htp.p('<br></div>');
end;