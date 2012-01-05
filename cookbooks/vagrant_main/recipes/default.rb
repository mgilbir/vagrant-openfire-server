#
# Cookbook Name:: vagrant_main
# Recipe:: default
#

include_recipe "timezone"
include_recipe "mysql::client"
include_recipe "mysql::server"
include_recipe "openfire"
