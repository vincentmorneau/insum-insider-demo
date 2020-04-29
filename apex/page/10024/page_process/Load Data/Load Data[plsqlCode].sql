for c1 in (
   select page_id,
          page_name,
          case feedback_rating
                when 1 then '<span class="fa fa-frown-o feedback-negative" aria-hidden="true" title="Negative"></span>' 
                when 2 then '<span class="fa fa-emoji-neutral feedback-neutral" aria-hidden="true" title="Neutral"></span>'  
                when 3 then '<span class="fa fa-smile-o feedback-positive" aria-hidden="true" title="Positive"></span>' 
                end rating_icon,
          lower(created_by) || ' - ' || apex_util.get_since(created_on) filed,
          feedback,
          public_response,
          feedback_status,
          http_user_agent
     from apex_team_feedback
    where feedback_id = :P10024_ID
) loop
   :P10024_PAGE_ID := c1.page_id||'. '||c1.page_name;
   :P10024_FILED := c1.filed;
   :P10024_RATING_ICON := c1.rating_icon;
   :P10024_FEEDBACK := c1.feedback;
   :P10024_RESPONSE := c1.public_response;
   :P10024_FEEDBACK_STATUS := c1.feedback_status;
   :P10024_USER_AGENT := c1.http_user_agent;
end loop;