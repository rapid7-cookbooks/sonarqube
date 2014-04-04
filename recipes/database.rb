#
# Cookbook Name:: sonarqube
# Recipe:: database
#
# Copyright (C) 2014 Ryan Hass
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'sonarqube::postgresql'

pg_connection = { :host => node['postgresql']['config']['listen_addresses'],
                  :port => node['postgresql']['config']['port'],
                  :username => 'postgres',
                  :password => node['postgresql']['password']['postgres'] }

# Create postgresql database for sonarqube.
postgresql_database node['sonarqube']['db']['name'] do
  connection pg_connection
  encoding 'utf8'
  #owner node['sonarqube']['jdbc']['username']
  action :create
end

# Crate postgresql role
postgresql_database_user node['sonarqube']['jdbc']['username'] do
  connection pg_connection
  password node['sonarqube']['jdbc']['password']
  database_name node['sonarqube']['db']['name']
  action :create
end

