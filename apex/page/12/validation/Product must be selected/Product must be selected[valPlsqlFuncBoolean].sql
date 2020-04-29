for i in 1..apex_application.g_f01.count
loop
    if apex_application.g_f03(i) is not null and apex_application.g_f03(i) != '0' then
        return true;
    end if;
end loop;

return false;