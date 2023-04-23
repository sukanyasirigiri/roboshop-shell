app_user=roboshop
script_path=$(dirname $0)
source ${script_path}/common.sh

print_head() {
echo -e "\e[35m>>>>>>>> $1 <<<<<<<<<\e[0m"
}
func_nodejs() {


 print_head "configuring nodejs repos" 
curl -sL https://rpm.nodesource.com/setup_lts.x | bash


 print_head "install nodejs" 
yum install nodejs -y



 print_head "add application user" 
useradd ${app_user}


 print_head "create application directory" 
rm -rf /app
mkdir /app 


 print_head "download app content" 
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip 
cd /app 


print_head "unzip app content" 
unzip /tmp/${component}.zip


 print_head "install nodejs dependencies" 
npm install 


print_head "copy user systemd file" 
cp ${script_path}/${component}.service /etc/systemd/system/${component}.service


 print_head "start cart service" 
systemctl daemon-reload
systemctl enable ${component}
systemctl start ${component}

}