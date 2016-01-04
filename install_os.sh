rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
#install guest additions
#yum -y groupinstall "Development Tools"
#yum -y install kernel-devel
#yum -y install dkms
#yum -y install git-all memcached postgresql-devel postgresql-server \
#libxml2-devel libxslt-devel gcc-c++ patch
# install packages
yum -y install git-all                            # Git and components
yum -y install memcached                          # Memcached for the session store
yum -y install postgresql-devel postgresql-server # PostgreSQL Database server and to build 'pg' Gem
yum -y install libxml2-devel libxslt-devel patch  # For Nokogiri Gem
yum -y install gcc-c++                            # For event-machine Gem
yum -y install bash-completion chrony deltarpm vim wget bzip2

# Enable Memcached
systemctl enable memcached
systemctl start memcached

# install some requisites for rbenv
yum install -y openssl-devel readline-devel

#needed for manageiq
yum install -y graphviz-devel graphviz-ruby

cd /tmp
wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
tar -xzvf chruby-0.3.9.tar.gz
cd chruby-0.3.9/
sudo make install

cd /tmp 
wget -O ruby-install-0.6.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.6.0.tar.gz 
tar -xzvf ruby-install-0.6.0.tar.gz 
cd ruby-install-0.6.0
make install