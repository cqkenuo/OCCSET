-------------------------------------------------------------------
-- Filename: 		 oracle_10g.sql
-- Describe��	 Oracle 10g sql for check
-- Usage:
-- 	Windows��
--			cmd
--			sqlplus / as sysdba
--				SQL>		spool C:\retsql.sql			
--  			SQL>    	@ C:\oracle_10g.sql 
--				SQL>		spool off					
--
--	Linux:
--			sqlplus / as sysdba
--				SQL> 		spool ./retsql.sql
--				SQL> 		@ /opt/oracle/oracle_10g.sql 
--				SQL>		spool off
--
--
--	Oracle10g ���ܳ������� sqlplus / as sysdba �޷���½�����������ʹ�����·�ʽ��
--			sqlplus /nolog				-- ����sqlplus�������ӻỰ
--			conn / as sysdba			-- dba��½
--
--
--
-- v1.0    2018.5

-- ��ע��
-- ���� Windows���� C:\oracle\product\12.1.0\dbhome_1\NETWORK\ADMIN\sqlnet.ora �鿴����
--      Linux�²���·��   find / -name "sqlnet.ora" 
--
-- 
-- 		�鿴 sqlnet.ora �Ƿ����������²�����
-- 
-- 		tcp.validnode_checking = yes     -- �������ƻ����������ݿ⹦��
-- 		tcp.invited_nodes			     -- ������ʵ�ip��ַ
-- 		tcp.excluded_nodes=(ip1,ip2,����)  -- ��������ʵ�ip
-- 		�޸�sqlnet.ora����������listener������Ч		
-------------------------------------------------------------------------------+



-- Set format for out
set linesize 150
set pagesize 80
col username format a20
col account_status format a20
col password format a20
col CREATED format a20
col USER_ID, format a10
col profile format a20
col resource_name format a35
col limit format a10
col TYPE format a15
col VALUE format a20
col grantee format a25
col owner format a10
col table_name format a10
col grantor format a10
col privilege format a10
col AUDIT_OPTION format a30
col SUCCESS format a20
col FAILURE format a20



PROMPT --@@ Oracle version info
select to_char(sysdate,'YYYY-MM-DD hh24:mi:ss') from dual;
PROMPT

PROMPT --@@ all database instances:
select name from v$database;

PROMPT ------------ Identity authentication ----------------------------------------------


PROMPT --@@ 1.Checking user state: 

select username, CREATED, USER_ID, password, profile from dba_users where ACCOUNT_STATUS='OPEN'; 
PROMPT

PROMPT --@@ 2 3.Checking password and attempt login failed strategy:

select username, account_status, profile from dba_users;
PROMPT
select profile, resource_name, limit from dba_profiles where resource_type='PASSWORD';
PROMPT
PROMPT



PROMPT ------------ Access control ----------------------------------------------

PROMPT --@@ All privileged users:
select grantee from dba_role_privs where granted_role='DBA';
PROMPT --@@ 10.Default users grantee roles about grantee='PUBLIC':
select granted_role from dba_role_privs where grantee='PUBLIC';
PROMPT --@@ Checking access of data dictionary must boolean=FALSE!  :
show parameter O7_DICTIONARY_ACCESSIBILITY; 
PROMPT
PROMPT

PROMPT ------------ Syslog and audit ----------------------------------------------


PROMPT --@@ 14.Syslog and Auditstate:
select value from v$parameter where name='audit_sys_operation'; 
select value from v$parameter where name='audit_trail';
PROMPT

PROMPT --@@ 15.Important security events covered by audit:
select AUDIT_OPTION, SUCCESS, FAILURE from dba_stmt_audit_opts;
PROMPT
PROMPT --@@ 19.Protecting audit records:
select grantee, owner, table_name, grantor, privilege from dba_tab_privs where table_name='AUD$';
PROMPT
PROMPT

PROMPT ------------ Resources control ----------------------------------------------


PROMPT --@@ 26.Checking 'IDLE_TIME':
select resource_name, limit from dba_profiles where profile='DEFAULT' and resource_type='KERNEL' and resource_name='IDLE_TIME';

PROMPT --@@ 27.Checking single user resource limit:
select resource_name, limit from dba_profiles where profile='DEFAULT' and resource_type='SESSIONS_PER_USERS';

PROMPT --@@ 28.Checking cpu time limit for a single session:
select resource_name, limit from dba_profiles where profile='DEFAULT' and resource_type='CPU_PER_SESSION';



PROMPT -- Special requirements of other industries ----------------------------------------------

PROMPT -- Has the "Oracle Label Security" been installed? I will determine by looking at whether the "LBACSYS" user has been created or about its database tables.

PROMPT --@@ Whether have username='LBACSYS'
select username, account_status, profile from dba_users where username='LBACSYS';
PROMPT --@@ Something about OWNER='LBACSYS'
select object_type,count(*) from dba_objects where OWNER='LBACSYS' group by object_type;



