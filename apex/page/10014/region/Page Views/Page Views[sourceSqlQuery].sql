select 
    step_id||'. '||(select page_name
                    from apex_application_pages p
                    where p.page_id = l.step_id
                        and p.application_id = :APP_ID) page_name,
    lower(userid) user_id,
    time_stamp    timestamp,
    elap          elapsed,
    step_id       page,
    decode(page_mode,'P','Partial','D','Full',page_mode) page_mode,
    component_name,
    num_rows,
    ir_search,
    sqlerrm  error
from apex_activity_log l
where flow_id = :app_id
    and time_stamp >= sysdate - ( 1/24/60/60 * :P10014_TIMEFRAME )
    and userid is not null
    and step_id is not null
order by time_stamp desc