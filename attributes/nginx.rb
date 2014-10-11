override['nginx']['default_site_enabled'] = false
override['nginx']['client_max_body_size'] = 0

default['sonarqube']['nginx_template'] = 'sonarqube_nginx.conf.erb'
default['sonarqube']['reverse_proxy_port'] = 9000

default['sonarqube']['http']['host_name'] = node['fqdn']
default['sonarqube']['http']['host_aliases'] = []
default['sonarqube']['http']['port'] = 80
default['sonarqube']['http']['ssl']['port'] = 443
default['sonarqube']['http']['ssl']['enabled'] = false
default['sonarqube']['http']['ssl']['cert_databag'] = 'sonarqube'
default['sonarqube']['http']['ssl']['cert_databag_item'] = 'ssl_cert'
default['sonarqube']['http']['ssl']['cert_owner'] = 'root'
default['sonarqube']['http']['ssl']['cert_group'] = 'ssl-cert'
