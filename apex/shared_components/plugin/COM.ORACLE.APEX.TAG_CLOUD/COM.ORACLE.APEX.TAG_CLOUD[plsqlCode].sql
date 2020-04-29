function render (
    p_region              in apex_plugin.t_region,
    p_plugin              in apex_plugin.t_plugin,
    p_is_printer_friendly in boolean )
    return apex_plugin.t_region_render_result
is
    -- Constants for the columns of our region source query
    c_tag_col   constant pls_integer := 1;
    c_count_col constant pls_integer := 2;

    -- attributes of the plug-in
    l_target_url           varchar2(4000)  := p_region.attribute_01;
    l_max_display_tags     number          := p_region.attribute_02;
    l_show_count           boolean         := nvl(p_region.attribute_03,'Y') = 'Y';
    l_no_data_found     varchar2(32767) := p_region.no_data_found_message;

    l_valid_data_type_list wwv_flow_global.vc_arr2;
    l_column_value_list    apex_plugin_util.t_column_value_list2;
    l_printed_records    number := 0;
    l_available_records  number := 20;
    l_max                number;
    l_min                number;
    l_total              number := 0;
    l_cnts               number;
    l_tag                varchar2(4000);

    l_class_size         number;
    l_class              varchar2(30);

begin
    -- don't need to load css file, styles are contained within theme_42
    
    -- apex_css.add_file (
    --     p_name      => 'tag_cloud',
    --     p_directory => p_plugin.file_prefix,
    --     p_version   => null );


    -- define the valid column data types for the region query
    l_valid_data_type_list(c_tag_col)   := apex_plugin_util.c_data_type_varchar2;
    l_valid_data_type_list(c_count_col) := apex_plugin_util.c_data_type_number;

    -- get the data to be displayed
    l_column_value_list := apex_plugin_util.get_data2 (
                               p_sql_statement  => p_region.source,
                               p_min_columns    => 2,
                               p_max_columns    => 2,
                               p_data_type_list => l_valid_data_type_list,
                               p_component_name => p_region.name );

   l_available_records := l_column_value_list(c_tag_col).value_list.count;

   -----------------------------------------------
   -- Determine total count and maximum tag counts
   --
   l_max := 0;
   l_min := 1000;
   FOR i in 1.. l_column_value_list(c_count_col).value_list.count loop
      l_cnts := l_column_value_list(c_count_col).value_list(i).number_value;
      l_total := l_total + l_cnts;
      if l_cnts > l_max then
         l_max := l_cnts;
      end if;
      if l_cnts < l_min then
         l_min := l_cnts;
      end if;
   end loop;
   if l_max = 0 then l_max := 1; end if;


   l_class_size := round((l_max-l_min)/6);

   ------------------------
   -- Generate tag cloud --
   --
   
   sys.htp.prn('<ul class="a-TagCloud">');

   for i in 1.. l_column_value_list(c_tag_col).value_list.count loop
       l_printed_records := l_printed_records + 1;
       l_tag := apex_escape.html(l_column_value_list(c_tag_col).value_list(i).varchar2_value);
       l_cnts := l_column_value_list(c_count_col).value_list(i).number_value;
       if l_cnts < l_min + l_class_size then
          l_class := 'size1';
       elsif l_cnts < l_min + (l_class_size*2) then
          l_class := 'size2';
       elsif l_cnts < l_min + (l_class_size*3) then
          l_class := 'size3';
       elsif l_cnts < l_min + (l_class_size*4) then
          l_class := 'size4';
       elsif l_cnts < l_min + (l_class_size*5) then
          l_class := 'size5';
       else l_class := 'size6';
       end if;      
       
        sys.htp.prn('<li class="a-TagCloud-item">'
            ||apex_plugin_util.get_link(
                p_url  => replace(l_target_url,'#TAG#',l_tag),
                p_text => l_tag
                            ||case when l_show_count then
                                ' <span class="a-TagCloud-count">'||l_cnts||'</span>'
                            end,
                p_escape_text => false,
                p_attributes => 'class="a-TagCloud-link a-TagCloud-link--' ||l_class||'"')
            ||'</li>');

       if  l_printed_records > l_max_display_tags then
           exit;
       end if;
   end loop;

   sys.htp.prn('</ul>');
   if l_printed_records = 0 then
       sys.htp.p('<span class="nodatafound">'||l_no_data_found||'</span>');
   end if;

   return null;
end render;