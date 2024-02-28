sudo yum -y install git.x86_64 oracle-instantclient-release-el8.x86_64 
sudo yum -y install oracle-instantclient-basic.x86_64 oracle-instantclient-sqlplus.x86_64
cd

echo "export LD_LIBRARY_PATH=/usr/lib/oracle/21/client64/lib
export PATH=$PATH:/usr/lib/oracle/21/client64/bin">>~/.bashrc

. ~/.bashrc

git clone https://github.com/yusukeyurameshi/Labs.git

cd Labs

echo -n "DB Host: "
read -r DBHost

echo -n "DBA User: "
read -r dbauser

echo -n "Password: "
read -r Password

echo -n "Service Name: "
read -r ServiceName

echo "[DEFAULT]
DBHost = ${DBHost}
dbauser = ${dbauser}
Password = ${Password}
ServiceName = ${ServiceName}">.config

sqlplus ${dbauser}/${Password}@${DBHost}:1521/${ServiceName} cleanup.sql
sqlplus ${dbauser}/${Password}@${DBHost}:1521/${ServiceName} install.sql