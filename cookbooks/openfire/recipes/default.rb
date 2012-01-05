# -*- coding: utf-8 -*-

include_recipe "java"

# Automatically accept the Sun Java licence
script "accept-java-licence" do
  interpreter "bash"
  user "root"
  code <<-EOH
echo sun-java5-jdk shared/accepted-sun-dlj-v1-1 select true | /usr/bin/debconf-set-selections
echo sun-java5-jre shared/accepted-sun-dlj-v1-1 select true | /usr/bin/debconf-set-selections
echo sun-java6-jdk shared/accepted-sun-dlj-v1-1 select true | /usr/bin/debconf-set-selections
echo sun-java6-jre shared/accepted-sun-dlj-v1-1 select true | /usr/bin/debconf-set-selections
EOH
end

# Download the latest OpenFire server
remote_file "/vagrant/openfire_3.7.1_all.deb" do
  source "http://www.igniterealtime.org/downloadServlet?filename=openfire/openfire_3.7.1_all.deb"
  checksum "85f3aa1236945f606bdb135077c2243b"
  not_if "test -f /vagrant/openfire_3.7.1_all.deb"
end

# Install the OpenFire server"
execute "install-openfire" do
  command "sudo dpkg -i /vagrant/openfire_3.7.1_all.deb"
  action :run
end

service "openfire" do
  supports :start => true, :stop => true
  action [ :stop ]
end

# # Install the MySQL database
#include_recipe "mysql::server"
include_recipe "database"
#Gem.clear_paths

mysql_connection_info = {:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']}

mysql_database node['openfire'][:db][:database] do
  connection mysql_connection_info
  action :create
end

# create a mysql user but grant no priveleges
mysql_database_user node['openfire'][:db][:user] do
  connection mysql_connection_info
  password node['openfire'][:db][:password]
  action :create
end

mysql_database_user node['openfire'][:db][:user] do
  connection mysql_connection_info
  password node['openfire'][:db][:password]
  database_name node['openfire'][:db][:database]
  host "%"
  action :grant
end

execute "import database dump" do
  command "/usr/bin/mysql -u root -p#{node[:mysql][:server_root_password]} node['openfire'][:db][:database] < /vagrant/openfire.sql ; touch /vagrant/dump.complete"
  not_if "test -f /vagrant/dump.complete"
end

# Write the openfire configuration file
template "/etc/openfire/openfire.xml" do
  source "openfire.xml.erb"
  owner "openfire"
  group "openfire"
  variables({ :admin_port => 9090, :secure_port => 9091, :locale => "en"})
end

service "openfire" do
  supports :start => true, :stop => true
  action [ :stop ]
end

service "openfire" do
  supports :start => true, :stop => true
  action [ :start ]
end

script "wait-for-start" do
  interpreter "ruby"
  user "root"
  code <<-EOH
sleep 90
EOH
end
