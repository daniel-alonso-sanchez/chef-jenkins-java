template "#{node['jenkins']['master']['home']}/config.xml" do
    source   'jenkins-config.xml.erb'
    mode     '0644'  
    owner 'jenkins'
    group 'jenkins'	
end
directory "#{node['jenkins']['master']['home']}/users/admin" do
  owner 'jenkins'
  group 'jenkins'
  mode '0751'
  recursive true
  action :create
end
template "#{node['jenkins']['master']['home']}/users/admin/config.xml" do
    source   'jenkins-admin-config.xml.erb'
    mode     '0644'  
    owner 'jenkins'
    group 'jenkins'	
end