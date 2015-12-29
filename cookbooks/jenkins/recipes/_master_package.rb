#
# Cookbook Name:: jenkins
# Recipe:: _master_package
#
# Author: Guilhem Lettron <guilhem.lettron@youscribe.com>
# Author: Seth Vargo <sethvargo@gmail.com>
#
# Copyright 2013, Youscribe
# Copyright 2014, Chef Software, Inc.
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

case node['platform_family']
when 'debian'
  include_recipe 'apt::default'

  apt_repository 'jenkins' do
    uri          node['jenkins']['master']['repository']
    distribution 'binary/'
    key          node['jenkins']['master']['repository_key']
    unless node['jenkins']['master']['repository_keyserver'].nil?
      keyserver    node['jenkins']['master']['repository_keyserver']
    end
  end

  package 'jenkins' do
    version node['jenkins']['master']['version']
  end

  template '/etc/default/jenkins' do
    source   'jenkins-config-debian.erb'
    mode     '0644'
    notifies :restart, 'service[jenkins]', :immediately
  end
when 'rhel'
  include_recipe 'yum::default'

  yum_repository 'jenkins-ci' do
    baseurl node['jenkins']['master']['repository']
    gpgkey  node['jenkins']['master']['repository_key']
  end

  package 'jenkins' do
    version node['jenkins']['master']['version']
  end

  # The package install creates the Jenkins user so now is the time to set the home
  # directory permissions.
  directory node['jenkins']['master']['home'] do
    owner     node['jenkins']['master']['user']
    group     node['jenkins']['master']['group']
    mode      '0755'
    recursive true
  end

  template '/etc/sysconfig/jenkins' do
    source   'jenkins-config-rhel.erb'
    mode     '0644'
    notifies :restart, 'service[jenkins]', :immediately
  end
end

service 'jenkins' do
  supports status: true, restart: true, reload: true
  action  [:enable, :restart]
end
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
jenkins_script 'activate global security' do
  command <<-EOH.gsub(/^ {4}/, '')
      import jenkins.model.*
      import hudson.security.*
      // Get access to the jenkins instance
      def instance = Jenkins.getInstance()
      // Activate clobal seufiry with internal hudsonRealm
      def hudsonRealm = new HudsonPrivateSecurityRealm(false)
      instance.setSecurityRealm(hudsonRealm)
      // Create an admin account
      hudsonRealm.createAccount("#{node['jenkins']['admin']['name']}", "#{node['jenkins']['admin']['password']}")
      // Activate matrix seurity and add admin user
      def strategy = new GlobalMatrixAuthorizationStrategy()
      strategy.add(Jenkins.ADMINISTER, "#{node['jenkins']['admin']['name']}")
      instance.setAuthorizationStrategy(strategy)
      
      instance.save()
  EOH
end
