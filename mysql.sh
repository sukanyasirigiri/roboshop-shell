script_path=$(dirname $0)
source ${script_path}/common.sh


dnf module disable mysql -y 
cp mysql.repo /etc/yum.repos.d/mysql.repo
yum install mysql-community-server -y
systemctl enable mysqld
systemctl start mysqld  
mysql_secure_installation --set-root-pass RoboShop@1