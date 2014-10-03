#
# Cookbook Name:: sonarqube
# Recipe:: nginx
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

include_recipe 'nginx'

if node['sonarqube']['http']['ssl']['enabled']
  ssl_data_bag = SonarQube::Helpers.load_data_bag(
    node['sonarqube']['http']['ssl']['cert_databag'],
    node['sonarqube']['http']['ssl']['cert_databag_item']
  )

  # Public key.
  file "/etc/ssl/certs/#{node['sonarqube']['http']['host_name']}.crt" do
    mode 0644
    user 'root'
    group 'root'
    content "#{ssl_data_bag['cert']}"
    notifies :reload, 'service[nginx]', :delayed
  end

  # Private key.
  file "/etc/ssl/private/#{node['sonarqube']['http']['host_name']}.key" do
    mode 0600
    user 'root'
    group 'root'
    content "#{ssl_data_bag['key']}"
    notifies :reload, 'service[nginx]', :delayed
  end
end

template ::File.join(node['nginx']['dir'], 'sites-available', 'sonarqube') do
  source node['sonarqube']['nginx_template']
  notifies :reload, 'service[nginx]', :delayed
  mode 0644
  owner 'root'
  group 'root'
  action :create
  variables(
    :host_name          => node['sonarqube']['http']['host_name'],
    :host_aliases       => node['sonarqube']['http']['host_aliases'] || [],
    :ssl_enabled        => node['sonarqube']['http']['ssl']['enabled'],
    :redirect_http      => node['sonarqube']['http']['ssl']['enabled'],
    :listen_port        => node['sonarqube']['http']['port'],
    :ssl_listen_port    => node['sonarqube']['http']['ssl']['port'],
    :reverse_proxy_port => node['sonarqube']['reverse_proxy_port']
  )
end

nginx_site 'sonarqube' do
  default_server true
end
