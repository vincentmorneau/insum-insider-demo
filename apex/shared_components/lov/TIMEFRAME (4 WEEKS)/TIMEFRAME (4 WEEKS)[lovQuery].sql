select disp,
      val as seconds
 from table( apex_util.get_timeframe_lov_data )
order by insert_order