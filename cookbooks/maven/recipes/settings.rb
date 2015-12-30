#
# Cookbook Name:: maven
# Recipe:: default
#
# Author:: Pushkar Raste (<pushkar.raste@gmail.com>)
#
# Copyright:: 2014, Opscode, Inc.
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

# install gems required for updating settings

 proxies = data_bag( 'proxies', )
  proxies.each do |proxy|  
      daproxy = data_bag_item("proxies", proxy)
	  excludedOnes=daproxy['proxy_exclude'].tr(",", "|")
	  template "#{ENV['M2_HOME']}/conf/settings.xml" do
		variables( :proxy_host => daproxy['proxy_host'],:proxy_port => daproxy['proxy_port'],:proxy_exclude => excludedOnes )
		source 'settings.xml.erb'
		mode   '0755'
	  end
  end