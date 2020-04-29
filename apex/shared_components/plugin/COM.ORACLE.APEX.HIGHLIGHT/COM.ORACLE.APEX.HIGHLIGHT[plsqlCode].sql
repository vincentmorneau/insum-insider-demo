-- The render function generates the necessary javascript code for the
-- dynamic action plug-in and registers this function with the dynamic action
-- client side framework.
-- The render function has a defined interface which every plug-in has to
-- implement. It's designed in a way that future enhancements to the interface
-- will not break existing plug-ins.
function render_highlight (
    p_dynamic_action in apex_plugin.t_dynamic_action,
    p_plugin         in apex_plugin.t_plugin )
    return apex_plugin.t_dynamic_action_render_result
is
    l_result apex_plugin.t_dynamic_action_render_result;
begin
    -- During plug-in development it's very helpful to have some debug information
    if apex_application.g_debug then
        apex_plugin_util.debug_dynamic_action (
            p_plugin         => p_plugin,
            p_dynamic_action => p_dynamic_action );
    end if;
    -- ***********************************
    -- Here starts the actual plug-in code
    -- ***********************************
    -- Register the javascript library the plug-in uses.
    -- The add_library call will make sure that just one instance of the
    -- library is loaded when the plug-in is used multiple times on the page.
    -- If the developer stores the javascript file on the web-server, the
    -- p_plugin.file_prefix will contain the web-server URL. If the variable
    -- contains #PLUGIN_PREFIX#, the file will be read from the database.
    apex_javascript.add_library (
        p_name      => 'highlight',
        p_directory => p_plugin.file_prefix,
        p_version   => null );
    -- Register the javascript function which should be called when the plug-in
    -- action is executed with the APEX client side dynamic action framework.
    -- The javascript function can be a named javascript function, but it can
    -- also be an anonymous function if the code is really short.
    -- For example: function(){this.affectedElements.hide(this.action.attribute01);}
    l_result.javascript_function := 'com_yourcompany_apex_highlight';
    -- use the application level values if they are not set on instance level
    l_result.attribute_01        := coalesce(p_dynamic_action.attribute_01, p_plugin.attribute_01);
    l_result.attribute_02        := coalesce(p_dynamic_action.attribute_02, p_plugin.attribute_02);

    return l_result;
end render_highlight;
