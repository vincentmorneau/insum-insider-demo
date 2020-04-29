declare
  l_orders number := 0;
begin

    for i in 1..apex_application.g_f01.count loop
        l_orders := l_orders + to_number(apex_application.g_f03(i));
    end loop;

    if (l_orders = 0) then
        return false;
    else
        return true;
    end if;
end;