sudo yum -y install git.x86_64 oracle-instantclient-release-el8.x86_64
cd
git clone https://github.com/yusukeyurameshi/Labs.git



echo "Hello, please introduce yourself."

echo -n "Your name: "
read -r name

echo "Are you human?"

echo -n "y/n: "
read -r human

echo "What is your favorite programming language?"

echo -n "Your answer: "
read -r lang

echo
echo "Answers:"
echo "1. $name"
echo "2. $human"
echo "3. $lang"