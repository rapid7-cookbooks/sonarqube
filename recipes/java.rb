#
# Cookbook Name:: sonarqube
# Recipe:: java
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

# Two java installations?! The upstream deb depends on 'java2-runtime'
# which is a virtual package. As such gdebi and others are unable to
# resolve the dependency. The better solution will be to do another
# refactor and just use the tarball.
if node['java']['install_flavor'] == 'oracle'
  include_recipe 'java::openjdk'
end

include_recipe 'java::default'

