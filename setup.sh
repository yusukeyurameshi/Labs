sudo yum -y install git.x86_64 oracle-instantclient-release-el8.x86_64 
sudo yum -y install oracle-instantclient-basic.x86_64 oracle-instantclient-sqlplus.x86_64
cd
git clone https://github.com/yusukeyurameshi/Labs.git

cd Labs

echo -n "DB Host: "
read -r DBHost

echo -n "DBA User: "
read -r dbauser

echo -n "Password: "
read -r Password


echo "[DEFAULT]
DBHost = ${DBHost}
dbauser = ${dbauser}
Password = ${Password}">.config