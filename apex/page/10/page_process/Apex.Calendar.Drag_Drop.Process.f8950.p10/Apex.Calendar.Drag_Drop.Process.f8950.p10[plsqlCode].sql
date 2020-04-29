declare
    l_date_value         varchar2(32767) := apex_application.g_x01;
    l_primary_key_value  varchar2(32767) := apex_application.g_x02;
begin
    update "DEMO_ORDERS" set "ORDER_TIMESTAMP" = to_date(l_date_value,'RRRRMMDDHH24MISS') where "ORDER_ID"= l_primary_key_value;
end;