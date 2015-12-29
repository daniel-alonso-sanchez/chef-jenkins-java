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

