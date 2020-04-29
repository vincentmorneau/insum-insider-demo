select apex_util.prepare_url('f?p='||:APP_ID||':2:'||:app_session||':::2,RIR:IR_CUST_STATE:'||
             cust_state) click_link,
       cust_state region_id,
       count(*) count_of_customers
  from demo_customers
group by cust_state