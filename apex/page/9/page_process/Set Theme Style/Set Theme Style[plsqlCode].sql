if :P9_DESKTOP_THEME_STYLE_ID is not null then
    for c1 in (select theme_number
               from apex_application_themes
               where application_id = :app_id
               and ui_type_name   = 'DESKTOP'
               and is_current = 'Yes')
    loop
        apex_util.set_current_theme_style (
            p_theme_number   => c1.theme_number,
            p_theme_style_id => :P9_DESKTOP_THEME_STYLE_ID
            );
    end loop;
end if;

if :P9_MOBILE_THEME_STYLE_ID is not null then
    for c1 in (select theme_number
               from apex_application_themes
               where application_id = :app_id
               and ui_type_name   = 'JQM_SMARTPHONE'
               and is_current = 'Yes')
    loop
        apex_util.set_current_theme_style (
            p_theme_number   => c1.theme_number,
            p_theme_style_id => :P9_MOBILE_THEME_STYLE_ID
            );
    end loop;
end if;