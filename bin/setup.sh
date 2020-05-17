####################
localhost=127.0.0.1
domain=LOCAL.DO
external=eth0
internal=eth1
service=dns
####################
sudo yum update -y
sudo yum install -y firewalld
sudo systemctl enable firewalld
sudo systemctl restart firewalld
sudo firewall-cmd --change-interface=$external --zone=external --permanent
sudo firewall-cmd --change-interface=$internal --zone=internal --permanent
sudo firewall-cmd --reload
####################
sudo yum install -y bind bind-utils
sudo systemctl enable named
sudo firewall-cmd --add-service=$service --zone=internal --permanent
####################
sudo cp -rv * /
sudo sed -i "/^DNS1=/s/^DNS1=.*$/DNS1=$localhost/" /etc/sysconfig/network-scripts/ifcfg-$internal
sudo sed -i "/^DOMAIN=/s/^DOMAIN=.*$/DOMAIN=$domain/" /etc/sysconfig/network-scripts/ifcfg-$internal
####################
sudo init 6
####################

