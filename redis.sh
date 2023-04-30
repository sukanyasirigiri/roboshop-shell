
script=$(realpath "0")
script_path=$(dirname "$script")
source ${script_path}/common.sh




print_head "Install redis repos"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>$log_file
func_stat_check $?


print_head "install redis"
dnf module enable redis:remi-6.2 -y &>>$log_file
yum install redis -y 
func_stat_check $?

print_head "update redis listen adress"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/redis.conf &>>$log_file
func_stat_check $?

print_head "start redis service"
systemctl enable redis &>>$log_file
systemctl start redis &>>$log_file
func_stat_check $?