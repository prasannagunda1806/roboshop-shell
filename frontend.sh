code_dir=$(pwd)

log_file=/tmp/roboshop.log

status_check(){
    if [ $1 != 0 ]; then
    echo "Success"
    else
    echo "Failure. refer {log_file} for more details"
    fi
    exit 1
}

print_head(){
    echo -e "\e[31m$1\e[0m"
}

print_head "Insalling Nginx"
yum install nginx -y &>>${log_file}
status_check $?

print_head "enabling nginx" 
systemctl enable nginx &>>${log_file}

print_head "starting nginx"
systemctl start nginx &>>${log_file}
status_check $?status_check $?

print_head "removing existing files"
rm -rf /usr/share/nginx/html/* &>>${log_file}
status_check $?

print_head "downloading frontend zip file and copy to respectivve dir" 
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log_file}
cd /usr/share/nginx/html &>>${log_file}
unzip /tmp/frontend.zip &>>${log_file}
status_check $?

cp ${code_dir}/configs/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_file}
print_head "restarting nginx" 
systemctl restart nginx &>>${log_file}
status_check $?
##sysemd service config files need to be addedcode_dir=$(pwd)
