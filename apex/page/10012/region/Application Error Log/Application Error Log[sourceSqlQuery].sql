select
    step_id,
    userid,
    time_stamp err_time,
    sqlerrm,
    sqlerrm_component_type,
    sqlerrm_component_name
from apex_activity_log
where flow_id = :app_id
and sqlerrm is not null