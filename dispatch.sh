source common.sh

print_head "Installing Golang"
yum install golang -y &>>${log_file}
status_check $?

app_prereq_setup

print_head "downloading the dependencies & build the software"
go mod init dispatch &>>${log_file}
status_check $?

go get &>>${log_file}
status_check $?

go build  &>>${log_file}
status_check $?

#systemd setup
systemd_setup
status_check $?

#schema setup
schema_setup
status_check $?

