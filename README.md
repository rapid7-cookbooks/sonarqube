# sonarqube cookbook
This cookbook installs and configures SonarQube and a Postgres database.

# Requirements
## Cookbooks

- java (>= 1.22.0)
- apt
- database
- postgresql
- nginx (= 2.4.2)
- openssl

## Platform:

- Ubuntu
- Debian

# Usage

Put the `recipe[sonarqube]` in your run list. It is recommended to create a
wrapper cookbook to configure your pg_hba.conf and firewall settings.

# Attributes
#### sonarqube::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Attribute Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['sonarqube']['version']</td></tt>
    <td>String</td>
    <td>default</td>
    <td>Version of SonarQube to install</td></tt>
    <td><tt>'4.2'</td></tt>
  </tr>
  <tr>
    <td><tt>['sonarqube']['apt']['repo']</td></tt>
    <td>String</td>
    <td>default</td>
    <td>Apt repository to use for obtaining the deb files.</td>
    <td><tt>'http://downloads.sourceforge.net/project/sonar-pkg/deb'</td></tt>
  </tr>
  <tr>
    <td><tt>['sonarqube']['apt']['components']</td></tt>
    <td>Array</td>
    <td>default</td>
    <td>Apt repository components to use for obtaining the deb files.</td>
    <td><tt>['binary/']</td></tt>
  </tr>
  <tr>
    <td><tt>['sonarqube']['path']</td></tt>
    <td>String</td>
    <td>default</td>
    <td>Base path where sonar is installed. Changing this does not change to where will be installed.</td>
    <td><tt>'/opt/sonar'</td></tt>
  </tr>
  <tr>
    <td><tt>['sonarqube']['jdbc']['username']</td></tt>
    <td>String</td>
    <td>default</td>
    <td>Username for sonar database connections.</td>
    <td><tt>'sonar'</td></tt>
  </tr>
  <tr>
    <td><tt>['sonarqube']['db']['name']</td></tt>
    <td>String</td>
    <td>default</td>
    <td>Database name for SonarQube.</td>
    <td><tt>'sonarqube'</td></tt>
  </tr>
  <tr>
    <td><tt>['sonarqube']['db']['host']</td></tt>
    <td>String</td>
    <td>default</td>
    <td>Host of Postgresql Database.</td>
    <td><tt>'localhost'</td></tt>
  </tr>
  <tr>
    <td><tt>['sonarqube']['jdbc']['url']</td></tt>
    <td>String</td>
    <td>default</td>
    <td>JDBC connection string</td>
    <td><tt>"jdbc:postgresql://#{node['sonarqube']['db']['host']}:#{node['postgresql']['config']['port']}/#{node['sonarqube']['db']['name']}?useUnicode=true&amp;characterEncoding=utf8"</td></tt>
  </tr>
  <tr>
    <td><tt>['sonarqube']['use_nginx']</td></tt>
    <td>Boolean</td>
    <td>default</td>
    <td>Configure Nginx reverse proxy</td>
    <td><tt>true</td></tt>
  </tr>
  <tr>
    <td><tt>['sonarqube']['nginx_template']</td></tt>
    <td>String</td>
    <td>default</td>
    <td>Template for nginx proxy configuration</td>
    <td><tt>'sonarqube_nginx.conf.erb'</td></tt>
  </tr>
  <tr>
    <td><tt>['sonarqube']['reverse_proxy_port']</td></tt>
    <td>Integer</td>
    <td>default</td>
    <td>Application port for SonarQube</td>
    <td><tt>9000</td></tt>
  </tr>
  <tr>
    <td><tt>['sonarqube']['wrapper']['jvm']['maxmemory']</td></tt>
    <td>Integer</td>
    <td>default</td>
    <td>Application port for SonarQube</td>
    <td><tt>2048</td></tt>
  </tr>
</table>
#### sonarqube::java
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Attribute Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['java']['install_flavor']</td></tt>
    <td>String</td>
    <td>override</td>
    <td>Java flavor to install. SonarQube officially only supports Oracle JVMs.<td>
    <td><tt>'oracle'</td></tt>
  </tr>
  <tr>
    <td><tt>['java']['oracle']['accept_oracle_download_terms']</td></tt>
    <td>Boolean</td>
    <td>override</td>
    <td>Accept terms and agreement for downloading Oracle JDK<td>
    <td><tt>true</td></tt>
  </tr>
</table>
#### sonarqube::nginx
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Attribute Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['nginx']['default_site_enabled']</td></tt>
    <td>Boolean</td>
    <td>override</td>
    <td>Enable/Disable default nginx site.<td>
    <td><tt>false</td></tt>
  </tr>
  <tr>
    <td><tt>['nginx']['client_max_body_size']</td></tt>
    <td>Integer</td>
    <td>override</td>
    <td>Set default max body size. This default is 0 to disable the max allowed size to ensure data submitted via the API does not get rejected.<td>
    <td><tt>0</td></tt>
  </tr>
</table>
#### sonarqube::postgresql
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Attribute Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['postgresql']['config']['listen_address']</td></tt>
    <td>String</td>
    <td>override</td>
    <td>Postgresql default listen address. The default is to listen on all interfaces/addresses as the SonarQube agent connects directly to the database via JDBC connections.<td>
    <td><tt>'0.0.0.0'</td></tt>
  </tr>
</table>

# Recipes
#### default
Includes all recipes. If `node[sonarqube][use_nginx]` is set to `false` the
`sonarqube::nginx` recipe will be excluded from the run_list.

#### database
Includes `sonarqube::postgresql`

Installs and configures postgresql to be used by SonarQube.

#### java
Installs Oracle JDK

#### nginx
If `node[sonarqube][use_nginx]` is set to `true` this recipe will be included
in the run_list and configure nginx as a reverse proxy for SonarQube.

#### postgresql
Installs postgresql and if `node['sonarqube']['jdbc']['password'] is not set it
will call `secure_password` from the openssl cookbook to automatically generate
one for you.

#### sonar
Adds the apt repository and installs sonar from apt. This recipe creates
the sonar.properties file and wrapper.conf. After installing sonar it will
enable and start the service.

####

# Author

Author:: Ryan Hass (<ryan_hass@rapid7.com>)
