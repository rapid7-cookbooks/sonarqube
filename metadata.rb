name             'sonarqube'
maintainer       'Ryan Hass'
maintainer_email 'ryan_hass@rapid7.com'
license          'Apache 2.0'
description      'Installs/Configures sonarqube'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.8'

supports 'ubuntu'

depends 'java', '>= 1.22.0'
depends 'apt'
depends 'database'
depends 'postgresql'
depends 'nginx', '= 2.4.2'
depends 'openssl'
