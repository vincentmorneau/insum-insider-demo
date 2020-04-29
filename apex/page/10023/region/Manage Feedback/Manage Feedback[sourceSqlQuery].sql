select feedback_id id,
    page_id||'. '||page_name page_name,
    created_on created,
    lower(created_by) created_by,
    feedback,
    feedback_rating rating,
    case feedback_rating
      when 1 then 'fa-frown-o feedback-negative' 
      when 2 then 'fa-emoji-neutral feedback-neutral'  
      when 3 then 'fa-smile-o feedback-positive'
    end rating_icon,
    feedback_status status,
    public_response response,
    http_user_agent user_agent,
    updated_on updated,
    lower(updated_by) updated_by,
    page_id
    , (select '<a href="'||apex_util.get_blob_file_src('P10023_ATTACHMENT',id)||'">'|| filename ||'</a>'
       from apex$team_dev_files
      where component_id = f.feedback_id
        and component_type = 'FEEDBACK') download_attachment
from apex_team_feedback f
where application_id = :APP_ID