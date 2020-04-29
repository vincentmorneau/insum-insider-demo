select s.theme_style_id
from apex_application_theme_styles s, apex_application_themes t
where s.application_id = t.application_id
and s.theme_number = t.theme_number
and s.application_id = :app_id
and t.ui_type_name   = 'DESKTOP'
and s.is_current = 'Yes'