template "#{node['jenkins']['master']['home']}/config.xml" do
    source   'config.xml.erb'
    mode     '0644'   
end