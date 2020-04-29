select customer_id, 
       cust_last_name || ', ' || cust_first_name customer_name, 
       cust_street_address1 || decode(cust_street_address2, null, null, ', ' || cust_street_address2) customer_address, 
       cust_city, 
       cust_state, 
       cust_postal_code,
       tags
from demo_customers