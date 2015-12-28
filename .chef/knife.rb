# See https://docs.getchef.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "masterchef"
client_key               "#{current_dir}/masterchef.pem"
validation_client_name   "etg-validator"
validation_key           "#{current_dir}/etg-validator.pem"
chef_server_url          "https://chef.ubuntu.local:10443/organizations/etg"
cookbook_path            ["#{current_dir}/../cookbooks"]
http_proxy 				 "http://192.168.10.145:8080"
https_proxy 		     "http://192.168.10.145:8080"
no_proxy                 "chef.ubuntu.local"
