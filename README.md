# chef-jenkins-java
Chef repo with jenkins and oracle java recipes
knife bootstrap jenkins.ubuntu.local --ssh-user ubuntu --ssh-password 'server' --ssh-port 2222 --sudo --use-sudo-password --node-name jenkins.ubuntu.local --run-list 'recipe[java],recipe[jenkins::master]' -j '{"java":{"install_flavor":"oracle"},"jenkins":{"master":{"install_method":"package"}}}' --bootstrap-proxy http://192.168.10.145:8080 --bootstrap-no-proxy chef.ubuntu.local,localhost,127.0.0.1
