select '<a href="'||apex_util.get_blob_file_src('P10023_ATTACHMENT',id)||'">'||filename||'</a>'
  from apex$team_dev_files
 where component_id = :P10024_ID
   and component_type = 'FEEDBACK'