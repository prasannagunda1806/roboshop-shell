code_dir=$(pwd)

log_file=/tmp/roboshop.log

print_head(){
    echo -e "\e[32m$1\e[0m"
}

status_check(){
    if [ 0 -eq = 0 ]; then
      echo "Success"
     else
       echo "Failure , please refer roboshop.log file for more details"
       fi
       }


print_head "Copying mongo db repo file"
#copy ongo db repo fle
cp ${code_dir}/configs/mongodbb.repo /etc/yum.repos.d/mongo.repo $>>{log_file}
status_check $?

print_head "installing pkg"
yum install mongodb-org -y $>>{log_file}
status_check $?

print_head "eenablng mongodb"
systemctl enable mongod $>>{log_file}
status_check $?

print_head "Startng mongo db"
systemctl start mongod $>>{log_file}
status_check $?

print_head "Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf"
sed -i -e "/12.0.0.0/0.0.0.0" /etc/mongodb.conf
status_check $?

print_head "Restarting mongodb"
systemctl restart mongod $>>{log_file}
status_check $?