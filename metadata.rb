name             'sonarqube'
maintainer       'Ryan Hass'
maintainer_email 'ryan_hass@rapid7.com'
license          'Apache 2.0'
description      'Installs/Configures sonarqube'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'java', '>= 1.22.0'
depends 'apt', '>= 2.3.8'
depends 'database', '>= 2.1.2'
depends 'postgresql', '>= 3.3.4'
depends 'nginx', '>= 2.5.0'
depends 'openssl'
