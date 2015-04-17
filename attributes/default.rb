default['sonarqube']['version'] = '4.4'
case node['platform_family']
when 'debian'
  default['sonarqube']['pkg']['uri'] = 'http://downloads.sourceforge.net/project/sonar-pkg/deb/binary/'
  default['sonarqube']['pkg']['checksum'] = 'f6d4c647c1280b8d3b146dbf78e32ca52b8a99e8809193d50d033bbe0b1606f0'
when 'rhel'
  default['sonarqube']['pkg']['uri'] = 'http://downloads.sourceforge.net/project/sonar-pkg/rpm/noarch/'
  default['sonarqube']['pkg']['checksum'] = '04650fd89d409d2e184edff9fc14568b11f9cc505064d1739401da8c1dc20454'
end

default['sonarqube']['path'] = '/opt/sonar'
default['sonarqube']['system']['user'] = 'sonar'
default['sonarqube']['system']['group'] = 'adm'

default['sonarqube']['jdbc']['username'] = 'sonar'

default['sonarqube']['http']['url'] = 'http://localhost'
default['sonarqube']['http']['port'] = 9000
default['sonarqube']['db']['name'] = 'sonarqube'
default['sonarqube']['db']['host'] = 'localhost'
default['sonarqube']['jdbc']['url'] = "jdbc:postgresql://#{node['sonarqube']['db']['host']}:#{node['postgresql']['config']['port']}/#{node['sonarqube']['db']['name']}?useUnicode=true&amp;characterEncoding=utf8"
default['sonarqube']['use_nginx'] = true
default['sonarqube']['wrapper']['jvm']['maxmemory'] = 2048
default['sonarqube']['runner']['version'] = '2.4'
default['sonarqube']['runner']['base_uri'] = 'http://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/'
default['sonarqube']['runner']['base_filename'] = 'sonar-runner-dist'
default['sonarqube']['runner']['archive_type'] = 'zip'
default['sonarqube']['runner']['checksum'] = 'f794545e23092c8b56d64d58ff571b2599480150b3fc41173b3761d634a16d48'
