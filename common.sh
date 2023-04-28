app_user=roboshop
script=$(realpath "0")
script_path=$(dirname "$script")


print_head() {
echo -e "\e[35m>>>>>>>> $1 <<<<<<<<<\e[0m"
}

func_schema_setup() {
if [ "$schema_setup" == "mongo" ]; then
print_head "copy mongodb repo"
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo

func_print_head "install mongodb client"
yum install mongodb-org-shell -y


func_print_head "load schema"
mongo --host mongodb.devops1722.com </app/schema/${component}.js
fi
}

func_schema_setup() {
if [ "${schema_setup}" == "mysql" ]; then
func_print_head "install mysql"
yum install mysql -y 

func_print_head "load schema"
mysql -h mysql.devops1722.com -uroot -p${mysql_root_password} < /app/schema/shipping.sql 
fi
}


func_app_prereq() {
func_print_head "add application user" 
useradd ${app_user}


 func_print_head "create application directory" 
rm -rf /app
mkdir /app 


 func_print_head "download app content" 
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip 
cd /app 


func_print_head "unzip app content" 
unzip /tmp/${component}.zip
}

func_systemd_setup() {

func_print_head "copy systemd file" 
cp ${script_path}/${component}.service /etc/systemd/system/${component}.service


func_print_head "start ${component} service" 
systemctl daemon-reload
systemctl enable ${component}
systemctl start ${component}

}
func_nodejs() {

func_ print_head "configuring nodejs repos" 
curl -sL https://rpm.nodesource.com/setup_lts.x | bash


 func_print_head "install nodejs" 
yum install nodejs -y


func_app_prereq
 

func_ print_head "install nodejs dependencies" 
npm install 

func_schema_setup
func_systemd_setup



}

func_java() {

 func_print_head "install maven"
yum install maven -y


func_app_prereq

func_print_head "download maven dependencies"
mvn clean package 
mv target/${component}-1.0.jar ${component}.jar 

func_schema_setup
 

func_systemd_setup
}