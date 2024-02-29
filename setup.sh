sudo yum -y install git.x86_64 oracle-instantclient-release-el8.x86_64 
sudo yum -y install oracle-instantclient-basic.x86_64 oracle-instantclient-sqlplus.x86_64
cd

echo "export LD_LIBRARY_PATH=/usr/lib/oracle/21/client64/lib
export PATH=$PATH:/usr/lib/oracle/21/client64/bin">>~/.bashrc

. ~/.bashrc

git clone https://github.com/yusukeyurameshi/Labs.git

cd Labs

echo "DBHost= 146.235.49.161"
echo "dbauser= system"
echo "Password= WElcome##123"
echo "ServiceName= dbteste_pdb1.public.vcngru.oraclevcn.com"

export DBHost=146.235.49.161
export ServiceName=dbteste_pdb1.public.vcngru.oraclevcn.com

sed -i 's/dbhost/'${DBHost}'/g' tnsnames.ora
sed -i 's/dbservicename/'${ServiceName}'/g' tnsnames.ora

echo "export TNS_ADMIN="`pwd`>>~/.bashrc
. ~/.bashrc

exit
echo -n "DB Host: "
read -r DBHost

echo -n "DBA User: "
read -r dbauser

echo -n "Password: "
read -r Password

echo -n "Service Name: "
read -r ServiceName

#DBHost=146.235.49.161
#dbauser=system
#Password=WElcome##123
#ServiceName=dbteste_pdb1.public.vcngru.oraclevcn.com

echo "[DEFAULT]
DBHost = ${DBHost}
dbauser = ${dbauser}
Password = ${Password}
ServiceName = ${ServiceName}">.config

#echo "sqlplus -s ${dbauser}/${Password}@${DBHost}:1521/${ServiceName} @cleanup.sql"
#echo "sqlplus -s ${dbauser}/${Password}@${DBHost}:1521/${ServiceName} @install.sql"

sqlplus -s ${dbauser}/${Password}@${DBHost}:1521/${ServiceName} @cleanup.sql
sqlplus -s ${dbauser}/${Password}@${DBHost}:1521/${ServiceName} @install.sql
sqlplus -s aq_admin/WElcome##123@${DBHost}:1521/${ServiceName} @aq_admin.sql
sqlplus -s ${dbauser}/${Password}@${DBHost}:1521/${ServiceName} @01.sql
sqlplus -s aq_admin/WElcome##123@${DBHost}:1521/${ServiceName} @02.sql
sqlplus -s aq_admin/WElcome##123@${DBHost}:1521/${ServiceName} @03.sql
sqlplus -s ${dbauser}/${Password}@${DBHost}:1521/${ServiceName} @04.sql


