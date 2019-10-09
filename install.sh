#!/bin/bash
#0.购买centos系统的vps，查看是否是centos系统
cat /proc/version
#1.删除旧版本依赖库
rm -rf libsodium-* mbedtls-* simple-obfs shadowsocks-libev
#2.安装依赖包
yum install epel-release git gcc vim -y
yum install -y wget gettext autoconf libtool automake make asciidoc xmlto zlib-devel libev-devel c-ares-devel pcre-devel libsodium-devel mbedtls-devel

 

#3 shadowsocks-libev 服务端软件
 git clone --recursive https://github.com/shadowsocks/shadowsocks-libev.git;
pushd shadowsocks-libev;
./autogen.sh;
./configure --prefix=/usr && make ;
make install;

#4 shadowsocks-libev 配置文件
mkdir /etc/shadowsocks;
cat <<-EOF > /etc/shadowsocks/ss.json
{
        "server":"0.0.0.0",
        "server_port":1521,
        "local_port":1080,
        "password":"123456",
        "timeout":60,
        "method":"aes-256-gcm"
}
EOF

#6.启动
  setsid ss-server -c /etc/shadowsocks/ss.json -u &

}
  
echo 'install OK !';
