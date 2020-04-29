select '15 '||wwv_flow_lang.system_message(initcap('MINUTES')) d, 
trim(to_char(15/(24*60),'00000.99999999999','NLS_NUMERIC_CHARACTERS=''.,''')) t from dual union all 
select '30 '||wwv_flow_lang.system_message(initcap('MINUTES')) d, 
trim(to_char(30/(24*60),'00000.99999999999','NLS_NUMERIC_CHARACTERS=''.,''')) t from dual union all 
select '1 '||wwv_flow_lang.system_message(initcap('HOUR')) d, 
trim(to_char(1/24,'00000.99999999999','NLS_NUMERIC_CHARACTERS=''.,''')) t from dual union all 
select '90 '||wwv_flow_lang.system_message(initcap('MINUTES')) d, 
trim(to_char(90/(24*60),'00000.99999999999','NLS_NUMERIC_CHARACTERS=''.,''')) t from dual union all 
select '2 '||wwv_flow_lang.system_message(initcap('HOURS')) d, 
trim(to_char(1/12,'00000.99999999999','NLS_NUMERIC_CHARACTERS=''.,'''))  t from dual union all 
select '3 '||wwv_flow_lang.system_message(initcap('HOURS')) d, 
trim(to_char(3/24,'00000.99999999999','NLS_NUMERIC_CHARACTERS=''.,'''))  t from dual union all 
select '4 '||wwv_flow_lang.system_message(initcap('HOURS')) d, 
trim(to_char(4/24,'00000.99999999999','NLS_NUMERIC_CHARACTERS=''.,'''))  t from dual union all 
select '5 '||wwv_flow_lang.system_message(initcap('HOURS')) d, 
trim(to_char(5/24,'00000.99999999999','NLS_NUMERIC_CHARACTERS=''.,'''))  t from dual union all 
select '6 '||wwv_flow_lang.system_message(initcap('HOURS')) d, 
trim(to_char(6/24,'00000.99999999999','NLS_NUMERIC_CHARACTERS=''.,''')) t from dual union all 
select '8 '||wwv_flow_lang.system_message(initcap('HOURS')) d, 
trim(to_char(8/24,'00000.99999999999','NLS_NUMERIC_CHARACTERS=''.,''')) t from dual union all 
select '10 '||wwv_flow_lang.system_message(initcap('HOURS')) d, 
trim(to_char(10/24,'00000.99999999999','NLS_NUMERIC_CHARACTERS=''.,''')) t from dual union all 
select '12 '||wwv_flow_lang.system_message(initcap('HOURS')) d, 
trim(to_char(12/24,'00000.99999999999','NLS_NUMERIC_CHARACTERS=''.,''')) t from dual union all 
select '16 '||wwv_flow_lang.system_message(initcap('HOURS')) d, 
trim(to_char(16/24,'00000.9999999999','NLS_NUMERIC_CHARACTERS=''.,''')) t from dual union all 
select '1 '||wwv_flow_lang.system_message(initcap('DAY')) d, trim(to_char(1,'00000.9999999999')) t 
from dual union all 
select '2 '||wwv_flow_lang.system_message(initcap('DAYS')) d, trim(to_char(2,'00000.9999999999')) t 
from dual union all 
select '3 '||wwv_flow_lang.system_message(initcap('DAYS')) d, trim(to_char(3,'00000.9999999999')) t 
from dual union all 
select '4 '||wwv_flow_lang.system_message(initcap('DAYS')) d, trim(to_char(4,'00000.9999999999')) t 
from dual union all 
select '5 '||wwv_flow_lang.system_message(initcap('DAYS')) d, trim(to_char(5,'00000.9999999999')) t 
from dual union all 
select '1 '||wwv_flow_lang.system_message(initcap('WEEK')) d, trim(to_char(7,'00000.9999999999')) t   
from dual union all 
select '2 '||wwv_flow_lang.system_message(initcap('WEEKS')) d, trim(to_char(14,'00000.9999999999')) t   
from dual order by 2