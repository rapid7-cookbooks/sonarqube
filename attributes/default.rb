default['sonarqube']['version'] = '4.5'
default['sonarqube']['apt']['repo'] = 'http://downloads.sourceforge.net/project/sonar-pkg/deb'
default['sonarqube']['apt']['components'] = ['binary/']
default['sonarqube']['path'] = '/opt/sonar'

default['sonarqube']['jdbc']['username'] = 'sonar'

default['sonarqube']['db']['name'] = 'sonarqube'
default['sonarqube']['db']['host'] = 'localhost'
default['sonarqube']['jdbc']['url'] = "jdbc:postgresql://#{node['sonarqube']['db']['host']}:#{node['postgresql']['config']['port']}/#{node['sonarqube']['db']['name']}?useUnicode=true&amp;characterEncoding=utf8"
default['sonarqube']['use_nginx'] = true
default['sonarqube']['wrapper']['jvm']['maxmemory'] = 2048
