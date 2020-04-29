FUNCTION RENDER (
    P_REGION IN APEX_PLUGIN.T_REGION,
    P_PLUGIN IN APEX_PLUGIN.T_PLUGIN,
    P_IS_PRINTER_FRIENDLY IN BOOLEAN
) RETURN APEX_PLUGIN.T_REGION_RENDER_RESULT IS
BEGIN
    HTP.PRN('<div id="'||APEX_ESCAPE.HTML_ATTRIBUTE(P_REGION.STATIC_ID)||'_chart" class="hbc">');
    HTP.PRN('</div>');
    
    APEX_JAVASCRIPT.ADD_ONLOAD_CODE (
        P_CODE => 'com_oracle_apex_html5_bar_chart('||
            APEX_JAVASCRIPT.ADD_VALUE(P_REGION.STATIC_ID)||
            '{'||
                -- Why is this attribute needed if is not used?
                APEX_JAVASCRIPT.ADD_ATTRIBUTE(
                    'pageItems', 
                    APEX_PLUGIN_UTIL.PAGE_ITEM_NAMES_TO_JQUERY(P_REGION.AJAX_ITEMS_TO_SUBMIT)
                )||
                APEX_JAVASCRIPT.ADD_ATTRIBUTE(
                    'ajaxIdentifier', 
                    APEX_PLUGIN.GET_AJAX_IDENTIFIER, 
                    FALSE, 
                    FALSE
                )||
            '}'||
        ');'
    );
    
    RETURN NULL;
END RENDER;

FUNCTION AJAX (
    P_REGION IN APEX_PLUGIN.T_REGION,
    P_PLUGIN IN APEX_PLUGIN.T_PLUGIN
) RETURN APEX_PLUGIN.T_REGION_AJAX_RESULT IS
    -- Map region attributes to function constants
    -- MODERN, CLASSIC
    C_CHART_TYPE CONSTANT VARCHAR2(7) := P_REGION.ATTRIBUTE_15;
    -- MODERN, MODERN_2, SOLAR, METRO, CUSTOM, COLUMN
    C_COLOR_SCHEME CONSTANT VARCHAR2(8) := P_REGION.ATTRIBUTE_17;
    C_CUSTOM_CHART_COLORS CONSTANT VARCHAR2(4000) := P_REGION.ATTRIBUTE_10;
    C_COLOR_COLUMN CONSTANT VARCHAR2(255) := P_REGION.ATTRIBUTE_19;
    -- NONE, IMAGE, ICON, INITIALS
    C_ICON_TYPE CONSTANT VARCHAR2(8) := case when C_CHART_TYPE = 'ICON' then P_REGION.ATTRIBUTE_01 end;
    C_LABEL_COLUMN CONSTANT VARCHAR2(255) := P_REGION.ATTRIBUTE_02;
    C_LABEL_LINK CONSTANT VARCHAR2(255) := P_REGION.ATTRIBUTE_03;
    C_VALUE_COLUMN CONSTANT VARCHAR2(255) := P_REGION.ATTRIBUTE_04;
    C_VALUE_LINK CONSTANT VARCHAR2(255) := P_REGION.ATTRIBUTE_05;
    C_VALUE_FORMAT_MASK CONSTANT VARCHAR2(4000) := P_REGION.ATTRIBUTE_21;

    -- ABOVE, AROUND
    C_TEXT_POSITION VARCHAR2(6) := P_REGION.ATTRIBUTE_18;
    C_CHART_CSS_CLASSES CONSTANT VARCHAR2(32767) := P_REGION.ATTRIBUTE_06;
    C_IMAGE_URL CONSTANT VARCHAR2(4000) := P_REGION.ATTRIBUTE_07;
    C_CSS_ICON_CLASS_NAME CONSTANT VARCHAR2(255) := P_REGION.ATTRIBUTE_08;
    C_INITIALS_COLUMN CONSTANT VARCHAR2(255) := P_REGION.ATTRIBUTE_09;
    -- ABSOLUTE, RELATIVE
    C_BAR_WIDTH_CALCULATION CONSTANT VARCHAR2(8) := P_REGION.ATTRIBUTE_16;
    C_DISPLAY CONSTANT VARCHAR2(19) := P_REGION.ATTRIBUTE_11;
    C_PREFIX_FOR_VALUE CONSTANT VARCHAR2(4000) := P_REGION.ATTRIBUTE_12;
    C_POSTFIX_FOR_VALUE CONSTANT VARCHAR2(4000) := P_REGION.ATTRIBUTE_13;
    C_MAXIMUM_ROWS CONSTANT NUMBER := P_REGION.ATTRIBUTE_14;
    C_MESSAGE_WHEN_NO_DATA_FOUND CONSTANT VARCHAR2(4000) := P_REGION.ATTRIBUTE_20;
    
    L_COLOR_COLUMN_NUMBER PLS_INTEGER;
    L_LABEL_COLUMN_NUMBER PLS_INTEGER;
    L_VALUE_COLUMN_NUMBER PLS_INTEGER;
    L_INITIALS_COLUMN_NUMBER PLS_INTEGER;
    
    L_COLUMN_VALUE_LIST APEX_PLUGIN_UTIL.T_COLUMN_VALUE_LIST2;
    
    L_COLOR VARCHAR2(4000) := NULL;
    L_LABEL VARCHAR2(4000) := NULL;
    L_LABEL_LINK VARCHAR2(4000) := NULL;
    L_VALUE VARCHAR2(4000) := NULL;
    L_DISPLAY_VALUE VARCHAR2(4000) := NULL;
    L_VALUE_LINK VARCHAR2(4000) := NULL;
    L_IMAGE_URL VARCHAR2(4000) := NULL;
    L_CSS_ICON_CLASS_NAME VARCHAR2(4000) := NULL;
    L_INITIALS VARCHAR2(4000) := NULL;
    L_MESSAGE_WHEN_NO_DATA_FOUND VARCHAR2(4000) := NULL;

    L_CUSTOM_CHART_COLORS_TABLE APEX_APPLICATION_GLOBAL.VC_ARR2;
    L_CUSTOM_CHART_COLORS VARCHAR2(32767) := NULL;
BEGIN
    L_COLUMN_VALUE_LIST := APEX_PLUGIN_UTIL.GET_DATA2(
        P_SQL_STATEMENT  => P_REGION.SOURCE,
        P_MIN_COLUMNS    => 1,
        P_MAX_COLUMNS    => NULL,
        P_COMPONENT_NAME => P_REGION.NAME,
        P_MAX_ROWS => C_MAXIMUM_ROWS
    );

    L_COLOR_COLUMN_NUMBER := APEX_PLUGIN_UTIL.GET_COLUMN_NO (
        P_ATTRIBUTE_LABEL   => 'Color Column',
        P_COLUMN_ALIAS      => C_COLOR_COLUMN,
        P_COLUMN_VALUE_LIST => L_COLUMN_VALUE_LIST,
        P_IS_REQUIRED       => C_COLOR_SCHEME = 'COLUMN',
        P_DATA_TYPE         => APEX_PLUGIN_UTIL.C_DATA_TYPE_VARCHAR2
    );
    L_LABEL_COLUMN_NUMBER := APEX_PLUGIN_UTIL.GET_COLUMN_NO (
        P_ATTRIBUTE_LABEL   => 'Label Column',
        P_COLUMN_ALIAS      => C_LABEL_COLUMN,
        P_COLUMN_VALUE_LIST => L_COLUMN_VALUE_LIST,
        P_IS_REQUIRED       => TRUE,
        P_DATA_TYPE         => APEX_PLUGIN_UTIL.C_DATA_TYPE_VARCHAR2
    );
    L_VALUE_COLUMN_NUMBER := APEX_PLUGIN_UTIL.GET_COLUMN_NO (
        P_ATTRIBUTE_LABEL   => 'Value Column',
        P_COLUMN_ALIAS      => C_VALUE_COLUMN,
        P_COLUMN_VALUE_LIST => L_COLUMN_VALUE_LIST,
        P_IS_REQUIRED       => TRUE,
        P_DATA_TYPE         => APEX_PLUGIN_UTIL.C_DATA_TYPE_VARCHAR2
    );
    if C_ICON_TYPE = 'INITIALS' then
        L_INITIALS_COLUMN_NUMBER := APEX_PLUGIN_UTIL.GET_COLUMN_NO (
            P_ATTRIBUTE_LABEL   => 'Initials Column',
            P_COLUMN_ALIAS      => C_INITIALS_COLUMN,
            P_COLUMN_VALUE_LIST => L_COLUMN_VALUE_LIST,
            P_IS_REQUIRED       => true,
            P_DATA_TYPE         => APEX_PLUGIN_UTIL.C_DATA_TYPE_VARCHAR2
        );
    end if;
    -- Begin output as JSON
    OWA_UTIL.MIME_HEADER('application/json', FALSE);
    HTP.P('Cache-Control: no-cache');
    HTP.P('Pragma: no-cache');
    OWA_UTIL.HTTP_HEADER_CLOSE;
    
    IF C_COLOR_SCHEME = 'CUSTOM' THEN
        L_CUSTOM_CHART_COLORS_TABLE := APEX_UTIL.STRING_TO_TABLE(CASE WHEN C_CUSTOM_CHART_COLORS IS NOT NULL THEN TRIM(BOTH '''' FROM APEX_ESCAPE.JS_LITERAL(C_CUSTOM_CHART_COLORS)) END, ':');
        L_CUSTOM_CHART_COLORS := '"color_scheme":[';
        FOR I IN L_CUSTOM_CHART_COLORS_TABLE.FIRST .. L_CUSTOM_CHART_COLORS_TABLE.LAST LOOP
            IF I > 1 THEN
                L_CUSTOM_CHART_COLORS := L_CUSTOM_CHART_COLORS||',';
            END IF;
            L_CUSTOM_CHART_COLORS := L_CUSTOM_CHART_COLORS||'"'||L_CUSTOM_CHART_COLORS_TABLE(I)||'"';
        END LOOP;
        L_CUSTOM_CHART_COLORS := L_CUSTOM_CHART_COLORS||'],';
    END IF;

    L_MESSAGE_WHEN_NO_DATA_FOUND := APEX_ESCAPE.HTML_WHITELIST(
        APEX_PLUGIN_UTIL.REPLACE_SUBSTITUTIONS (
                P_VALUE  => C_MESSAGE_WHEN_NO_DATA_FOUND,
                P_ESCAPE => FALSE
            )
        );

    HTP.PRN(
        '{'||
            APEX_JAVASCRIPT.ADD_ATTRIBUTE (
                'chart_type',
                C_CHART_TYPE,
                FALSE,
                TRUE
            )
    );
    HTP.PRN(
        APEX_JAVASCRIPT.ADD_ATTRIBUTE (
            'message_when_no_data_found',
            L_MESSAGE_WHEN_NO_DATA_FOUND,
            TRUE,
            TRUE
        )
    );
    HTP.PRN(
        APEX_JAVASCRIPT.ADD_ATTRIBUTE (
            'chart_css_class_names',
            C_CHART_CSS_CLASSES,
            TRUE,
            TRUE
        )
    );
    HTP.PRN(
        APEX_JAVASCRIPT.ADD_ATTRIBUTE (
            'icon_type',
            C_ICON_TYPE,
            TRUE,
            TRUE
        )
    );
    IF C_COLOR_SCHEME = 'CUSTOM' THEN
        HTP.PRN(
            L_CUSTOM_CHART_COLORS
        );
    ELSE
        HTP.PRN(
            APEX_JAVASCRIPT.ADD_ATTRIBUTE (
                'color_scheme',
                C_COLOR_SCHEME,
                TRUE,
                TRUE
            )
        );
    END IF;
    HTP.PRN(
            APEX_JAVASCRIPT.ADD_ATTRIBUTE (
                'text_position',
                C_TEXT_POSITION,
                FALSE,
                TRUE
            )||
            APEX_JAVASCRIPT.ADD_ATTRIBUTE (
                'bar_width_calculation',
                C_BAR_WIDTH_CALCULATION,
                FALSE,
                TRUE
            )||
            APEX_JAVASCRIPT.ADD_ATTRIBUTE (
                'display',
                C_DISPLAY,
                FALSE,
                TRUE
            )||
            CASE 
              WHEN C_DISPLAY IN ('VALUE') THEN
          APEX_JAVASCRIPT.ADD_ATTRIBUTE (
            'prefix_for_value',
            C_PREFIX_FOR_VALUE,
            TRUE,
            TRUE
          )||
          APEX_JAVASCRIPT.ADD_ATTRIBUTE (
            'postfix_for_value',
            C_POSTFIX_FOR_VALUE,
            TRUE,
            TRUE
          )
      END||
            '"items":['
    );
    
    --FOR L_ROW_NUMBER IN L_COLUMN_VALUE_LIST(1).VALUE_LIST.FIRST .. L_COLUMN_VALUE_LIST(1).VALUE_LIST.LAST LOOP
    FOR L_ROW_NUMBER IN 1 .. L_COLUMN_VALUE_LIST(1).VALUE_LIST.COUNT LOOP
        BEGIN
            APEX_PLUGIN_UTIL.SET_COMPONENT_VALUES (
                P_COLUMN_VALUE_LIST => L_COLUMN_VALUE_LIST,
                P_ROW_NUM => L_ROW_NUMBER 
            );
            
            IF L_ROW_NUMBER > 1 THEN
              HTP.PRN(', ');
            END IF;
            
            HTP.PRN('{');
            
            L_LABEL := APEX_PLUGIN_UTIL.ESCAPE (
                APEX_PLUGIN_UTIL.GET_VALUE_AS_VARCHAR2 (
                    P_DATA_TYPE => L_COLUMN_VALUE_LIST(L_LABEL_COLUMN_NUMBER).DATA_TYPE,
                    P_VALUE => L_COLUMN_VALUE_LIST(L_LABEL_COLUMN_NUMBER).VALUE_LIST(L_ROW_NUMBER)
                ),
                P_REGION.ESCAPE_OUTPUT
            );
            HTP.PRN(
              APEX_JAVASCRIPT.ADD_ATTRIBUTE (
                    'label',
                    L_LABEL,
                    FALSE
              )
            );
            L_LABEL_LINK := 
                CASE 
                    WHEN C_LABEL_LINK IS NOT NULL THEN 
                        APEX_UTIL.PREPARE_URL (
                            APEX_PLUGIN_UTIL.REPLACE_SUBSTITUTIONS (
                                P_VALUE  => C_LABEL_LINK,
                                P_ESCAPE => FALSE
                            )
                        )
                END;
            HTP.PRN(
              APEX_JAVASCRIPT.ADD_ATTRIBUTE (
                    'label_link',
                    L_LABEL_LINK
                )
            );
            
            L_VALUE := APEX_PLUGIN_UTIL.ESCAPE (
               APEX_PLUGIN_UTIL.GET_VALUE_AS_VARCHAR2 (
                   P_DATA_TYPE => L_COLUMN_VALUE_LIST(L_VALUE_COLUMN_NUMBER).DATA_TYPE,
                   P_VALUE => L_COLUMN_VALUE_LIST(L_VALUE_COLUMN_NUMBER).VALUE_LIST(L_ROW_NUMBER)
               ),
               P_REGION.ESCAPE_OUTPUT
            );
            --
            L_DISPLAY_VALUE :=
                CASE 
                    WHEN C_VALUE_FORMAT_MASK IS NOT NULL THEN
                      to_char(to_number(L_VALUE),C_VALUE_FORMAT_MASK)
                    ELSE
                      L_VALUE
                END;

            HTP.PRN(
              APEX_JAVASCRIPT.ADD_ATTRIBUTE (
                    'display_value',
                    L_DISPLAY_VALUE,
                    FALSE,
                    TRUE
                )
            );
            --
            HTP.PRN(
              APEX_JAVASCRIPT.ADD_ATTRIBUTE (
                    'value',
                    L_VALUE,
                    FALSE,
                    C_VALUE_LINK IS NOT NULL OR L_COLOR_COLUMN_NUMBER IS NOT NULL OR C_CHART_TYPE = 'ICON'
                )
            );

            L_VALUE_LINK := 
                CASE 
                    WHEN C_VALUE_LINK IS NOT NULL THEN 
                        APEX_UTIL.PREPARE_URL (
                            APEX_PLUGIN_UTIL.REPLACE_SUBSTITUTIONS (
                                P_VALUE  => C_VALUE_LINK,
                                P_ESCAPE => FALSE
                            )
                        )
                END;
             HTP.PRN(
              APEX_JAVASCRIPT.ADD_ATTRIBUTE (
                    'value_link',
                    L_VALUE_LINK,
                    TRUE,
                    L_COLOR_COLUMN_NUMBER IS NOT NULL OR C_CHART_TYPE = 'ICON'
                )
            );
            IF L_COLOR_COLUMN_NUMBER IS NOT NULL THEN
                L_COLOR := APEX_PLUGIN_UTIL.ESCAPE (
                   APEX_PLUGIN_UTIL.GET_VALUE_AS_VARCHAR2 (
                       P_DATA_TYPE => L_COLUMN_VALUE_LIST(L_COLOR_COLUMN_NUMBER).DATA_TYPE,
                       P_VALUE => L_COLUMN_VALUE_LIST(L_COLOR_COLUMN_NUMBER).VALUE_LIST(L_ROW_NUMBER)
                   ),
                   P_REGION.ESCAPE_OUTPUT
                );
                HTP.PRN(
                    APEX_JAVASCRIPT.ADD_ATTRIBUTE (
                        'color',
                        L_COLOR,
                        FALSE,
                        C_CHART_TYPE = 'ICON'
                    )
                );
            END IF;
            IF C_ICON_TYPE = 'IMAGE' THEN
        L_IMAGE_URL := 
                    CASE 
                        WHEN C_IMAGE_URL IS NOT NULL THEN 
                            APEX_UTIL.PREPARE_URL (
                                APEX_PLUGIN_UTIL.REPLACE_SUBSTITUTIONS (
                                    P_VALUE  => C_IMAGE_URL,
                                    P_ESCAPE => FALSE
                                )
                            )
                    END;
        HTP.PRN(
          APEX_JAVASCRIPT.ADD_ATTRIBUTE (
            'image_url',
            L_IMAGE_URL,
            FALSE,
            FALSE
          )
        );
      ELSIF C_ICON_TYPE = 'ICON' THEN
        L_CSS_ICON_CLASS_NAME := APEX_PLUGIN_UTIL.REPLACE_SUBSTITUTIONS (
                    P_VALUE  => C_CSS_ICON_CLASS_NAME,
                    P_ESCAPE => TRUE
                );
        HTP.PRN(
                  APEX_JAVASCRIPT.ADD_ATTRIBUTE (
            'icon_css_class_name',
            L_CSS_ICON_CLASS_NAME,
            FALSE,
            FALSE
          )
        );
      ELSIF C_ICON_TYPE = 'INITIALS' THEN
        L_INITIALS := APEX_PLUGIN_UTIL.ESCAPE (
          APEX_PLUGIN_UTIL.GET_VALUE_AS_VARCHAR2 (
            P_DATA_TYPE => L_COLUMN_VALUE_LIST(L_INITIALS_COLUMN_NUMBER).DATA_TYPE,
            P_VALUE => L_COLUMN_VALUE_LIST(L_INITIALS_COLUMN_NUMBER).VALUE_LIST(L_ROW_NUMBER)
          ),
          P_REGION.ESCAPE_OUTPUT
        );
        HTP.PRN(
                  APEX_JAVASCRIPT.ADD_ATTRIBUTE (
                      'initials',
                      L_INITIALS,
                      FALSE,
                      FALSE
                  )
              );
            END IF;
            
      HTP.PRN('}');
            
            APEX_PLUGIN_UTIL.CLEAR_COMPONENT_VALUES;
        EXCEPTION
            WHEN OTHERS THEN
                APEX_PLUGIN_UTIL.CLEAR_COMPONENT_VALUES;
                RAISE;
        END;
    END LOOP;
    HTP.PRN(
            ']'||
        '}'
    );
    
    RETURN NULL;
END AJAX;