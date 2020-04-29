select lower(USERID) as username,
    max(time_stamp) as last_activity
from apex_activity_log
where flow_id = :app_id
    and time_stamp >= sysdate - ( 1/24/60/60 * :P10010_TIMEFRAME )
    and lower(USERID) is not null
group by lower(USERID)
order by 2 desc