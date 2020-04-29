select x.step_id||'. '||(select page_name from apex_application_pages p where p.application_id = :app_id and page_id = x.step_id) label, 
        value 
from
(
select step_id,
    count(*) as value
from apex_activity_log
where flow_id = :app_id
    and time_stamp >= sysdate - ( 1/24/60/60 * :P10010_TIMEFRAME )
    and step_id is not null
group by step_id
order by 2 desc
) x