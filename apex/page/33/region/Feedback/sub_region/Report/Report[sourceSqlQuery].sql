select l.display_value feedback_status, 
(select count(*) from apex_team_feedback f where f.application_id = :APP_ID and f.feedback_status = l.return_value) feedback_count 
from apex_application_lov_entries l
where l.application_id = :APP_ID
and l.list_of_values_name = 'FEEDBACK_STATUS'
order by 2 desc, 1