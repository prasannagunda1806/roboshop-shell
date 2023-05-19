source common.sh

print_head "Installing Redis Repo files"
#Redis is offering the repo file as a rpm. Lets install it
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>${log_file}

print_head "Enable 6.2 redis repo"
dnf module enable redis:remi-6.2 -y &>>${log_file}
status_check $?

print_head "Installing Redis"
#Install Redis
yum install redis -y &>>${log_file}
status_check $?

print_head "Updatng listen address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf & /etc/redis/redis.conf  &>>${log_file}
status_check $?

print_head "Startiing redis"
#Start & Enable Redis Service
systemctl enable redis  &>>${log_file}
status_check $?

systemctl start redis   &>>${log_file}
status_check $?