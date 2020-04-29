select the_user,
    '<div class="hour-graph">'||
        '<span class="hour'|| case when h00 = 0 then ' is-null' when h00 > 999 then ' is-over1k' end ||'"><span class="hour-label"> 0</span> <span class="hour-value">'|| 
        case when h00 > 999 then to_char((h00/1000),'99999999D0') ||'k' else to_char(h00) end ||'</span></span>'||
        '<span class="hour'|| case when h01 = 0 then ' is-null' when h01 > 999 then ' is-over1k' end ||'"><span class="hour-label"> 1</span> <span class="hour-value">'|| 
        case when h01 > 999 then to_char((h01/1000),'99999999D0') ||'k' else to_char(h01) end ||'</span></span>'||
        '<span class="hour'|| case when h02 = 0 then ' is-null' when h02 > 999 then ' is-over1k' end ||'"><span class="hour-label"> 2</span> <span class="hour-value">'|| 
        case when h02 > 999 then to_char((h02/1000),'99999999D0') ||'k' else to_char(h02) end ||'</span></span>'||
        '<span class="hour'|| case when h03 = 0 then ' is-null' when h03 > 999 then ' is-over1k' end ||'"><span class="hour-label"> 3</span> <span class="hour-value">'|| 
        case when h03 > 999 then to_char((h03/1000),'99999999D0') ||'k' else to_char(h03) end ||'</span></span>'||
        '<span class="hour'|| case when h04 = 0 then ' is-null' when h04 > 999 then ' is-over1k' end ||'"><span class="hour-label"> 4</span> <span class="hour-value">'|| 
        case when h04 > 999 then to_char((h04/1000),'99999999D0') ||'k' else to_char(h04) end ||'</span></span>'||
        '<span class="hour'|| case when h05 = 0 then ' is-null' when h05 > 999 then ' is-over1k' end ||'"><span class="hour-label"> 5</span> <span class="hour-value">'|| 
        case when h05 > 999 then to_char((h05/1000),'99999999D0') ||'k' else to_char(h05) end ||'</span></span>'||
        '<span class="hour'|| case when h06 = 0 then ' is-null' when h06 > 999 then ' is-over1k' end ||'"><span class="hour-label"> 6</span> <span class="hour-value">'|| 
        case when h06 > 999 then to_char((h06/1000),'99999999D0') ||'k' else to_char(h06) end ||'</span></span>'||
        '<span class="hour'|| case when h07 = 0 then ' is-null' when h07 > 999 then ' is-over1k' end ||'"><span class="hour-label"> 7</span> <span class="hour-value">'|| 
        case when h07 > 999 then to_char((h07/1000),'99999999D0') ||'k' else to_char(h07) end ||'</span></span>'||
        '<span class="hour'|| case when h08 = 0 then ' is-null' when h08 > 999 then ' is-over1k' end ||'"><span class="hour-label"> 8</span> <span class="hour-value">'|| 
        case when h08 > 999 then to_char((h08/1000),'99999999D0') ||'k' else to_char(h08) end ||'</span></span>'||
        '<span class="hour'|| case when h09 = 0 then ' is-null' when h09 > 999 then ' is-over1k' end ||'"><span class="hour-label"> 9</span> <span class="hour-value">'|| 
        case when h09 > 999 then to_char((h09/1000),'99999999D0') ||'k' else to_char(h09) end ||'</span></span>'||
        '<span class="hour'|| case when h10 = 0 then ' is-null' when h10 > 999 then ' is-over1k' end ||'"><span class="hour-label">10</span> <span class="hour-value">'|| 
        case when h10 > 999 then to_char((h10/1000),'99999999D0') ||'k' else to_char(h10) end ||'</span></span>'||
        '<span class="hour'|| case when h11 = 0 then ' is-null' when h11 > 999 then ' is-over1k' end ||'"><span class="hour-label">11</span> <span class="hour-value">'|| 
        case when h11 > 999 then to_char((h11/1000),'99999999D0') ||'k' else to_char(h11) end ||'</span></span>'||
        '<span class="hour'|| case when h12 = 0 then ' is-null' when h12 > 999 then ' is-over1k' end ||'"><span class="hour-label">12</span> <span class="hour-value">'|| 
        case when h12 > 999 then to_char((h12/1000),'99999999D0') ||'k' else to_char(h12) end ||'</span></span>'||
        '<span class="hour'|| case when h13 = 0 then ' is-null' when h13 > 999 then ' is-over1k' end ||'"><span class="hour-label">13</span> <span class="hour-value">'|| 
        case when h13 > 999 then to_char((h13/1000),'99999999D0') ||'k' else to_char(h13) end ||'</span></span>'||
        '<span class="hour'|| case when h14 = 0 then ' is-null' when h14 > 999 then ' is-over1k' end ||'"><span class="hour-label">14</span> <span class="hour-value">'|| 
        case when h14 > 999 then to_char((h14/1000),'99999999D0') ||'k' else to_char(h14) end ||'</span></span>'||
        '<span class="hour'|| case when h15 = 0 then ' is-null' when h15 > 999 then ' is-over1k' end ||'"><span class="hour-label">15</span> <span class="hour-value">'|| 
        case when h15 > 999 then to_char((h15/1000),'99999999D0') ||'k' else to_char(h15) end ||'</span></span>'||
        '<span class="hour'|| case when h16 = 0 then ' is-null' when h16 > 999 then ' is-over1k' end ||'"><span class="hour-label">16</span> <span class="hour-value">'|| 
        case when h16 > 999 then to_char((h16/1000),'99999999D0') ||'k' else to_char(h16) end ||'</span></span>'||
        '<span class="hour'|| case when h17 = 0 then ' is-null' when h17 > 999 then ' is-over1k' end ||'"><span class="hour-label">17</span> <span class="hour-value">'|| 
        case when h17 > 999 then to_char((h17/1000),'99999999D0') ||'k' else to_char(h17) end ||'</span></span>'||
        '<span class="hour'|| case when h18 = 0 then ' is-null' when h18 > 999 then ' is-over1k' end ||'"><span class="hour-label">18</span> <span class="hour-value">'|| 
        case when h18 > 999 then to_char((h18/1000),'99999999D0') ||'k' else to_char(h18) end ||'</span></span>'||
        '<span class="hour'|| case when h19 = 0 then ' is-null' when h19 > 999 then ' is-over1k' end ||'"><span class="hour-label">19</span> <span class="hour-value">'|| 
        case when h19 > 999 then to_char((h19/1000),'99999999D0') ||'k' else to_char(h19) end ||'</span></span>'||
        '<span class="hour'|| case when h20 = 0 then ' is-null' when h20 > 999 then ' is-over1k' end ||'"><span class="hour-label">20</span> <span class="hour-value">'|| 
        case when h20 > 999 then to_char((h20/1000),'99999999D0') ||'k' else to_char(h20) end ||'</span></span>'||
        '<span class="hour'|| case when h21 = 0 then ' is-null' when h21 > 999 then ' is-over1k' end ||'"><span class="hour-label">21</span> <span class="hour-value">'|| 
        case when h21 > 999 then to_char((h21/1000),'99999999D0') ||'k' else to_char(h21) end ||'</span></span>'||
        '<span class="hour'|| case when h22 = 0 then ' is-null' when h22 > 999 then ' is-over1k' end ||'"><span class="hour-label">22</span> <span class="hour-value">'|| 
        case when h22 > 999 then to_char((h22/1000),'99999999D0') ||'k' else to_char(h22) end ||'</span></span>'||
        '<span class="hour'|| case when h23 = 0 then ' is-null' when h23 > 999 then ' is-over1k' end ||'"><span class="hour-label">23</span> <span class="hour-value">'|| 
        case when h23 > 999 then to_char((h23/1000),'99999999D0') ||'k' else to_char(h23) end ||'</span></span>'||
        '</div>' hours,
        page_events,
    median_elapsed,
    rows_fetched,
    ir_searches,
    errors,
    most_recent
    from (  
    select lower(userid)                as the_user,
        count(*)                        as page_events,
        median(elap)                    as median_elapsed,
        sum(num_rows)                   as rows_fetched,
        sum(decode(ir_search,null,0,1)) as ir_searches,
        sum(decode(sqlerrm,null,0,1))   as errors,
        max(time_stamp)                 as most_recent,
        sum(decode(to_char(time_stamp,'HH24'),0,1,0)) h00,
        sum(decode(to_char(time_stamp,'HH24'),1,1,0)) h01,
        sum(decode(to_char(time_stamp,'HH24'),2,1,0)) h02,
        sum(decode(to_char(time_stamp,'HH24'),3,1,0)) h03,
        sum(decode(to_char(time_stamp,'HH24'),4,1,0)) h04,
        sum(decode(to_char(time_stamp,'HH24'),5,1,0)) h05,
        sum(decode(to_char(time_stamp,'HH24'),6,1,0)) h06,
        sum(decode(to_char(time_stamp,'HH24'),7,1,0)) h07,
        sum(decode(to_char(time_stamp,'HH24'),8,1,0)) h08,
        sum(decode(to_char(time_stamp,'HH24'),9,1,0)) h09,
        sum(decode(to_char(time_stamp,'HH24'),10,1,0)) h10,
        sum(decode(to_char(time_stamp,'HH24'),11,1,0)) h11,
        sum(decode(to_char(time_stamp,'HH24'),12,1,0)) h12,
        sum(decode(to_char(time_stamp,'HH24'),13,1,0)) h13,
        sum(decode(to_char(time_stamp,'HH24'),14,1,0)) h14,
        sum(decode(to_char(time_stamp,'HH24'),15,1,0)) h15,
        sum(decode(to_char(time_stamp,'HH24'),16,1,0)) h16,
        sum(decode(to_char(time_stamp,'HH24'),17,1,0)) h17,
        sum(decode(to_char(time_stamp,'HH24'),18,1,0)) h18,
        sum(decode(to_char(time_stamp,'HH24'),19,1,0)) h19,
        sum(decode(to_char(time_stamp,'HH24'),20,1,0)) h20,
        sum(decode(to_char(time_stamp,'HH24'),21,1,0)) h21,
        sum(decode(to_char(time_stamp,'HH24'),22,1,0)) h22,
        sum(decode(to_char(time_stamp,'HH24'),23,1,0)) h23
    from apex_activity_log l
    where flow_id = :APP_ID
        and time_stamp >= sysdate - ( 1/24/60/60 * :P10011_TIMEFRAME )
        and userid is not null
    group by lower(userid)) x