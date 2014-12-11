#
# Cookbook Name:: nexpose
# Recipe:: runner
#
# Copyright (C) 2013-2014, Rapid7, LLC.
# License:: Apache License, Version 2.0
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

require_relative '../../spec_helper'

describe 'sonarqube::runner' do
  cached(:chef_run) do 
    ChefSpec::SoloRunner.new do |node|
      node.set['postgresql']['config']['port'] = 5432
    end.converge(described_recipe)
  end

  let(:execute_resource) { chef_run.execute('unzip-runner') }
  let(:archive_name) { "#{chef_run.node['sonarqube']['runner']['base_filename']}-#{chef_run.node['sonarqube']['runner']['version']}.#{chef_run.node['sonarqube']['runner']['archive_type']}" }
  let(:template_file) { (::File.join(chef_run.node['sonarqube']['path'], "sonar-runner-#{chef_run.node['sonarqube']['runner']['version']}", 'conf', 'sonar-runner.properties')) }

  it 'downloads the zip archive' do
    expect(chef_run).to create_remote_file(::File.join(Chef::Config['file_cache_path'], archive_name)).with(checksum: chef_run.node['sonarqube']['runner']['checksum'])
  end

  it 'installs unzip' do
    expect(chef_run).to install_package('unzip')
  end

  it 'creates an unzip-runner resource' do
    expect(execute_resource).to do_nothing
  end

  it 'extracts the zip archive' do
    remote_file_resource = chef_run.remote_file(::File.join(Chef::Config['file_cache_path'], archive_name))
    expect(chef_run).to install_package('unzip')
    expect(remote_file_resource).to notify('package[unzip]').to(:install).immediately
    expect(remote_file_resource).to notify('execute[unzip-runner]').to(:run).immediately
  end

  it 'configures the sonar-runner application' do
    expect(chef_run).to create_template(template_file).with(
      source: 'sonar-runner.properties.erb',
      user: chef_run.node['sonarqube']['system']['user'],
      group: chef_run.node['sonarqube']['system']['group'],
      mode: 0640
    )
    expect(chef_run).to render_file(template_file).with_content(/^sonar.host.url=http:\/\/localhost:#{chef_run.node['sonarqube']['reverse_proxy_port']}$/)
    expect(chef_run).to render_file(template_file).with_content(/^sonar.jdbc.username=#{chef_run.node['sonarqube']['jdbc']['username']}$/)
  end
end
