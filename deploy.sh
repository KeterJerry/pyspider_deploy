echo 'Change softwave source'
mv /etc/apt/sources.list /etc/apt/sources.list.bak
cat >>/etc/apt/sources.list<<EOF 
deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
EOF

echo 'update software'
apt update
apt-get install -y open-vm-tools open-vm-tools-desktop git
apt upgrade

echo 'install py3'
apt-get install -y python3-dev build-essential libssl-dev libxml2 libxml2-dev libxslt1-dev zlib1g-dev libcurl4-openssl-dev
apt-get install -y python3
apt-get install -y python3-pip

#Web spider is following
echo 'Configure spider environment'
pip3 install requests selenium aiohttp cchardet aiodns lxml beautifulsoup4 pyquery -i https://pypi.tuna.tsinghua.edu.cn/simple
wget https://github.com/mozilla/geckodriver/releases/download/v0.29.0/geckodriver-v0.29.0-linux64.tar.gz
tar -zxvf geckodriver-v0.29.0-linux64.tar.gz
mv geckodriver /usr/bin
apt-get install -y tesseract-ocr libtesseract-dev libleptonica-dev

echo 'Configure OCR'
git clone https://github.com/tesseract-ocr/tessdata.git
mkdir -p /usr/share/tesseract-ocr
mv tessdata /usr/share/tesseract-ocr

echo 'Configure MySQL'
apt-get install -y mysql-server mysql-client
mysqladmin -uroot -p password 123456
service mysql restart
pip3 install pymysql -i https://pypi.tuna.tsinghua.edu.cn/simple

echo 'Configure Redis'
apt-get -y install redis-server
sed -i 's/bind 127.0.0.1 ::1/# bind 127.0.0.1 ::1/g' /etc/redis/redis.conf
sed -i 's/# requirepass foobared/requirepass 123456/g' /etc/redis/redis.conf
/etc/init.d/redis-server restart
pip3 install redis -i https://pypi.tuna.tsinghua.edu.cn/simple
#RedisDump is not installed,Accroding to book Page 40

echo 'Configure Flask'
pip3 install flask -i https://pypi.tuna.tsinghua.edu.cn/simple

echo 'Configure Tornado'
pip3 install tornado -i https://pypi.tuna.tsinghua.edu.cn/simple

#APP spider is following
#=-=
#spider frame is following
echo 'Configure spider frame'
echo 'Configure pyspider'
pip3 install pyspider -i https://pypi.tuna.tsinghua.edu.cn/simple

echo 'Configure Scrapy'
pip3 install Scrapy -i https://pypi.tuna.tsinghua.edu.cn/simple

#something else is following
#echo 'Configure Docker'
#curl -sSl http://acs-public-mirror.oss-cn-hangzhou.aliyuncs.com/docker-engine/internet | sh -














