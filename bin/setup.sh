####################
localhost=127.0.0.1
domain=LOCAL.DO
external=eth0
internal=eth1
service=dns
####################
yum update -y
yum install -y firewalld
systemctl enable firewalld
systemctl restart firewalld
firewall-cmd --change-interface=$external --zone=external --permanent
firewall-cmd --change-interface=$internal --zone=internal --permanent
firewall-cmd --reload
####################
yum install -y bind bind-utils
systemctl enable named
firewall-cmd --add-service=$service --zone=internal --permanent
####################
cp -rv * /
sed -i "/^DNS1=/s/^DNS1=.*$/DNS1=$localhost/" /etc/sysconfig/network-scripts/ifcfg-$internal
sed -i "/^DOMAIN=/s/^DOMAIN=.*$/DOMAIN=$domain/" /etc/sysconfig/network-scripts/ifcfg-$internal
####################
init 6
####################

