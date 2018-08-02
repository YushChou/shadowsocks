#！/bin/bash
hostnamectl set-hostname mycentos
systemctl stop firewalld.service && systemctl disable firewalld.service
yum update -y
yum install python-setuptools && easy_install pip
pip install git+https://github.com/shadowsocks/shadowsocks.git@master
cat > /etc/shadowsocks.json  << EOF
{
    "server": "0.0.0.0",
    "port_password": {
        "8381": "password1",
        "8382": "password2",
        "8383": "password3",
        "8384": "password4"
    },
    "timeout": 300,
    "method": "aes-256-cfb"
}
EOF
nohub ssserver -c /etc/shadowsocks.json -d start
