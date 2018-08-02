#！/bin/bash
hostnamectl set-hostname mycentos
systemctl stop firewalld.service && systemctl disable firewalld.service
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
    "method": " xchacha20-ietf-poly1305"
}
EOF
ssserver -c /etc/shadowsocks.json -d start
