-- -----------------------------------------------------------------------------------
-- File Name    : https://oracle-base.com/dba/monitoring/sessions.sql
-- Author       : Tim Hall
-- Description  : Displays information on all database sessions.
-- Requirements : Access to the V$ views.
-- Call Syntax  : @sessions
-- Last Modified: 21-FEB-2005
-- -----------------------------------------------------------------------------------
SET LINESIZE 500
SET PAGESIZE 1000

COLUMN username FORMAT A15
COLUMN osuser FORMAT A15
COLUMN spid FORMAT A10
COLUMN service_name FORMAT A15
COLUMN module FORMAT A35
COLUMN machine FORMAT A25
COLUMN logon_time FORMAT A20

SELECT NVL(s.username, '(oracle)') AS username,
       s.osuser,
       s.sid,
       s.serial#,
       p.spid,
       s.lockwait,
       s.status,
       s.service_name,
       s.module,
       s.machine,
       s.program,
       TO_CHAR(s.logon_Time,'DD-MON-YYYY HH24:MI:SS') AS logon_time
FROM   v$session s,
       v$process p
WHERE  s.paddr = p.addr
ORDER BY s.username, s.osuser;

SET PAGESIZE 14
