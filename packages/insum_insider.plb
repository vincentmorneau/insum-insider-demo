create or replace package body insum_insider
is
  gc_scope_prefix constant varchar2(31) := lower($$PLSQL_UNIT) || '.';

end insum_insider;