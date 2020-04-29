select nvl(lower(userid),'not identified') as label,
    count(*) as value
from apex_activity_log
where flow_id = :app_id
    and time_stamp >= sysdate - ( 1/24/60/60 * :P10010_TIMEFRAME )
group by nvl(lower(userid),'not identified')
order by 2 desc