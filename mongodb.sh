source common.sh


print_head "Copying mongo db repo file"

cp ${code_dir}/configs/mongodb.repo /etc/yum.repos.d/mongo.repo &>>${log_file}
status_check $?

print_head "installing pkg"
yum install mongodb-org -y &>>${log_file}
status_check $?

#sed -i -e 's/127.0.0.1/0.0.0.1/' /etc/mongodb.conf &>>$log_file}
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>${log_file}
print_head "Updated listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf"
status_check $?


print_head "eenablng mongodb"
systemctl enable mongod &>>${log_file}
status_check $?

print_head "Startng mongo db"
systemctl start mongod &>>${log_file}
status_check $?

print_head "Restarting mongodb"
systemctl restart mongod &>>{log_file}
status_check $?
