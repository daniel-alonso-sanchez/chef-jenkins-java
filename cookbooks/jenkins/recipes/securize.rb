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