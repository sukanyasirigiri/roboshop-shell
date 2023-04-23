script=$(realpath "0")
script_path=$(dirname $0)
source ${script_path}/common.sh

component=catalogue
func_nodejs

echo -e "\e[36m>>>>>>>> copy mongodb repo <<<<<<<<<\e[0m"
cp ${script_path}/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>>> install mongodb client <<<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m>>>>>>>> load schema <<<<<<<<<\e[0m"
mongo --host mongodb.devops1722.com </app/schema/catalogue.js