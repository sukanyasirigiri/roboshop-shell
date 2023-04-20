echo -e "\e[36m>>>>>>>> install python <<<<<<<<<\e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[36m>>>>>>>> add application user <<<<<<<<<\e[0m"
useradd roboshop


echo -e "\e[36m>>>>>>>> create app directory <<<<<<<<<\e[0m"
rm -rf /app
mkdir /app 

echo -e "\e[36m>>>>>>>> download app content <<<<<<<<<\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip 

echo -e "\e[36m>>>>>>>> extract app content <<<<<<<<<\e[0m"
cd /app 
unzip /tmp/payment.zip
