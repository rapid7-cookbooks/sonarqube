#
# Cookbook Name:: sonarqube
# Recipe:: runner
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

archive_name = "#{node['sonarqube']['runner']['base_filename']}-#{node['sonarqube']['runner']['version']}.#{node['sonarqube']['runner']['archive_type']}"
download_uri = "#{node['sonarqube']['runner']['base_uri']}/#{node['sonarqube']['runner']['version']}/#{archive_name}"

package 'unzip'

remote_file ::File.join(Chef::Config['file_cache_path'], archive_name) do
  source download_uri
  checksum node['sonarqube']['runner']['checksum']
  notifies :install, 'package[unzip]', :immediately
  notifies :run, 'execute[unzip-runner]', :immediately
end

execute 'unzip-runner' do
  command "unzip -o #{::File.join(Chef::Config['file_cache_path'], archive_name)} -d #{node['sonarqube']['path']}"
  action :nothing
end

template ::File.join(node['sonarqube']['path'], "sonar-runner-#{node['sonarqube']['runner']['version']}", 'conf', 'sonar-runner.properties') do
  source 'sonar-runner.properties.erb'
  owner node['sonarqube']['system']['user']
  group node['sonarqube']['system']['group']
  mode 0640
  variables ({
    :host_url   => "#{node['sonarqube']['http']['url']}:#{node['sonarqube']['http']['port']}",
    :jdbc_url   => node['sonarqube']['jdbc']['url'],
    :jdbc_user  => node['sonarqube']['jdbc']['username'],
    :jdbc_pass  => node['sonarqube']['jdbc']['password']
  })
end


