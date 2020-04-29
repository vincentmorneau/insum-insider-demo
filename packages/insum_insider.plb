create or replace package body insum_insider
is
  gc_scope_prefix constant varchar2(31) := lower($$PLSQL_UNIT) || '.';
  
  /**
   * Procedure
   *
   *
   * @example 

   * @issue
   *
   * @author Neil Fernandez (Insum Solutions)
   * @created 29-Apr-2020
   * @param p_param1
   */
  procedure insider(
    p_param1 in varchar2)
  as
    l_scope logger_logs.scope%type := gc_scope_prefix || 'insider';
    l_params logger.tab_param;

  begin
    logger.append_param(l_params, 'p_param1', p_param1);
    logger.log('START', l_scope, null, l_params);

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end insider;

end insum_insider;