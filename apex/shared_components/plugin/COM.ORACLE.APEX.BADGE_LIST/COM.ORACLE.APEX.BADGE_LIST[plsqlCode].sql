function render (
    p_region              in apex_plugin.t_region,
    p_plugin              in apex_plugin.t_plugin,
    p_is_printer_friendly in boolean )
    return apex_plugin.t_region_render_result is
begin
    apex_javascript.add_onload_code (
        p_code => 'com_oracle_apex_badgelist('||
            apex_javascript.add_value(p_region.static_id)||
            '{'||
                -- why is this attribute needed if is not used?
                apex_javascript.add_attribute(
                    'pageItems', 
                    apex_plugin_util.page_item_names_to_jquery(p_region.ajax_items_to_submit)
                )||
                apex_javascript.add_attribute(
                    'ajaxIdentifier', 
                    apex_plugin.get_ajax_identifier, 
                    false, 
                    false
                )||
            '}'||
        ');'
    );
--    CSS for Big Value List
--    apex_css.add_file (
--        p_name      => 'com_oracle_apex_badge_list',
--        p_directory => p_plugin.file_prefix );
    -- Start the list


    -- It's time to emit the selected rows


    return null;

end render;

function ajax (
    p_region in apex_plugin.t_region,
    p_plugin in apex_plugin.t_plugin
) return apex_plugin.t_region_ajax_result 
is
    -- It's better to have named variables instead of using the generic ones,
    -- makes the code more readable. We are using the same defaults for the
    -- required attributes as in the plug-in attribute configuration, because
    -- they can still be null. Keep them in sync!
    c_top_label_column    constant varchar2(255) := p_region.attribute_09;
    c_value_column        constant varchar2(255) := p_region.attribute_02;
    c_bottom_label_column constant varchar2(255) := p_region.attribute_01;
    c_percent_column      constant varchar2(255) := p_region.attribute_03;
    c_link_target         constant varchar2(255) := p_region.attribute_04;
    
    c_layout            constant varchar2(1)   := p_region.attribute_05;
    c_chart_size        constant varchar2(3)   := p_region.attribute_06;
    c_chart_type        constant varchar2(3)   := p_region.attribute_07;
    c_colored           constant varchar2(1)   := p_region.attribute_08;

    l_bottom_label_column_no pls_integer;
    l_top_label_column_no    pls_integer;
    l_value_column_no        pls_integer;
    l_percent_column_no      pls_integer;
    l_column_value_list      apex_plugin_util.t_column_value_list2;
    
    l_top_label      varchar2(4000);
    l_value             varchar2(4000);
    l_bottom_label      varchar2(4000);
    l_percent           number;
    l_url               varchar2(4000);
    l_class             varchar2(255);

begin
    apex_json.initialize_output (
        p_http_cache => false );
        -- Read the data based on the region source query
    l_column_value_list := apex_plugin_util.get_data2 (
                               p_sql_statement  => p_region.source,
                               p_min_columns    => 2,
                               p_max_columns    => null,
                               p_component_name => p_region.name );

    -- Get the actual column# for faster access and also verify that the data type
    -- of the column matches with what we are looking for
    l_top_label_column_no := apex_plugin_util.get_column_no (
      p_attribute_label   => 'Top Label',
      p_column_alias      => c_top_label_column,
      p_column_value_list => l_column_value_list,
      p_is_required       => false,
      p_data_type         => apex_plugin_util.c_data_type_varchar2
    );

    l_value_column_no   := apex_plugin_util.get_column_no (
                               p_attribute_label   => 'Value',
                               p_column_alias      => c_value_column,
                               p_column_value_list => l_column_value_list,
                               p_is_required       => true,
                               p_data_type         => apex_plugin_util.c_data_type_varchar2 );

    -- Get the actual column# for faster access and also verify that the data type
    -- of the column matches with what we are looking for
    l_bottom_label_column_no := apex_plugin_util.get_column_no (
      p_attribute_label   => 'Bottom Label',
      p_column_alias      => c_bottom_label_column,
      p_column_value_list => l_column_value_list,
      p_is_required       => false,
      p_data_type         => apex_plugin_util.c_data_type_varchar2
    );
                                      
    l_percent_column_no := apex_plugin_util.get_column_no (
                             p_attribute_label   => 'Percent',
                             p_column_alias      => c_percent_column,
                             p_column_value_list => l_column_value_list,
                             p_is_required       => false,
                             p_data_type         => apex_plugin_util.c_data_type_number );
    
    -- begin output as json
    owa_util.mime_header('application/json', false);
    htp.p('cache-control: no-cache');
    htp.p('pragma: no-cache');
    owa_util.http_header_close;
 --   l_message_when_no_data_found := apex_escape.html_whitelist(
  --      apex_plugin_util.replace_substitutions (
   --             p_value  => c_message_when_no_data_found,
   --             p_escape => false
    --        )
    --    );
    apex_json.open_object();
    apex_json.write('layout', c_layout); 
    apex_json.write('chart_size', c_chart_size); 
    apex_json.write('chart_type', c_chart_type); 
    apex_json.write('colored', c_colored); 
    apex_json.open_array('data');
    for l_row_num in 1 .. l_column_value_list(1).value_list.count loop
        begin
            apex_json.open_object(); 
            -- Set the column values of our current row so that apex_plugin_util.replace_substitutions
            -- can do substitutions for columns contained in the region source query.
            apex_plugin_util.set_component_values (
                p_column_value_list => l_column_value_list,
                p_row_num           => l_row_num );

            if l_top_label_column_no is not null
            then
              -- get the top label
              l_top_label := 
                 apex_plugin_util.get_value_as_varchar2 (
                     p_data_type => l_column_value_list(l_top_label_column_no).data_type,
                     p_value     => l_column_value_list(l_top_label_column_no).value_list(l_row_num) );

              apex_json.write('topLabel', l_top_label); 
            end if;
            
            -- get the value
            l_value := apex_plugin_util.get_value_as_varchar2 (
                               p_data_type => l_column_value_list(l_value_column_no).data_type,
                               p_value     => l_column_value_list(l_value_column_no).value_list(l_row_num) );

            apex_json.write('value', l_value); 

            if l_bottom_label_column_no is not null
            then
              -- get the bottom label
              l_bottom_label := 
                 apex_plugin_util.get_value_as_varchar2 (
                     p_data_type => l_column_value_list(l_bottom_label_column_no).data_type,
                     p_value     => l_column_value_list(l_bottom_label_column_no).value_list(l_row_num) );

              apex_json.write('bottomLabel', l_bottom_label); 
            end if;

            -- get percent
            if l_percent_column_no is not null then
                l_percent := l_column_value_list(l_percent_column_no).value_list(l_row_num).number_value;
                apex_json.    write('percent', l_percent); 
            end if;

            -- get the link target if it does exist
            if c_link_target is not null then
                l_url := apex_util.prepare_url (
                             apex_plugin_util.replace_substitutions (
                                 p_value  => c_link_target,
                                 p_escape => false ));
                apex_json.    write('url', l_url);                
            end if;
            
            apex_json.close_object();        


            apex_plugin_util.clear_component_values;
        exception when others then
            apex_plugin_util.clear_component_values;
            raise;
        end;
    end loop;
    apex_json.close_all();
    
    return null;
exception when others then
    htp.p('error: '||apex_escape.html(sqlerrm));
    return null;
end ajax;


