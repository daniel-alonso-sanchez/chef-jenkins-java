template "#{node['jenkins']['master']['home']}/config.xml" do
    source   'jenkins-config.xml.erb'
    mode     '0644'  
    owner 'jenkins'
    group 'jenkins'	
end