#
# Cookbook:: apache
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reservedi.

package ‘httpd’ do
action :install
end
file ‘/var/www/html/index.html’ do
content ‘<h1>Hello World</h1>’
action :create
end
service ‘httpd’ do
action [:enable, :start]
end
