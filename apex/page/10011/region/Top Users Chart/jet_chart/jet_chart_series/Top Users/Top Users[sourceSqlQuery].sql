select lower(userid) as userid,
    count(*) as page_views
from apex_activity_log
where flow_id = :app_id
    and time_stamp >= sysdate - ( 1/24/60/60 * :P10011_TIMEFRAME )
    and userid is not null
group by lower(userid)
order by 2