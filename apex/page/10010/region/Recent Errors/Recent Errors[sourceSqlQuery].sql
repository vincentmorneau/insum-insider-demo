select
    sqlerrm label,
    time_stamp value
from apex_activity_log
where flow_id = :app_id
and time_stamp >= sysdate - ( 1/24/60/60 * :P10010_TIMEFRAME )
and sqlerrm is not null
order by 2 desc, 1