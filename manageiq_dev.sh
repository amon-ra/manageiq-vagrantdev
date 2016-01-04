# Configure PostgresSQL
echo "smartvm" |sudo passwd --stdin postgres 
sudo su postgres -c 'initdb -D /var/lib/pgsql/data'
sudo systemctl enable postgresql
sudo systemctl start postgresql
sudo su postgres -c "psql -c \"CREATE ROLE root SUPERUSER LOGIN PASSWORD 'smartvm'\""



#configure ruby version
echo source /usr/local/share/chruby/chruby.sh >> ~/.bashrc
echo source /usr/local/share/chruby/auto.sh >> ~/.bashrc
echo chruby ruby-2.2 >> ~/.bashrc
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
cd manageiq
echo "continuing in manageiq/"

#Configure ruby
ruby-install ruby 2.2
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
chruby ruby-2.2
gem install bundler
gem install nokogiri -v '1.6.6.2'
cd ~/manageiq
echo "continuing in manageiq/"
bundle install



#Copy the development keys to place
#Security risk, don't do this in production
cp /home/vagrant/manageiq/certs/v2_key.dev  /home/vagrant/manageiq/certs/v2_key


#Configure the database
echo "Configuring the database"
cp config/database.pg.yml config/database.yml
bundle exec rake evm:db:reset
bundle exec rake db:seed

# Start the service
echo "starting the service. You can access it as 127.0.0.1:3000 admin/smartvm"
bundle exec rake evm:start
