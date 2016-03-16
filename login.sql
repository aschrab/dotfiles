set termout off
-- SET SQLPROMPT "_USER'@'_CONNECT_IDENTIFIER >"
COLUMN global_name new_value gname
SELECT LOWER(USER) || '@' || global_name||CHR(10)||'SQL> ' AS global_name
FROM   global_name;
SET SQLPROMPT '&gname'

alter session set nls_date_format         = 'YYYY-MM-DD HH24:MI:SS';
alter session set nls_timestamp_format    = 'YYYY-MM-DD HH24:MI:SS.FF';
alter session set nls_timestamp_tz_format = 'YYYY-MON-DD HH24:MI:SS.FF TZH:TZM';

set termout on

Set NULL "(nuLl)"
