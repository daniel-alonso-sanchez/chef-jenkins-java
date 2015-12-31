template "#{node['jenkins']['master']['home']}/config.xml" do
    source   'jenkins-config.xml.erb'
    mode     '0644'  
    owner 'jenkins'
    group 'jenkins'	
end
directory "#{node['jenkins']['master']['home']}/users" do
  owner 'jenkins'
  group 'jenkins'
  mode '0755' 
  action :create
end
directory "#{node['jenkins']['master']['home']}/users/admin" do
  owner 'jenkins'
  group 'jenkins'
  mode '0755' 
  action :create
end
template "#{node['jenkins']['master']['home']}/users/admin/config.xml" do
    source   'jenkins-admin-config.xml.erb'
    mode     '0644'  
    owner 'jenkins'
    group 'jenkins'	
	notifies :restart, 'service[jenkins]', :immediately
end