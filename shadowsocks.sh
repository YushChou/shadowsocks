#!/bin/bash
#this is a shadowsocks shell
hostnamectl set-hostname ssserver
yum update -y
yum install -y git epel-release libsodium python34-pip
yum install python-setuptools && easy_install pip
pip3 install  git+https://github.com/shadowsocks/shadowsocks.git@master
cat > /etc/shadowsocks.json  << EOF
{
    "server": "0.0.0.0",
    "port_password": {
        "8728": "123456",
        "8729": "123456",
        "8730": "123456",
        "8731": "123456"
    },
    "timeout": 300,
    "method": "xchacha20-ietf-poly1305"
}
EOF
firewall-cmd --zone=public --add-port=8728-8731/tcp --permanent
firewall-cmd reloa
ssserver -c /etc/shadowsocks.json -d start
#获取安装信息
get_ip=$(ip a | grep ens33 | grep inet | awk '{print $2}' |sed 's/\/.*//')
shadowsocks_port_pwd=$(sed -n '4,7p' /etc/shadowsocks.json | sed 's/^[ \t]*//g')
shadowsockscipher=$(awk -F \" '/method/ {print $4}' /etc/shadowsocks.json)
echo " " > serverinfo.txt
echo -e "Shadowsocks server install completed!" >> serverinfo.txt
echo " " >> serverinfo.txt
echo -e "Your server ip： \n$get_ip" >> serverinfo.txt
echo " " >> serverinfo.txt
echo -e "Your Server Port and password：\n$shadowsocks_port_pwd" >> serverinfo.txt
echo " " >> serverinfo.txt
echo -e "Your Encryption Method: \n$shadowsockscipher" >> serverinfo.txt
cat serverinfo.txt
echo
echo -e 'see this info again run the follow command \n# cat serverinfo.txt'
echo


