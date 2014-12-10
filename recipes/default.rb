#
# Cookbook Name:: sonarqube
# Recipe:: default
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

include_recipe 'apt::default'
include_recipe 'sonarqube::java'
# If SSL is enabled, we want to ensure the keys are dropped before the
# database recipe is called to ensure postgresql can use the cert/key.
if node['sonarqube']['use_nginx']
  include_recipe 'sonarqube::nginx'
end
include_recipe 'sonarqube::database'
include_recipe 'sonarqube::sonar'
