
---------------------------  Oracle 11g����ͨ�� -----------------

-- ����Oralce���ݿ���Ʋ��裬�����ֻ�����ͨ�û��������DBA�˻�

-- 0.�鿴�Ƿ�����ƣ�ʹ��DBA�û���¼sqlplus
show parameter audit;

	-- �������ͣ�
		-- audit_sys_operations  ��valueΪfalse����ζ�����ݿ����δ����
		

		
-- 2.���ÿ������ݿ����	
SQL> alter system set audit_sys_operations=true scope=spfile;
SQL> alter system set audit_trail=db_extended scope=spfile;
	-- �������ͣ�
		-- audit_trail ��������Ϊ OS \ DB �� spfileδ��ʼ���ļ�����
		-- DB����audit trail ��¼�����ݿ�������ر��У���aud$����ƵĽ��ֻ��������Ϣ��
        -- Extended��������ƽ���������������Ϣ�������˵�ʱִ�еľ���SQL��䣻
		-- OS����audit trail ��¼�ڲ���ϵͳ�ļ��У��ļ����� audit_file_dest ����ָ����
		-- None��������ƣ�
	
-- 3.�������ݿ⣺
SQL> startup force;
	-- ��ע�� 
		-- SQL> shutdown  immediate ;        			 �ر����ݿ�
		-- SQL>	startup��                                �������ݿ�
		
-- 4.��֤�Ƿ�ɹ��������ظ� step0


-- 5.�����������:
SQL>	audit all on admin.selectiveinfo;			-- ��admin.selectiveinfo�������
SQL>	noaudit select any table by luosongchao;	-- ȡ��luosongchao�˻������б��select�������
	
	
	
-- 6.�鿴��Ƽ�¼��ʹ��DBA�˻���¼�󣬲鿴ĳһ�û��Ĳ�����¼
SQL> select username, extended_timestamp, sql_text from dba_audit_trail where user name=upper<'lishichang');
	-- �������ͣ�
		-- dba_audit_trail ���¼���з�DBA�˻��Ĳ�����¼
		
-----------------------------------------------------------------

-- ���ó�ʱ��������	IDLE_TIME 
		
-- 1.�鿴DEFAULT profile���ã�
SQL> select resource_name, limit from dba_profiles where profile='DEFAULT' and resource_type='KERNEL';
-- 2.�޸� alter profile ��ǰʹ�õ�profile�� �ֶ���limit ֵ
SQL> alter profile default limit idle_time 5;




