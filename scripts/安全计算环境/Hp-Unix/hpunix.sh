#!/sbin/sh


# -----------------------------------------------------------
# Filename:			hpunix.sh
# Describe: 		Security check for release hp-unix  
# Usage:			chmod 777 hpunix.sh
#					./hpunix.sh &> filename.sh
# v1.0    2018.7
# -----------------------------------------------------------


echo "# ---------------------------------------------------------------------"
echo -e "# Describe: \t\t This file to check system security configuration" 
echo -e "# Running time:\t\t "`date +'%Y-%m-%d %H:%S'`
echo "# Project name:"
echo "# Server name:"
echo "# ---------------------------------------------------------------------"
echo 



# ************************************ ��ݼ��� ************************************
echo
echo
echo
echo "------------ Identity authentication ----------------------------------------------"
echo
# �Ƿ��пտ��� 
echo "********* [checking Empty password users:]"
echo "********* [Cat files: /etc/passwd:]"
more /etc/passwd
echo
echo
echo "********* [Cat files: /etc/shadow:]"
more /etc/shadow
echo
echo
echo "********* [Cat files: /etc/group:]"
more /etc/group
# ������� �͵�¼ʧ�ܲ��� ������ /etc/default/security
echo
echo
echo "********* [Password policy : more /etc/default/security]"
more /etc/default/security


# ���ssh �� telnet
echo
echo
echo "********* [ssh and telnet server status:]"
ps -elf| grep ssh
ps -elf| grep telnet
ps -elf| grep ftp




# ************************************ ���ʿ��� ************************************
echo "------------ Access control ----------------------------------------------"
echo
echo
# ����Ȩ�ޣ�600�ϸ�
echo "********* [Checking some files access permission:]"
ls -l /etc/passwd
ls -l /etc/shadow
ls -l /etc/syslog.conf




# ************************************ ��ȫ��� ************************************
echo "------------ Secure and Audit ----------------------------------------------"
echo
echo
# �鿴�Ƿ���ϵͳ��־ ��� ����
echo "********* [Syslog and audit status:]"
ps -ef | grep syslog
ps -ef | grep audit
echo
echo
# ��־������Ϣ
echo "********* [To see syslog config more /etc/syslog.conf:]"
more /etc/syslog.conf
echo
echo


# ************************************ ���ַ��� ************************************
echo "------------ Intrusion prevention ----------------------------------------------"
echo
echo
# �鿴ϵͳ��װ�Ĳ�������Ϣ��
echo "********* [Patch information of the system��swlist -l bundle]"
swlist -l bundle

echo
echo
echo "********* [more /etc/inetd.conf��]"
more /etc/inetd.conf


# ����������еķ����Ƿ��������޹صĽ���
echo
echo
echo "********* [Select all service:]"
ps -ef


# ************************************ ��Դ���� ************************************
echo "------------ Resource control ----------------------------------------------"
echo
echo
# �鿴���÷��ʵ�ַ�����Ʋ���
echo "********* [IP address permit in hosts.allow and hosts.deny ��]"
echo "[more /etc/securetty:]"
more /etc/securetty
echo
echo

echo "[more /etc/adm/inetd.sec :]"
more /etc/adm/inetd.sec
echo
echo

echo "[more /etc/hosts.allow:]"
more /etc/hosts.allow
echo
echo

echo "[more /etc/hosts.deny :]"
more /etc/hosts.deny 
echo
echo

# �˻���¼�Ƿ�ʱ��������  =600s
echo "********* [Login timeout lock, ('TMOUT >= 600s')]"
more /etc/profile | grep -n "TMOUT"



# ϵͳ������ʹ��ϵͳ��Դ����������
echo
echo
echo "********* [Describes system resource limit for a user:ulimit -a]"
echo
ulimit -a



# ����ʹ�����
echo "[disk info:]"
df -h


# �ڴ�ʹ�����
echo "[Memory info:]"
free -m
echo
echo



