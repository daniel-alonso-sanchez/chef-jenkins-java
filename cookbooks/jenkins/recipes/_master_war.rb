#
# Cookbook Name:: jenkins
# Recipe:: _master_war
#
# Author: AJ Christensen <aj@junglist.gen.nz>
# Author: Doug MacEachern <dougm@vmware.com>
# Author: Fletcher Nichol <fnichol@nichol.ca>
# Author: Seth Chisamore <schisamo@chef.io>
# Author: Seth Vargo <sethvargo@gmail.com>
#
# Copyright 2010, VMware, Inc.
# Copyright 2012-2014, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Create the Jenkins user
user node['jenkins']['master']['user'] do
  home node['jenkins']['master']['home']
  system node['jenkins']['master']['use_system_accounts'] # ~FC048
end

# Create the Jenkins group
group node['jenkins']['master']['group'] do
  members node['jenkins']['master']['user']
  system node['jenkins']['master']['use_system_accounts'] # ~FC048
end

# Create the home directory
directory node['jenkins']['master']['home'] do
  owner     node['jenkins']['master']['user']
  group     node['jenkins']['master']['group']
  mode      '0755'
  recursive true
end

# Create the log directory
directory node['jenkins']['master']['log_directory'] do
  owner     node['jenkins']['master']['user']
  group     node['jenkins']['master']['group']
  mode      '0755'
  recursive true
end

# Include runit to setup the service
include_recipe 'runit::default'

# Download the remote WAR file
save_http_proxy = Chef::Config[:http_proxy]
Chef::Config[:http_proxy] = "http://192.168.10.145:8080"

remote_file File.join(node['jenkins']['master']['home'], 'jenkins.war') do
  source   node['jenkins']['master']['source']
  checksum node['jenkins']['master']['checksum'] if node['jenkins']['master']['checksum']
  owner    node['jenkins']['master']['user']
  group    node['jenkins']['master']['group']
  notifies :restart, 'runit_service[jenkins]'
Chef::Config[:http_proxy] = save_http_proxy
end
Chef::Log.warn('Here we go with the runit service')
# Install a plugin from a given hpi (or jpi)
jenkins_plugin 'chucknorris' do
  source 'https://updates.jenkins-ci.org/latest/chucknorris.hpi'
end
jenkins_plugin 'git' do
  source 'http://updates.jenkins-ci.org/latest/git.hpi'
end
jenkins_plugin 'git-client' do
  source 'http://updates.jenkins-ci.org/latest/git-client.hpi'
end
jenkins_plugin 'scm-api' do
  source 'http://updates.jenkins-ci.org/latest/scm-api.hpi'
end
jenkins_plugin 'rebuild' do
  source 'http://updates.jenkins-ci.org/latest/rebuild.hpi'
end
jenkins_plugin 'jobConfigHistory' do
  source 'http://updates.jenkins-ci.org/latest/jobConfigHistory.hpi'
end
jenkins_plugin 'groovy' do
  source 'http://updates.jenkins-ci.org/latest/groovy.hpi'
end
jenkins_plugin 'job-dsl' do
  source 'http://updates.jenkins-ci.org/latest/job-dsl.hpi'
end
jenkins_plugin 'bitbucket' do
  source 'http://updates.jenkins-ci.org/latest/bitbucket.hpi'
end
jenkins_plugin 'plain-credentials' do
  source 'http://updates.jenkins-ci.org/latest/plain-credentials.hpi'
end
jenkins_plugin 'config-file-provider' do
  source 'http://updates.jenkins-ci.org/latest/config-file-provider.hpi'
end
jenkins_plugin 'token-macro' do
  source 'http://updates.jenkins-ci.org/latest/token-macro.hpi'
end
jenkins_plugin 'parameterized-trigger' do
  source 'http://updates.jenkins-ci.org/latest/parameterized-trigger.hpi'
end
jenkins_plugin 'clone-workspace-scm' do
  source 'http://updates.jenkins-ci.org/latest/clone-workspace-scm.hpi'
end
jenkins_plugin 'sonar' do
  source 'http://updates.jenkins-ci.org/latest/sonar.hpi'
end
# Create runit service
runit_service 'jenkins' do
  sv_timeout node['jenkins']['master']['runit']['sv_timeout']
end
