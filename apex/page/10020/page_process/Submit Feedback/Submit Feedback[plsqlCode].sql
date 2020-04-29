begin
apex_util.submit_feedback (
    p_comment              => :P10020_FEEDBACK,
    p_application_id       => :APP_ID,
    p_page_id              => :P10020_PAGE_ID,
    p_rating               => :P10020_RATING
  , p_attachment_name      => :P10020_ATTACHMENT_BLOB
 );
end;