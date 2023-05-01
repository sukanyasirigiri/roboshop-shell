script=$(realpath "0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
mysql_root_password=$1 

if [ -z "$mysql_root_password" ]; then 
echo input mysql root password missing
exit 
fi

 

print_head "Disable Mysql 8 version"
dnf module disable mysql -y &>>$log_file
func_stat_check $?


print_head "copy MySQL repo file"
cp ${script_path}/mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
func_stat_check $?


print_head "install Mysql"
yum install mysql-community-server -y &>>$log_file
func_stat_check $?


print_head "start mysql"
systemctl enable mysqld &>>$log_file
systemctl restart mysqld &>>$log_file
func_stat_check $?


print_head "reset mysql password"
mysql_secure_installation --set-root-pass $mysql_root_password &>>$log_file
func_stat_check $?
