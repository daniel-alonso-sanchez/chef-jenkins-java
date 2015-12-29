# chef-jenkins-java

Chef repo with recipes for managing installations of jenkins with oracle java 8

At this moment, it adds basic security with the user 'admin' and installs the following list of plugins

 * git
 * git-client
 * scm-api
 * rebuild
 * jobConfigHistory
 * plugin-usage-plugin
 * credentials
 * groovy
 * job-dsl
 * bitbucket
 * plain-credentials
 * config-file-provider
 * token-macro
 * parameterized-trigger
 * clone-workspace-scm
 * chucknorris 
 * sonar

In order to run the installation, this command should be used

```
knife bootstrap jenkins.ubuntu.local --ssh-user ubuntu --ssh-password 'server' --ssh-port 2222 --sudo --use-sudo-password --node-name jenkins.ubuntu.local --run-list 'recipe[java],recipe[jenkins::master]' -j '{"java":{"install_flavor":"oracle"},"jenkins":{ "admin":{"name":"admin","password":"admin"},"master":{"install_method":"package"}}}' --bootstrap-proxy http://192.168.10.145:8080 --bootstrap-no-proxy chef.ubuntu.local,localhost,127.0.0.1
```