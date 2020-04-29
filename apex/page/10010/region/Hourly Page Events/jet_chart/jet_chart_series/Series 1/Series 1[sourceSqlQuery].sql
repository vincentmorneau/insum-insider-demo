with nw as (
    -- APEX_ACTIVITY_LOG uses dates; convert system time to local time zone.
    select from_tz( cast( sysdate as timestamp ), to_char( systimestamp, 'TZR' ) ) at local as tm from dual
),
window as (
    select
         trunc(nw.tm - ((level-1)/24),'HH') start_tm,
         trunc(nw.tm - ((level-2)/24),'HH') end_tm,
         trunc(sysdate-((level-1)/24),'HH') log_start_tm,
         trunc(sysdate-((level-2)/24),'HH') log_end_tm
    from nw
    connect by level <= round( 24 * ( 1/24/60/60 * nvl(:P10010_TIMEFRAME,1) ) )
)
select  w.start_tm log_time,
    (   select count(*)
        from apex_activity_log l
        where l.flow_id = :app_id
            and l.time_stamp between w.log_start_tm and w.log_end_tm ) as value
from window w
order by 1