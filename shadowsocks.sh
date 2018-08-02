#！/bin/bash
hostnamectl set-hostname mycentos
systemctl stop firewalld.service && systemctl disable firewalld.service
yum update -y
yum install -y git
yum install python-setuptools && easy_install pip
pip install git+https://github.com/shadowsocks/shadowsocks.git@master
cat > /etc/shadowsocks.json  << EOF
{
    "server": "0.0.0.0",
    "port_password": {
        "8381": "123456",
        "8382": "123456",
        "8383": "123456",
        "8384": "123456"
    },
    "timeout": 300,
    "method": "aes-256-cfb"
}
EOF
nohup ssserver -c /etc/shadowsocks.json -d start
